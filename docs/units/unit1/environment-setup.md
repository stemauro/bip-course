# Set up an environment on JURECA

## TODO

- [ ] Adapt `setup.sh` script
    - [ ] Export paths and env variables
    - [ ] Install `uv`
    - [ ] Load modules
    - [ ] Install env via `uv`
    - [ ] Test env
- [ ] Adapt `activate` script
- [ ] Adapt `kernel.sh` script
- [ ] Adapt `vscode.sh` script (low priority)
- [ ] Write environment testing script(s)

## Steps
- clone repository

- create environment by running
```shell
bash scripts/setup.sh
```

- activate environment for test
```shell
source scripts/activate
```

- link a Jupyter kernel to the environment
```shell
bash scripts/kernel.sh
```

- test kernel
```shell
echo 'okay!'
```
