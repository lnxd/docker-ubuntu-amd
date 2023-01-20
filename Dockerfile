ARG BASE

FROM ubuntu:${BASE:-20.04}

# Install default apps
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y apt-utils; \
    apt-get install -y curl sudo libpci3 xz-utils wget kmod; \
# Clean up apt
    apt-get clean all; \
# Set timezone
    ln -fs /usr/share/zoneinfo/Australia/Melbourne /etc/localtime; \
    apt-get install -y tzdata; \
    dpkg-reconfigure --frontend noninteractive tzdata; \
# Prevent error messages when running sudo
    echo "Set disable_coredump false" >> /etc/sudo.conf; \
# Create user account
    useradd docker; \
    groupadd -g 98 docker; \
    useradd --uid 99 --gid 98 docker; \
    echo 'docker:docker' | chpasswd; \
    usermod -aG sudo docker; \
    mkdir -p /home/docker;

# Copy latest scripts
COPY start.sh entrypoint.sh /home/docker/
RUN chmod +x /home/docker/start.sh; \
    chmod +x /home/docker/entrypoint.sh;

# Set environment variables.
ENV BASE="Ubuntu ${BASE}"
ENV DRIVERV="20.20"
ENV CUSTOM=""
ENV NVIDIA_BUILD_OPTS="-a -N -q --install-libglvnd --ui=none --no-kernel-module"

# Define working directory.
WORKDIR /home/docker/

# Define default command.
CMD ["./start.sh"]
