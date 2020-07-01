FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .

RUN npm install

#as we are deploying into production, no need to reference volume.
COPY . .

RUN npm run build

#here we care about /app/build folder to copy into the production container or server to run on nginx

#PHASE TWO - run nginx

FROM nginx
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html