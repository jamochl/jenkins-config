FROM jenkins/jenkins:lts-jdk11

VOLUME /var/jenkins_home

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

#COPY casc.yml /var/jenkins_home/casc.yml
#ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yml

USER root
