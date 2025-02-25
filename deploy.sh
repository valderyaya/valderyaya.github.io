#!/bin/bash

# 配置私有仓库和公开仓库的 Git URL
PRIVATE_REPO="https://github.com/valderyaya/Blog_backup.git"
PUBLIC_REPO="https://github.com/valderyaya/valderyaya.github.io.git"

# 设置 Hugo 项目的路径
PROJECT_DIR=$(pwd)
PUBLIC_DIR="${PROJECT_DIR}/public"

# 检查 public 目录是否存在
if [ ! -d "$PUBLIC_DIR" ]; then
    echo "Error: public folder not found!"
    exit 1
fi

# 1. 部署到私人仓库（推送代码到私有仓库）
echo "Deploying Hugo project to private GitHub repository..."
git add .
git commit -m "Deploy Hugo project to private repo"
git push "$PRIVATE_REPO" main

# 2. 使用 git subtree 将 public 目录推送到 GitHub Pages 仓库
echo "Deploying Hugo public content to GitHub Pages repository..."
git subtree push --prefix=public "$PUBLIC_REPO" main

echo "Deployment successful!"
