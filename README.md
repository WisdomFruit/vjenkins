# Vagrant: Docker-Jenkins
### Requirements:
- Vagrant => 2.3.4

### Steps:
```bash
# run the boxes
vagrant up

# Access jenkins http://localhost:8080
# Jenkins would ask for admin password, run this command to get it
docker exec vjenkins cat /var/jenkins_home/secrets/initialAdminPassword

# After the installation, we'll configure the cloud
# Go to Dashboard > Manage Jenkins >  Configure Clouds
# Open Cloud details
# Fill the Docker Host URI with the result of this command
docker inspect vnode | grep -E '(\"IPAddress\":\s\"172)' | awk '{print $2}'

# Using this format -> tcp://<IP>:2375
# Then click Test Connection for confirmation
# After that, click Docker Agent Templates and Add a template

# Setup the following
Labels = vdocker-agent-alpine # you can defined anything here
Enabled = checked
Name = vdocker-agent-alpine # you can define anything here
Docker Image = jenkins/agent:alpine-jdk11 # you can use other jenkins/agent tag/type
Instance Capacity = 2 # you can add more if you need it

```
