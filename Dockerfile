FROM jenkins/jenkins:lts-jdk11

USER root

RUN apt update && \
	apt install -y \
		ca-certificates \
		curl \
		gnupg \
		lsb-release && \
		mkdir -p /etc/apt/keyrings && \
		curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
		echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
	apt update && \
	apt install -y docker-ce-cli docker-compose-plugin

RUN apt install -y python3-pip && \
	pip3 install ansible

RUN apt install -y \
		s3cmd

VOLUME /var/jenkins_home

RUN curl https://get.acme.sh | sh -s -- install --force --nocron --accountemail james.lim@jamochl.com

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

ENV CASC_JENKINS_CONFIG=/usr/share/jenkins/casc_configs
ENV CASC_MERGE_STRATEGY=errorOnConflict

RUN mkdir /usr/share/jenkins/casc_configs
COPY jenkins-casc.yaml /usr/share/jenkins/casc_configs
COPY jenkins-jobdsl.yaml /usr/share/jenkins/casc_configs