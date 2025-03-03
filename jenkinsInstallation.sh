# warning dont install anything from this document always prefer to install from official sources

# First install the java deb package
echo "Installing java 21"
sudo wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb

# Set the Default Java Version
sudo update-alternatives --config java

# Update profile
echo "Configuring profile"
sudo nano /etc/profile
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

# Update and upgrade
sudo apt-get update
sudo apt-get upgrade -y

# Install jenkins from official documentation
echo "Installing Jenkins"
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins


# To run jenkins
sudo java -jar /usr/share/java/jenkins.war


# To access jenkins outside ec2
echo "Configuring Jenkins to listen on 0.0.0.0"
sudo nano /etc/default/jenkins
JENKINS_ARGS="--httpListenAddress=0.0.0.0"
#sudo sed -i 's/HTTP_PORT=8080/HTTP_PORT=8080\nJENKINS_ARGS=\"--httpPort=0.


# To start Jenkins on boot
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins
echo "Jenkins has been installed and started. You can access it at http://localhost:8080"

# To stop jenkins
echo "sudo systemctl stop jenkins"
sudo systemctl stop jenkins


# For font configuration
sudo apt-get update
sudo apt-get install -y fontconfig
sudo apt-get install -y xfonts-75dpi xfonts-base

# Clear and regenerate the font cache
sudo fc-cache -f -v

# Re-run Jenkins
sudo systemctl restart jenkins

# To access the jenkins outside ec2
+----------------------------+
| 1. Log in to AWS Console    |
+----------------------------+
              |
              v
+----------------------------+
| 2. Navigate to EC2          |
+----------------------------+
              |
              v
+----------------------------------+
| 3. Under "Network & Security",  |
|    select "Security Groups"     |
+----------------------------------+
              |
              v
+--------------------------------------+
| 4. Select the security group        |
|    attached to your EC2 instance    |
+--------------------------------------+
              |
              v
+----------------------------+
| 5. Click on "Inbound rules" |
|    tab                     |
+----------------------------+
              |
              v
+-------------------------------+
| 6. Click "Edit inbound rules"  |
+-------------------------------+
              |
              v
+-----------------------------------------+
| 7. Add a new rule:                     |
|    - Type: Custom TCP Rule             |
|    - Port Range: 8080 (or custom port) |
|    - Source: Anywhere (0.0.0.0/0) or   |
|      custom IP range                   |
+-----------------------------------------+
              |
              v
+--------------------------+
| 8. Click "Save rules"     |
+--------------------------+

# Open browser
echo "Open http://your-ec2-public-ip:8080 in your browser"
echo "Add password to login jenkins acoount"

# Get jenkins password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword


# After login install plugins (After login you get the options install already selectde plugin or chhose)
GitHub Integration
Docker
Docker Pipeline
NodeJS Plugin

# You can create your account and password other wise skip the process
# Now login if logged out 
# If docker and Docker pipeline not avalable then 
Jenkins dashboard -> manage jenkins -> plugins -> avalable plugins -> (Search Docker, Docker Pipeline)



# Install docker 
echo "Run the following command to uninstall all conflicting packages"

# Install using the apt repository
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Restart Docker
sudo systemctl restart docker
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker


# Set Up GitHub Webhook
echo "GitHub -> Webhooks"
echo "Payload URL: http://your-ec2-public-ip:8080/github-webhook/"
echo "Content Type: application/json"
echo "Events: push, pull_request"