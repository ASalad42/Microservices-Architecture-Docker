# build an image to automate the tasks to launch static website/page
# using nginx webserver with Docker

# use the official image nginx
# lable it with your name or email
# copy the folder/file from local host to the container
# declare to use default port 80 for nginx
# CMD with the final command - as an example npm start

# building customised docker images


# FROM is the keyword to use the image

FROM nginx


# lable it with your email or name - this is optional
LABEL MAINTAINER=shahrukh@sparta

# copy the data as our index.html/app1
COPY app1 /usr/share/nginx/html
# copy app1 to the nginx default index.html

# Now let's add the port

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
# we get this from the official image of nginx

# docker run -d -v /c/Users/ahskhan/eng89_docker/app1:/usr/share/nginx/html -p 90:80 ahskhan/mynginx


# docker run -d -v /c/Users/ahskhan/eng89_docker/app1:/var/log/nginx -p 70:80 ahskhan/mynginx  