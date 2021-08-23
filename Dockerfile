FROM jenkins/jenkins:lts-jdk11

USER root

RUN apt update && apt install -y \
	curl \
	lsb-release && \
	curl -fsSL https://download.docker.com/linux/debian/gpg | \
		gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
	echo \
		"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | \
		tee /etc/apt/sources.list.d/docker.list > /dev/null && \
	apt update && \
	apt install -y docker-ce-cli

VOLUME /var/jenkins_home

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
