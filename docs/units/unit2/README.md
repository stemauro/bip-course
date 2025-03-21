# Table of contents

## Distributed Deep Learning on GPU-Based Clusters

| Topic                             | Status | Description                                                                 |
|--------------------------------   |--------|--------------------------------------------------------------------|
| Distributed Deep Learning         |🗓️ Planned| <ul><li>Common DDL strategies.</li><li>Pytorch DDP.</li></ul>|
| Clusters 102                      |🗓️ Planned| <ul><li>SLURM.</li><li>Interactive v. batched jobs.</li><li>Monitoring.</li><li>Paths and commands cheatsheet.</li></ul>| 
| Pretraining at scale on Jureca    |🗓️ Planned| <ul><li>Implementation of a common SSL method of choice.</li><li>Custom dataloader.</li><li>Distributed training.</li></ul> |
| Finetuning on Jureca  (part. 1)   |🗓️ Planned| <ul><li>Implementation of a classification head.</li><li>Custom dataloader.</li><li>Evaluation.</li></ul>|

## Distributed Deep Learning
- [ ] Short intro to training a neural network (🤔)
- [ ] PyTorch DDP
- [ ] Reference other DDL strategies (🔗 [Ultrascale Playbook by Nanotron](https://huggingface.co/spaces/nanotron/ultrascale-playbook))

## Clusters 102
- [ ] SLURM resource administrator
- [ ] Interactive v. batched jobs: `srun` and `sbatch` commands, `#SBATCH` directives
- [ ] Minimal working example
- [ ] Monitoring via 🧐 [LLView](https://www.fz-juelich.de/en/ias/jsc/services/user-support/software-tools/llview?expand=translations,fzjsettings,nearest-institut)

## Pretraining at scale on Jureca

- [ ] Pytorch DDP from-scratch implementation of MAE (🤔)
- [ ] Custom dataloader implementation (🤔)
- [ ] MAE pretraining at scale on 🌍 [SSL4EO-S12 v1.1](https://datapub.fz-juelich.de/ssl4eo-s12/)

## Finetuning on Jureca  (part. 1) 

- [ ] Custom dataloader implementation (🤔)