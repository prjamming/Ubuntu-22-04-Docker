FROM ubuntu:22.04

# Skip tzdata configuration (assuming x11vnc)
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    xfce4 \
    x11vnc

RUN apt-get upgrade -y

RUN useradd -ms /bin/bash vncuser

RUN mkdir -p /home/vncuser/.vnc

RUN echo "passwd:x:0:0:VNC User:/home/vncuser:/bin/bash" >> /etc/passwd
RUN echo "vncuser:x:1000:0::/home/vncuser:/bin/bash" >> /etc/passwd
RUN echo "vncuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN echo ":1 -localhost -geometry 1024x768 -depth 16 -auth vncshadow" > /home/vncuser/.vnc/xstartup

RUN echo "VNCSERVER=1:1" >> /etc/environment

RUN chmod +x /home/vncuser/.vnc/xstartup

CMD ["/usr/bin/x11vnc", "-forever", "-display", ":1"]
