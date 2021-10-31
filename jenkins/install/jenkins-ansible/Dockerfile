FROM jenkins/inbound-agent:latest
USER root

RUN apt-get update && \
    apt-get -y install vim ca-certificates openssh-client groff && \
    apt-get -y install python3-pip
RUN pip install ansible===2.9.26

RUN apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    rm -rf /root/.local

USER jenkins
ENTRYPOINT ["jenkins-agent"]
