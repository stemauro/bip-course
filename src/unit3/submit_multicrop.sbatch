#!/usr/bin/env bash

#SBATCH --account=training2504
#SBATCH --partition=dc-gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=8
# Use only physical cores. (Can use up to 2 threads per core.)
#SBATCH --threads-per-core=1
#SBATCH --time=00:15:00
# Slurm logs destination path
#SBATCH --output="${HOME}/bip-course/slurm-%j.out"
#SBATCH --error="${HOME}/bip-course/slurm-%j.err"

project_root_dir="${HOME}/bip-course/bip"
cd "${project_root_dir}"

# Propagate the specified number of CPUs per task to each `srun`.
export SRUN_CPUS_PER_TASK="$SLURM_CPUS_PER_TASK"

source "${project_root_dir}/scripts/activate.sh"

export MASTER_ADDR="$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)"
if [ "$SYSTEMNAME" = juwelsbooster ] \
       || [ "$SYSTEMNAME" = juwels ] \
       || [ "$SYSTEMNAME" = jurecadc ] \
       || [ "$SYSTEMNAME" = jusuf ]; then
    # Allow communication over InfiniBand cells on JSC machines.
    MASTER_ADDR="$MASTER_ADDR"i
fi
export MASTER_PORT=54123

# Prevent NCCL not figuring out how to initialize.
export NCCL_SOCKET_IFNAME=ib0
# Prevent Gloo not being able to communicate.
export GLOO_SOCKET_IFNAME=ib0

config_file_path="${project_root_dir}/configs/multicrop.yaml"
srun env -u CUDA_VISIBLE_DEVICES terratorch fit --config "${config_file_path}"