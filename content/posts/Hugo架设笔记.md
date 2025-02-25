---
title: "Hugo架设笔记"
date: 2025-02-24T21:59:46+08:00
draft: false
toc: false
images:
tags:
  - untagged
categories: ["笔记"]
---


## 安装

Windows: ```winget install Hugo.Hugo.Extended```

## 在 github 建立一个仓库

名字叫： {username}.github.io

## 在本地建立一个 Hugo 专案

```
hugo new site [project name]

cd [project name]
```

可以使用 ```hugo server``` 启动看看，如果显示 page not found 是正常的

在专案资料夹下 ```git init```

## Hugo主题

我这里使用的是 [Hello Friend NG](https://github.com/rhazdon/hugo-theme-hello-friend-ng)

cd 到专案资料夹, 打指令 `git submodule add https://github.com/rhazdon/hugo-theme-hello-friend-ng.git themes/hugo-profile`

在 `hugo.toml` 修改

```
baseURL = 'https://valderyaya.github.io' //改成自己的网址
languageCode = 'en-us'
title = 'valderyaya library' // 改成自己想要的title
theme = 'hugo-profile'

[params]
  dateform        = "Jan 2, 2006"
  dateformShort   = "Jan 2"
  dateformNum     = "2006-01-02"
  dateformNumTime = "2006-01-02 15:04"

enableRobotsTXT = true
enableGitInfo   = false
enableEmoji     = true
enableMissingTranslationPlaceholders = false
disableRSS     = false
disableSitemap = false
disable404     = false
disableHugoGeneratorInject = false

[menu]
  [[menu.main]]
    identifier = "about"
    name       = "About"
    url        = "about/"
  [[menu.main]]
    identifier = "posts"
    name       = "Posts"
    url        = "posts/"
  [[menu.main]]
    identifier = "categories"
    name       = "Categories"
    url        = "categories/"
  [[menu.main]]
    identifier = "tags"
    name       = "Tags"
    url        = "tags/"

```

## 建立文章

`hugo new posts/[first-post].md`

> 以下从别的网站复制过来的
> 
title：文章标题；

data：文章被创建的事件

draft：是否草稿内容，如果为true，将不显示在博客站点中。

tags：为这篇文章创建标签，是数组形式["1","2","3"]

categories：为这篇文章创建分类，是数组形式["1","2","3"]


# 如何部署和备份

在执行 `hexo server` 之后会产生一个 puiblic 资料夹，这个资料夹里面的内容就是要放在 github pages 上的

下面是一个script，主要功能是把blog的资料夹备份到私人的repo，把public资料夹的内容 push 到 github pages

```shell
#!/bin/bash

# 配置私有仓库和公开仓库的 Git URL
PRIVATE_REPO="git@github.com:your_username/my-hugo-blog.git"
PUBLIC_REPO="git@github.com:your_username/my-hugo-blog.github.io.git"

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

```


修改脚本的执行权限：

`chmod +x deploy.sh`

执行脚本：

`./deploy.sh`

## 一些常用指令

### 建立新文章
`hugo new posts/[new-post].md`

### 本地运行 Hugo 
```
# 预设执行
hugo server

# 包含草稿一起显示
hugo server -D

# 不限發佈日期文章一律顯示
hugo server -F
```

### 清理静态档案
`hugo --cleanDestinationDir`

### 发布静态网页档
`hugo`