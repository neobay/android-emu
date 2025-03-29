
# Use lightweight Ubuntu as base
FROM ubuntu:22.04

# Set timezone and disable interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl wget sudo x11vnc xvfb openbox mesa-utils \
    adb pulseaudio dbus-x11 python3 git \
    tigervnc-standalone-server tigervnc-common && \
    apt-get clean

# Install WayDroid
RUN curl -s https://repo.waydro.id | bash && \
    apt-get install -y waydroid

# Set VNC password
RUN mkdir -p /root/.vnc && \
    echo "vncpassword" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy demo APK (you can replace with your own APK)
COPY demo.apk /demo.apk

# Expose VNC and ADB ports
EXPOSE 5900 5555

# Start container
ENTRYPOINT ["/entrypoint.sh"]
