FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt update && apt install -y \
    qemu-system-x86 \
    novnc \
    websockify \
    wget \
    unzip \
    tzdata

# Make android directory
RUN mkdir /android

# Download your ISO from GitHub Releases
RUN wget -O /android/android.iso \
  https://github.com/TheTobster1232/cloud-android-web/releases/download/v1.0/android.iso

# Create a 4GB disk image
RUN qemu-img create -f qcow2 /android/android.img 4G

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
