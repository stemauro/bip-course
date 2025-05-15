# Set up an environment on JURECA

## TODO

- [x] Adapt `setup.sh` script
    - [x] Export paths and env variables
    - [x] Install `uv`
    - [x] Load modules
    - [x] Install env via `uv`
    - [x] Test env
- [x] Adapt `activate` script
- [x] Adapt `kernel.sh` script
- [ ] Adapt `vscode.sh` script (low priority)
- [x] Write environment testing script(s)

## Steps
- clone repository

- create environment by running
```shell
bash scripts/setup.sh
```

- activate environment for test
```shell
source scripts/activate.sh
```

- link a Jupyter kernel to the environment
```shell
bash scripts/kernel.sh
```
