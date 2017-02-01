# Usage
 ./conntrack_parse.sh IP_TO_LISTEN_ON PORT 
# Output
 IP_Address, HH:MM:SS, DD/MM/YYYY
# Notes
 I use this on a multi IP homed linux box, hence the option to specify IP_TO_LISTEN_ON. 
# Dependencies
Conntrack 
 http://conntrack-tools.netfilter.org/
 Debian: sudo apt-get install conntrack
# Future
 My plans for this project are to implement threading and deployment to multiple servers with reporting to central database. Ideally, any IP:PORT combo I can get my hands on that are being used in production will have an instance of some sort running on it. 
# Next push 
 output to be run through sort -u -k1,1
