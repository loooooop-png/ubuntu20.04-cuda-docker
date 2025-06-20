# 基础镜像
FROM nvidia/cuda:12.2.2-devel-ubuntu20.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# 安装 Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -p /opt/conda \
    && rm /tmp/miniconda.sh

# 将 conda 添加到环境变量
ENV PATH=/opt/conda/bin:$PATH

# 初始化 conda 并设置shell
RUN conda init bash \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \
    && echo "conda activate base" >> ~/.bashrc \
    && conda config --set auto_activate_base false

# 设置默认SSH密码（可被环境变量覆盖）
ENV SSH_ROOT_PASSWORD=password

# 配置SSH服务
RUN mkdir -p /var/run/sshd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 创建工作目录
WORKDIR /workspace

# 修改启动命令，添加设置密码的脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"] 