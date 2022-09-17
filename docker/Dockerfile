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