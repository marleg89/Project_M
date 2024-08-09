# Utiliser une image de base officielle de Python
FROM python:3.9-slim

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le fichier requirements.txt dans le conteneur
COPY requirements.txt .

# Ajouter le répertoire de travail au PYTHONPATH
ENV PYTHONPATH=/app

# Installer les dépendances
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste de l'application dans le conteneur
COPY . .

# Définir les variables d'environnement nécessaires
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Exposer le port que l'application utilisera
EXPOSE 5000

# Définir la commande par défaut pour lancer l'application
CMD ["flask", "run"]
