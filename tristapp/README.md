# TRISTAPP

<br/>
<br/>

<p align="center">
<img src="assets/bob.svg" width="1024" />
</p>
<br/>

<h1 align="center">Tristapp</h1>
<h3 align="center">Un lien borne-utilisateur dynamique pour le projet Tristan</h3>
<br/>
<br/>

## Description

Tristapp est une application basée en flutter permettant le lien entre les données relevées par les capteurs du réseau de borne Tristan, les matériaux correspondant et notamment leur affichage. Elle se base sur un système d'utilisateur et leur historique de scan et est prévue pour l'affichage de statistiques. L'application est reliée à un back-end utilisant l'api PocketBase. C'est un projet lié au repository tristan-backend dans le cadre du projet de fin d'année d'étudiants de deuxième année de l'INSA Lyon (2025).

## Dependencies 

- dotenv: ^4.2.0
- fl_chart: ^1.0.0
- flutter:
    sdk: flutter ^3.7.0
- flutter_dotenv: ^5.2.1
- flutter_map: ^8.1.1
- flutter_svg: ^2.1.0
- flutter_svg_provider: ^1.0.7
- intl: ^0.20.2
- latlong2: ^0.9.1
- pocketbase: ^0.22.0

## Utilisation

Lancer le fichier main.dart lancera l'application flutter via un éditeur style VS code, voire utilisation locale pour l'executable.\
La connexion avec la base de donnée s'effectue principalement dans le fichier sensordata.dart, c'est ici qu'est le lien de la base de donnée qui peut être modifié au besoin.\
La structure de la base de donnée peut être retrouvée sur le projet suivant :\
https://github.com/lylykin/tristan-backend

<br/>

**Partage et utilisation locale :**

```
flutter build windows
```
Construction de l'application en exectable pour l'utilisation portable.\
Le fichier sera localisée à partir de la racine dans : \build\windows\x64\runner\Release\
Compresser et partager le dossier Relase entier pour la portabilité.

<br/>

**Prérequis PocketBase :**\
Règles de l'API nécessaire pour le fonctionnement des interactions.
```dart
@request.auth.id != ""
```
Nécessaire pour permettre à tout utilisateur connecté d'accéder aux modifications de la base de donnée.\
A insérer à chaque view/list/update et pour les create et update dans objet.

<br/>

```dart
@request.auth.id != "" || @request.auth.id = ""
```
Permet l'accès à n'importe quel utilisateur même non identifié par la table users\
Insérer UNIQUEMENT pour la création d'un record dans users (api rule create).