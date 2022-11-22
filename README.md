# Micro Services Architecture

## Containerisation & Docker

- Docker is an open source containerization platform. It enables developers to package applications into containers
- Docker lets you build, test, and deploy applications quickly. 
- Build and scale distributed application architectures by taking advantage of standardized code deployments using Docker containers.
- Containers simplify delivery of distributed applications!



### Benefits
- Flexible resource sharing
- Ease of moving and maintaining my application


## Virtualisation vs Containerisation 

explain 


### Installing Docker 
- https://docs.docker.com/desktop/install/windows-install/ - docker install 
- https://docs.microsoft.com/en-gb/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package - WSL manual install 
- create Docker Hub account 

### Docker - creating my own website 
- `docker run hello-world`
- `docker login`

![image](https://user-images.githubusercontent.com/104793540/189885881-757f8f84-a733-46b8-bbe5-d61ee7772f9a.png)

- `docker images`
- `docker rm containerID  -f ` - delete image 
- `docker run -d -p 80:80 nginx`
- `docker ps`
- `pwd`
- `docker cp /c/Users/Ayan/docker/index.html ff34b7f2ec43:/usr/share/nginx/html` - replaces html file on docker image of nginx with my own html file 

![image](https://user-images.githubusercontent.com/104793540/189878919-3f982a9a-6e4c-4d10-b972-eec9a800df1f.png)

#### using dockerfile 

```
# select base image
FROM nginx 

# label it 
LABEL MAINTAINER=ayanle@sparta

# copy data from localhost to the container 
COPY index.html /usr/share/nginx/html

# allow required port
EXPOSE 80

# excecute required command 
CMD ["nginx", "-g", "daemon off;"]
```

- `docker build -t asalad42/eng122_nginx_web_hosting .`

![image](https://user-images.githubusercontent.com/104793540/189886047-23b8890c-388c-478d-8f1e-3ecea588c9f9.png)

-  delete any current images 
- `docker run -d -p 80:80 asalad42/eng122_nginx_web_hosting`

![image](https://user-images.githubusercontent.com/104793540/189885952-38725dab-a90e-4c01-aa78-6bd6a9c4d799.png)

###### pushing to Docker Hub 
- `docker push asalad42/eng122_nginx_web_hosting:latest`

![image](https://user-images.githubusercontent.com/104793540/189887568-180b456a-9552-498a-9c72-5377439925ea.png)
![image](https://user-images.githubusercontent.com/104793540/189887677-2f032e72-8966-4558-a20d-d14433aa09c5.png)
![image](https://user-images.githubusercontent.com/104793540/189888202-275ac510-75b1-4d7b-81a6-4d682f171853.png)

### Node App

```
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
```

- clone app folder into working space 
- move Dockerfile into where app.js is 
- `docker build -t asalad42/eng122_node_appv3 .`
- `docker run -p 3000:3000 asalad42/eng122_node_appv3`

![image](https://user-images.githubusercontent.com/104793540/189922928-fcd8e6ba-3eb2-466a-b0bb-9e5b1dc1d7f8.png)
![image](https://user-images.githubusercontent.com/104793540/189922978-88a1b148-f7ea-42bb-82a9-fa9cbf3d1b15.png)

- `docker push asalad42/eng122_node_appv3:latest`

![image](https://user-images.githubusercontent.com/104793540/189924597-c5ac7837-1277-48df-9c8f-f2ba33512543.png)


### Mongo image 

```
# base image 
FROM mongo

# label 
LABEL MAINTAINER=AYANLE

RUN apt update 

# expose the port 27017
EXPOSE 27017

```

- `docker build -t asalad42/eng122_mongo .`
- `docker run -d -p 27017:27017 asalad42/eng122_mongo`

![image](https://user-images.githubusercontent.com/104793540/189937070-69b61311-5ad5-426f-a932-eabbb1ce9f3c.png)

- `docker push asalad42/eng122_mongo:latest`

![image](https://user-images.githubusercontent.com/104793540/189938769-4577245f-096d-4901-8c9d-61384351f3e9.png)

### Docker compose 
Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

https://docs.docker.com/compose/ 

Using Compose is basically a three-step process:
- Define your app’s environment with a Dockerfile so it can be reproduced anywhere.
- Define the services that make up your app in docker-compose.yml so they can be run together in an isolated environment.
- Run docker compose up and the Docker compose command starts and runs your entire app. You can alternatively run docker-compose up using Compose standalone(docker-compose binary).

#### Benefits
- Multiple isolated environments on a single host
- Preserve volume data when containers are created
- Only recreate containers that have changed
- Variables and moving a composition between environments

#### Use cases 
- Development environments
- Automated testing environments
- Single host deployments

incomplete/working progress 

```
 version: "2"
services: 
  mongo:
    image: mongo:3.2.20
    container_name: mongo
 #   restart: always
    #volumes:
     # - C:\Users\Ayan\Micro-services-docker-node-app-with-mongodb\app\mongod.conf:/etc/mongod.conf
     # - ./logs:/var/log/mongod/
     # - ./db:/var/lib/mongodb
      #- ./mongod.service:/lib/systemd/system/mongod.service
    ports:
      - "27017:27017"

  app:
    container_name: app
    restart: always
    build: ./app
    ports:
      - "80:3000"
    links:
      - mongo
    environment: 
      - DB_HOST=mongodb://mongo:27017/posts
    #command: node app/seeds/seed.js
    # Install kompose using chocolatey
# choco install kubernetes-kompose
# Go to the same directory as your docker-compose file
# kompose convert

```

![image](https://user-images.githubusercontent.com/104793540/190136799-ad8fcfb7-7e8d-4ba7-8de6-699a8a8b759f.png)

- `netsh advfirewall firewall add rule name="Open mongod port 27017" dir=in action=allow protocol=TCP localport=27017`
- mongo:3.2.20
- `docker-compose down`
- `docker-compose up -d `
- `docker exec -it 15b443ed57ca  node seeds/seed.js`

![image](https://user-images.githubusercontent.com/104793540/190136738-e38b48ff-3838-4d9c-85f9-0fd1a49d1603.png)


other commands:

- `docker stop CONTAINER_ID` - Stops your running container.
- `docker exec -it CONTAINER_ID sh` like ssh into a vm/ec2
- after `cd /usr/share/nginx/html` > `cat index.html` > update/upgrade > `sudo nano index.html`
