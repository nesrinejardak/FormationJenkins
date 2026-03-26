# Étape 1 : utiliser une image Maven pour builder le projet
FROM maven:3.9.2-eclipse-temurin-17 AS build

# Copier le projet dans le conteneur
COPY pom.xml /app/
COPY src /app/src/

WORKDIR /app

# Build du projet (package jar)
RUN mvn clean package -DskipTests

# Étape 2 : image finale pour exécuter l'application
FROM eclipse-temurin:17-jdk-alpine

# Copier le jar depuis l'étape build
COPY --from=build /app/target/*.jar /app/app.jar

WORKDIR /app

# Exposer le port de l'application (ex: Spring Boot)
EXPOSE 8080

# Commande pour lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
