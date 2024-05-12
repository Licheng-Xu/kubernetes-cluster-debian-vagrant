# Setting up a K8S Cluster Quickly with Vagrant + VirtualBox

## Objective
### Configuration of K8S Cluster Machines
| Hostname    | IP Address     | CPU | Memory | Operating System  |
| ----------- | -------------- | --- | ------ | ----------------- |
| k8s-master  | 192.168.100.10 | 4   | 4G     | Debian "bookworm" |
| k8s-worker1 | 192.168.100.11 | 2   | 2G     | Debian "bookworm" |
| k8s-worker2 | 192.168.100.12 | 2   | 2G     | Debian "bookworm" |

### Components and Versions of K8S Cluster
| Project           | Component | Version |
| ----------------- | --------- | ------- |
| Deployment        | kubeadm   | v1.30.0 |
| CLI               | kubectl   | v1.30.0 |
| Node Agent        | kubelet   | v1.30.0 |
| Container Runtime | CRI-O     | v1.30.0 |
| CNI               | flannel   | v0.25.1 |

## Prerequisites
[VirtualBox](https://www.virtualbox.org/wiki/Downloads): Virtualization software.

[Vagrant](https://developer.hashicorp.com/vagrant/install): Virtual machine management tool. Install the following plugins:
```shell
vagrant plugin install vagrant-vbguest vagrant-share
```

## Notes
1. This project is not intended for production use.
2. Due to network restrictions in Mainland China, this project uses [USTC open source software mirror](http://mirrors.ustc.edu.cn) and [Alibaba Cloud Container Registry](registry.aliyuncs.com/google_containers) to accelerate software package downloads. You may need to remove or replace corresponding repository addresses in other regions.
3. When executing vagrant ssh on Windows, you may encounter a permission denied issue. Run the fix_ssh_pkey_perm_for_win.ps1 script to fix the permission issue.
4. This project has been fully tested on Windows. In theory, it should also work fine on other operating systems as the host machine.

---

# 使用 Vagrant + VirtualBox 快速搭建 K8S 集群

## 目标
### K8S 集群机器配置
| 主机名      | IP 地址        | 处理器 | 内存 | 操作系统          |
| ----------- | -------------- | ------ | ---- | ----------------- |
| k8s-master  | 192.168.100.10 | 4      | 4G   | Debian "bookworm" |
| k8s-worker1 | 192.168.100.11 | 2      | 2G   | Debian "bookworm" |
| k8s-worker2 | 192.168.100.12 | 2      | 2G   | Debian "bookworm" |
### K8S 集群组件和版本
| 项目       | 组件    | 版本    |
| ---------- | ------- | ------- |
| 部署工具   | kubeadm | v1.30.0 |
| 命令行工具 | kubectl | v1.30.0 |
| 节点代理   | kubelet | v1.30.0 |
| 容器运行时 | CRI-O   | v1.30.0 |
| CNI        | flannel | v0.25.1 |

## 依赖环境
[VirtualBox](https://www.virtualbox.org/wiki/Downloads)：虚拟机软件

[Vagrant](https://developer.hashicorp.com/vagrant/install)：虚拟机管理工具，需要安装插件
```shell
vagrant plugin install vagrant-vbguest vagrant-share
```

## 注意事项
1. 本项目不应用于生产环境。
2. 由于中国大陆地区的网络原因，项目中使用了[中科大开源软件镜像](http://mirrors.ustc.edu.cn)和[阿里云镜像仓库](registry.aliyuncs.com/google_containers)加速软件包下载，其他地区可能需要移除或替换相应的仓库地址。
3. 在 Windows 上执行 `vagrant ssh` 会遇到 permission denied 的问题，执行 fix_ssh_pkey_perm_for_win.ps1 脚本修复权限问题。
4. 本项目在 Windows 进行了完整测试，其他操作系统的宿主机理论上也可以正常运行。
