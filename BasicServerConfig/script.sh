#!/bin/bash
clear
echo "------------------------ Server Instalatie Script ----------------------------"
#======================Functions=====================
SetIP () {
echo "Your current IP is,"
ip addr show
read -p "enter ip:" NEW_IP
read -p "enter netmask (255.255.255.0):" NEW_NM
read -p "enter gateway:" NEW_GW
read -p "Set Primary DNS:" NEW_DNS1
read -p "Set secondary DNS:" NEW_DNS2
echo "Succecfully set network settings worden nog niet aangepast. Pas na de Server installatie om problemene te voorkomen"
}

loadIP () {
#-------------Netwerk settings-------------
        echo "
        The following settings are committed 
        IP $NEW_IP
        Netmask $NEW_NM
        Gateway $NEW_GW
        Primary DNS $NEW_DNS1
        Secondary DNS $NEW_DNS2"
read -p "Press enter to submit your network settings"
        sleep 1

sed -i 's/dhcp/static/g' /etc/network/interfaces
sudo cat >> /etc/network/interfaces << EOF
            address $NEW_IP
            gateway $NEW_GW
            netmask $NEW_NM
            dns-nameservers $NEW_DNS1 $NEW_DNS2
EOF
}

hostnamef () {
        echo "Your current Hostname is"
        hostname
        read -p "Enter new hostname:" HOSTNAME
        hostname $HOSTNAME
        echo "Set hostname is"
        hostname
}           


Software () {
read -p "Would you like to update and install software? yes/no:" INSTALL
if [ $INSTALL = "yes" ]; then
        apt update
#Install Nginx
        read -p "Whould you like to install Nginx? yes/no:" NGINX
        if [ $NGINX = "ja" ]; then
        apt install nginx
        echo "enable gninx..."
        sleep 3
        systemctl start nginx
        systemctl enable nginx
        read -p "Press enter to view Nginx status:"
        systemctl status nginx
        elif [ $NFINX = "no" ]; then
        echo "Gninx wont be installed"
        fi
#Install ssh
        read -p "Would you like to instal SSH? yes/no:" SSH
        if [ $SSH = "yes" ]; then
        apt-get install openssh-server
        echo "Configure ssh firewall settings.."
        sleep 2
        sudo ufw allow ssh                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               sudo ufw enable
        sudo ufw status
        read -p "Press enter to view SSH status:"
        elif [ $SSH = "no" ]; then
        echo "SSH wont be installed"
        fi
else
        echo "no updates and software will be installed"
fi
}

#=================RUN SCRIPT=====================
read -p "whould you like to run the server configuration script>" JANEE
if [ $JANEE = "yes" ]; then
        echo "Running script..."
        sleep 1
        #Set IP  function
        SetIP
        #Run hostname function
        hostnamef
        #Run Software installation
        Software     
	#Load IP function
        loadIP
else
  echo "Cancelling ......"
  sleep 2
fi

                                                                                                                                                                                                                                                                                                                                                                
