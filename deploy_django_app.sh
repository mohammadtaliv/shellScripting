#!/bin/bash

<< task
Deploy the Django app
and handle the code for errors
task

code_clone(){
        echo "Cloning the Django app....."
        git clone https://github.com/LondheShubham153/django-notes-app.git
}


install_requirments(){
        echo "Inastalling Dependencies...."
#       sudo yum install docker-ce docker-ce-cli containerd.io -y
#       sudo yum install nginx -y
        sudo yum install docker-ce nginx -y
}

required_restarts(){
        sudo systemctl enable docker
	sudo systemctl enable nginx
}

deploy(){
        docker build -t notes-app .
        docker run -d -p 8000:8000 notes-app:latest
}


echo "************** DEPLOYMENT STARTED ******************"
if ! code_clone;then
        echo "The code directory already exist"
        cd django-notes-app
fi

if ! install_requirments;then
        echo "installation failed"
        exit 1
fi

if ! required_restarts;then
        echo "System fault Identify"
        exit 1
fi

deploy


