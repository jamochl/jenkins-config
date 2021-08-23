#!/bin/bash

docker exec jenkins_jenkins_1 tar -C /var -czO jenkins_home | cat > jenkins_backup.tar.gz
