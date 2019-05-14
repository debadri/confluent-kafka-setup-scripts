## This script is for setting my the basic necessaities for the VM, includes download of Confluent platform. This commands needs to be performed in all VMs irrespective of zookeeper, broker etc.

## Install netcat for RHEL
sudo yum install nmap-ncat-6.40-7.el7.x86_64

## create a new user as the owner for confluent platform
sudo su
useradd confluent
passwd confluent
visudo
#Remove comment from the line where you see wheel (note there are 2 %wheel, be cautiosu!!)
	# Allows people in group wheel to run all commands
	#%wheel        ALL=(ALL)       ALL

# Add confleunt to wheel group	
usermod -aG wheel confluent

#Test sudo access to confluent
su confluent
groups
sudo whoami
	#should prmpt password and display 'root'


## Download package
cd /opt
sudo curl -O http://packages.confluent.io/archive/5.2/confluent-5.2.1-2.12.tar.gz
sudo tar xvzf confluent-5.2.1-2.12.tar.gz
sudo chown confluent:confluent -R confluent-5.2.1

## Install Java 8
sudo yum install java-1.8.0-openjdk

## Check java version
java -version
	