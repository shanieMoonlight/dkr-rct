#########
#Dev only
#########

# Use an exixting Docker Image as a base
FROM node:alpine as builder

# ENTRYPOINT ["tail", "-f", "/dev/null"]
WORKDIR /app

#Install deps
#Copy package.json separately for better caching
COPY package.json .
RUN npm install

#Copy the rest
COPY . .

#Buld the app /usr/app/build
#This will live in 
RUN npm run build


#Serve the built files
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

##############################################################

#Build
# docker build -t shaneyboy/reactfrontend --progress=plain .

#Run
# docker run -p 8001:80 shaneyboy/reactfrontend


#View Image Files
#docker run -it shaneyboy/reactfrontend sh


##############################################################