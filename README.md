# Seismic Devnet Docker Environment Documentation
#### Run the Container

**Just Run the Container**:
```bash
docker run -d --name seismic seismic-devnet
```

**Deploy Contracts**:
```bash
docker run -d --name seismic -e DEPLOY_CONTRACT=true seismic-devnet
```

**Send Transactions**:
```bash
docker run -d --name seismic -e SEND_TRANSACTIONS=true seismic-devnet
```

**Enter Interactive Shell**:
```bash
docker run -it --name seismic seismic-devnet shell
```

**Connect to Running Container**:
```bash
docker exec -it seismic bash
```