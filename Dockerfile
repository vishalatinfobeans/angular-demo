FROM node:16.13.0 as builder
#set working directory
WORKDIR /app

COPY package*.json ./

RUN npm install

#copy all files from the current directory to working directory
COPY . .

#run npm install and build 
RUN npm run build

#create nginx stage for serving the build
FROM nginx:1.19

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/dist/angular-demo/ /usr/share/nginx/html

#set working directory to nginx assets directory
#WORKDIR /usr/share/nginx/html

#remove the default nginx files
#RUN rm -rf ./*

#copy static content from builder stage
#COPY --from=builder /app/dist/angular-demo .

#container run the nginx with global directive and daemon off
#ENTRYPOINT [ "nginx", "-g", "daemon off;"]

