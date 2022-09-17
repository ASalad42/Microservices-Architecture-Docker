# base image 
FROM node

# label 
LABEL MAINTAINER=AYANLE

# inside the container what would be the default working directory 
# pwd home/vagrant/ubuntu
# wrkdir /usr/src/app  - copy depencies below into this folder 

WORKDIR /usr/src/app
# copy dependencies (nodejs, npm, copy app folder) 
COPY package*.json ./
# copy all files with .json extention to default location 
# copy everything where dockerfile is into above app in workdir
COPY . . 

# run some commands (npm install,a,b,c)
RUN apt update 
RUN npm install -g npm@7.20.6
RUN npm install express



# expose the port 3000
EXPOSE 3000

CMD ["node","app.js"]


# BUILD this image - build
# create container and see if app is running in container