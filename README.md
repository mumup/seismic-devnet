# Seismic Devnet Docker Documentation
#### Run the Container

**pull the docker image**:
```bash
docker pull pmumu666/seismic-devnet:v0.1
```

**Enter Interactive Shell**:
```bash
docker run -it --name seismic pmumu666/seismic-devnet:v0.1 shell
```

**Deploy Contracts**:
```bash
cd /app/packages/contract
```
```bash
bash script/deploy.sh
```

**Send Transactions**:
```bash
cd /app/packages/cli
```
```bash
bash script/transact.sh
```

### Quick check of core functions

| function               | bash                          | dir               |
|--------------------|-------------------------------|------------------------|
| deploy                | `bash script/deploy.sh`       | `/app/packages/contract` |
| transaction           | `bash script/transact.sh`     | `/app/packages/cli`      |

**Connect to Running Container**:
```bash
docker exec -it seismic bash
```