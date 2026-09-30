# FactoNotes — Dockerized 🐳

Application Streamlit de collecte et d'analyse de données, développée en Python, dockerisée dans le cadre du programme **CloudHER Cohort 1** (track DevOps, mentorat WIICA).

## 📌 À propos du projet

FactoNotes permet de saisir des données, de les visualiser et de générer des analyses simples via une interface Streamlit interactive.

L'app comporte 3 pages :

- **🏠 Accueil** — présentation de l'outil, citation motivante aléatoire, compteur de participants
- **📝 Formulaire** — collecte des données de l'utilisateur (âge, niveau d'études, moyenne, heures d'étude, temps d'écran, sources de distraction, qualité du sommeil, méthode d'apprentissage). À la soumission, l'utilisateur reçoit :
  - Un **profil d'étudiant** personnalisé : 🦅 L'Aigle, 🦥 Le Paresseux, 🌙 Le Noctambule ou ⚖️ L'Équilibré
  - Des **conseils personnalisés** selon son temps d'écran et son application la plus distrayante
  - Une **comparaison** de ses heures d'étude avec la moyenne des autres répondants
- **📊 Dashboard** — analyse des données collectées : statistiques descriptives (médiane, écart-type, min/max), corrélations (temps d'écran ↔ heures d'étude ↔ moyenne), et visualisations interactives (camembert des distractions, barres des méthodes d'apprentissage, boxplot des moyennes par niveau, nuage de points heures d'étude vs moyenne), avec export des données en CSV

L'objectif : aider les étudiants à visualiser le lien entre leurs habitudes (temps d'écran, distractions, sommeil) et leur performance académique.

Ce dépôt documente l'industrialisation de l'application : conteneurisation, publication de l'image, et mise en place d'un pipeline CI/CD.

## 🎯 Objectif DevOps

Transformer une application existante en projet industrialisé :

- [x] Dockeriser l'application
- [x] Publier l'image sur Docker Hub
- [x] Mettre en place un pipeline CI/CD (GitHub Actions)
- [ ] Écrire l'infrastructure en Terraform *(en cours)*
- [ ] Déployer sur Kubernetes *(à venir)*

## 🚀 Lancer l'application avec Docker

```bash
docker pull audreysiewe14roid/streamlit-cloudher:latest
docker run -p 8501:8501 audreysiewe14roid/streamlit-cloudher:latest
```

Puis ouvre [http://localhost:8501](http://localhost:8501) dans ton navigateur.

## 🏗️ Architecture

```
Code Python (Streamlit - FactoNotes)
         ↓
   Dockerfile (image avec healthcheck + non-root)
         ↓
   GitHub Actions (CI/CD)
         ↓
   Docker Hub (image publiée)
         ↓
   Kubernetes (Minikube) ← à faire
         ↓
   Terraform (IaC) ← à faire
```

## 📂 Structure du repo

```
cloudher-final/
├── monapp.py                     # Application Streamlit (FactoNotes)
├── requirements.txt              # Dépendances Python
├── Dockerfile                    # Image Docker
├── .gitignore                    # Exclusion des fichiers lourds
├── .github/
│   └── workflows/
│       └── ci.yml                # Pipeline CI/CD
├── terraform/                    # Infrastructure as Code (vide — à venir)
├── k8s/                          # Manifestes Kubernetes (vide — à venir)
└── README.md                     # Ce fichier
```

## 🐳 Détails techniques du Dockerfile

- Image de base : `python:3.11-slim`
- **Sécurité** : utilisateur non-root (`appuser`)
- **Monitoring** : healthcheck intégré sur le endpoint Streamlit
- Port exposé : `8501`

## ⚙️ Pipeline CI/CD (GitHub Actions)

Le workflow `.github/workflows/ci.yml` build et push automatiquement l'image Docker vers Docker Hub à chaque push sur `main` :

1. Checkout du code
2. Connexion à Docker Hub (via secrets GitHub)
3. Build de l'image
4. Push de l'image (`audreysiewe14roid/streamlit-cloudher:latest`)

## 🚧 Difficultés rencontrées et solutions

| Blocage | Cause | Solution |
|---|---|---|
| Git 403 | Mot de passe GitHub refusé | Génération d'un Personal Access Token |
| `apt-get` sur Alpine | Alpine n'utilise pas `apt-get` | Utilisation de `apk add` |
| `docker logs` vide | Script écrivait dans un fichier, pas sur stdout | Utilisation de `docker exec ... cat` |
| Push Docker Hub refusé (403) | Nom d'utilisateur incorrect dans le secret | Correction du secret `DOCKER_USERNAME` |
| Repo Git trop lourd (447 Mo) | Ancien historique Git conservé | Création d'un dossier propre + `.gitignore` |
| Workflow CI/CD rouge | Secrets mal configurés | Création du repo Docker Hub + mise à jour du token |
| Installation Terraform | Consommation data trop élevée | Solution envisagée : Terraform Cloud |

## 📌 Compétences travaillées

- Linux et scripting Bash
- Git et GitHub (commits, push, tokens, résolution de conflits)
- Docker (Dockerfile, healthcheck, utilisateur non-root)
- Docker Hub (publication d'images, gestion des tokens)
- CI/CD (GitHub Actions, secrets, déclenchement automatique)
- Diagnostic d'erreurs et correction de configuration
- Python/Streamlit : formulaires interactifs, manipulation de données avec Pandas, visualisations avec Plotly

## 🔗 Liens

- **Image Docker Hub** : [audreysiewe14roid/streamlit-cloudher](https://hub.docker.com/r/audreysiewe14roid/streamlit-cloudher)
- **Article Dev.to (Docker)** : [J'ai procrastiné Docker pendant un mois — voici ce qui m'a débloquée](https://dev.to/audreysiewe14droid/jai-procrastine-docker-pendant-un-mois-voici-ce-qui-ma-debloquee-1cdj)

## ✍️ Mon parcours documenté

J'ai documenté mon apprentissage en public sur Dev.to, du premier contact avec le DevOps jusqu'à la dockerisation de cette application :

- [Mes débuts dans le DevOps avec CloudHER](https://dev.to/audreysiewe14droid/mes-debuts-dans-le-devops-avec-cloudher-1a7c)
- [Mes premiers pas avec Linux et Git — comment j'ai préparé ma réunion CloudHER](https://dev.to/audreysiewe14droid/mes-premiers-pas-avec-linux-et-git-comment-jai-prepare-ma-reunion-cloudher-3ce6)
- [J'ai procrastiné Docker pendant un mois — voici ce qui m'a débloquée](https://dev.to/audreysiewe14droid/jai-procrastine-docker-pendant-un-mois-voici-ce-qui-ma-debloquee-1cdj)
- [Mon récap de la PyCon UbuCon Cameroun 2026 — Jour 1](https://dev.to/audreysiewe14droid/mon-recap-de-la-pycon-ubucon-cameroun-2026-jour-1-2i8p)

## 🙏 Remerciements

Projet réalisé dans le cadre du programme **CloudHER Cohort 1** (WIICA — Women Innovating In Cloud Africa), avec le suivi d'**Endah Bongo-Awah**.

---

#CloudHER #WIICA #WomenInTech #WomenInCloud
