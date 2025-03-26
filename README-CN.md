# Seismic Devnet Docker 环境文档

## 中文版本

### 概述

这个Docker环境用于运行Seismic Devnet，它包含了所有必要的工具和依赖，用于部署智能合约和发送交易到Seismic网络。该环境基于多阶段构建模式，优化了最终镜像的大小和性能。

### 构建阶段

#### 第一阶段：构建环境

基于`rust:latest`镜像，此阶段完成以下任务：

1. **安装系统依赖**：
   - sudo, jq, git, curl, ca-certificates

2. **配置Cargo环境**：
   - 设置`CARGO_HOME`为`/usr/local/cargo`
   - 创建必要的目录结构

3. **安装Seismic工具**：
   - 设置`SEISMIC_DIR`为`/usr/local/seismic`
   - 安装`sfoundryup`工具
   - 运行Seismic工具安装程序

4. **安装Bun**：
   - 安装Bun v1.0.0作为JavaScript/TypeScript运行时

5. **克隆项目**：
   - 从GitHub克隆`try-devnet`项目到`/app`目录

6. **安装Node依赖**：
   - 在`/app/packages/cli`目录中运行`bun install`

#### 第二阶段：运行时环境

基于`debian:stable-slim`镜像，此阶段完成以下任务：

1. **安装运行时依赖**：
   - ca-certificates, libssl3, curl, libcurl4

2. **从构建阶段复制文件**：
   - 复制Seismic工具和二进制文件
   - 复制Cargo环境
   - 复制Bun运行时
   - 复制应用程序代码

3. **设置环境变量**：
   - 配置PATH包含所有必要的工具路径
   - 设置CARGO_HOME

4. **验证工具安装**：
   - 检查关键目录和工具是否存在

5. **清理**：
   - 删除不必要的缓存文件

6. **设置工作目录**：
   - 将工作目录设为`/app/packages/cli`

7. **配置入口脚本**：
   - 复制并设置`entrypoint.sh`为容器入口点

### 入口脚本功能

入口脚本`entrypoint.sh`提供以下功能：

1. **合约部署**：
   - 如果设置了环境变量`DEPLOY_CONTRACT=true`，将执行合约部署脚本

2. **发送交易**：
   - 如果设置了环境变量`SEND_TRANSACTIONS=true`，将执行交易脚本

3. **交互式Shell**：
   - 如果容器启动时传入参数`shell`，将进入交互式bash会话
   - 否则，容器将保持运行状态，并显示如何手动连接的信息

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