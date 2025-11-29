# 🎮 Mon Jeu Roblox

Projet Roblox développé avec **Rojo** pour synchroniser VS Code et Roblox Studio.

## 🚀 Installation

### Prérequis
- [Roblox Studio](https://www.roblox.com/create)
- [VS Code](https://code.visualstudio.com/)
- Extension Rojo pour VS Code
- Plugin Rojo dans Roblox Studio

### Installation des outils
```bash
# Aftman va installer automatiquement Rojo
aftman install
```

## 💻 Démarrage

1. **Cloner le projet** :
```bash
git clone <URL_DU_REPO>
cd roblox_game
```

2. **Installer les outils** :
```bash
aftman install
```

3. **Lancer Rojo** :
```bash
rojo serve
```

4. **Dans Roblox Studio** :
   - Ouvrir le plugin Rojo
   - Cliquer sur "Connect"
   - Les fichiers apparaissent automatiquement !

## 📁 Structure

```
src/
├── Server/          # Scripts serveur (ServerScriptService)
├── Client/          # Scripts client (StarterPlayerScripts)
├── Shared/          # Code partagé (ReplicatedStorage)
│   ├── Modules/     # Modules réutilisables
│   ├── Events/      # RemoteEvents/RemoteFunctions
│   ├── Assets/      # Assets partagés
│   └── Config/      # Configuration
└── Workspace/       # Objets du Workspace
```

## 🤝 Collaboration

Voir le fichier [WORKFLOW.md](./WORKFLOW.md) pour le guide complet de collaboration avec Git.

### Workflow rapide :
```bash
# Avant de coder
git pull

# Après avoir codé
git add .
git commit -m "Description des changements"
git push
```

## 📝 Licence

[À définir]

## 👥 Contributeurs

- Thom
- Vincent
