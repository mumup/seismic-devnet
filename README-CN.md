# Seismic Devnet Docker 环境文档

## 中文版本

### 概述

这个Docker环境用于运行Seismic Devnet，它包含了所有必要的工具和依赖，用于部署智能合约和发送交易到Seismic网络。该环境基于多阶段构建模式，优化了最终镜像的大小和性能。

### 使用说明

#### 构建镜像

```bash
docker build -t seismic-devnet .
```

#### 运行容器

**仅运行容器**：
```bash
docker run -d --name seismic-container seismic-devnet
```

**部署合约**：
```bash
docker run -d --name seismic-container -e DEPLOY_CONTRACT=true seismic-devnet
```

**发送交易**：
```bash
docker run -d --name seismic-container -e SEND_TRANSACTIONS=true seismic-devnet
```

**进入交互式Shell**：
```bash
docker run -it --name seismic-container seismic-devnet shell
```

**连接到运行中的容器**：
```bash
docker exec -it seismic-container bash
```

---