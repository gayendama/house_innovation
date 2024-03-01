#Utilisation de l'image node comme base
FROM node:10.13.0 as builder
LABEL maintenair="ndamagaye" email="ndamagaye64@gmail.com"
# Définition du répertoire de travail dans le conteneur
WORKDIR /app

# Copie des fichiers de configuration et du code source
COPY *.json  ./
COPY . .

# Installation des dépendances
RUN npm install

# Construction de l'application
RUN npm run build

FROM nginx:latest
COPY --from=builder /app/dist/angular-dashboard-ui  /usr/share/nginx/html
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]



