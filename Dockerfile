#Utilisation de l'image node comme base
FROM node:10.13.0 as builder
LABEL maintenair="ndamagaye" email="ndamagaye64@gmail.com"
# Définition du répertoire de travail dans le conteneur
WORKDIR /app

# Copie des fichiers de configuration et du code source
COPY . .

# Installation des dépendances
RUN npm install

# Construction de l'application
RUN npm run build

FROM httpd:2.4.58
COPY --from=builder /app/dist/angular-dashboard-ui  /usr/local/apache2/htdocs/
EXPOSE 80
CMD ["httpd", "-D", "FOREGROUND"]



