# Seismic Devnet Docker 文档
#### Run the Container

**拉取镜像**:
```bash
docker pull pmumu666/seismic-devnet:v0.1
```

**进入容器的shell**:
```bash
docker run -it --name seismic pmumu666/seismic-devnet:v0.1 shell
```

**部署合约**:
```bash
cd /app/packages/contract
```
```bash
bash script/deploy.sh
```

**发送交易**:
```bash
cd /app/packages/cli
```
```bash
bash script/transact.sh
```

### Quick check of core functions

| 功能               | 命令                          | 文件夹               |
|--------------------|-------------------------------|------------------------|
| deploy                | `bash script/deploy.sh`       | `/app/packages/contract` |
| transaction           | `bash script/transact.sh`     | `/app/packages/cli`      |

**连接到运行中的容器**:
```bash
docker exec -it seismic bash
```