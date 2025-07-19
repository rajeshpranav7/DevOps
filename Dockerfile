FROM node:18-alpine
WORKDIR /app
COPY app/package.json ./
COPY app/appointment.js ./
RUN npm install
EXPOSE 3000
CMD ["npm", "start"]

