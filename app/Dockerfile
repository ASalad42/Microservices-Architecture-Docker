# use node official image for this dockerfile
FROM node

# location destination inside the container 
WORKDIR /usr/src/app

COPY ["package.json", "package-lock.json*", "./"]

COPY . .

RUN npm install -g npm@7.20.6
RUN npm install express  

# RUN node seeds/seed.js

EXPOSE 3000

CMD ["node", "app.js"]








































# FROM node
# #ENV NODE_ENV=production

# WORKDIR /usr/src/app

# COPY ["package.json", "package-lock.json*", "./"]

# COPY . . 

# RUN npm install -g npm@7.20.6
# #
# RUN node seeds/seed.js
#  #--production

# CMD [ "node", "app.js" ]
