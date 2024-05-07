FROM ubuntu:22.04

# Update package lists
RUN apt-get update -y

# Install required packages
RUN apt-get install -y x11vnc xvfb tightvnc-viewer firefox

# Set VNC password (change "your_password" to your desired password)
RUN echo "root" | x11vnc -storepasswd - > ~/.vnc/passwd

# Create noVNC configuration (replace 127.0.0.1 with your host IP if accessing remotely)
RUN echo '<html>
<head><title>Web VNC</title></head>
<body>
  <iframe src="http://127.0.0.1:6080/vnc_auto.html" width="100%" height="100%">
  </iframe>
</body>
</html>' > /var/www/html/index.html

# Start Xvfb for graphical session
RUN echo "Xvfb :1 -screen 0 1024x768x24 &" >> /etc/rc.local

# Start noVNC server in the background
RUN noVNC &

# Run headless Firefox for initial display (prevents black screen)
CMD ["firefox"]
