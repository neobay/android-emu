
#!/bin/bash

# Start WayDroid service
echo "[*] Starting WayDroid..."
waydroid container start &
sleep 5

# Start Openbox (lightweight window manager)
echo "[*] Starting Openbox..."
openbox-session &

# Start Xvfb (Virtual Frame Buffer for GUI rendering)
echo "[*] Starting Xvfb..."
Xvfb :0 -screen 0 1280x720x24 &
export DISPLAY=:0

# Start VNC Server (for full system view)
echo "[*] Starting x11vnc..."
x11vnc -forever -shared -usepw -display :0 &

# Wait for WayDroid to be ready
sleep 10

# Connect ADB and install demo APK
echo "[*] Installing demo APK..."
adb connect localhost:5555
adb install /demo.apk

# Keep container running
echo "[*] Starting container service..."
tail -f /dev/null
