# 📁 Structure du Projet - State of Decay

## Organisation des Dossiers

```
src/
├── ServerScriptService/        # 🖥️ Logique Serveur
│   ├── Main.server.lua         # Script principal du serveur
│   └── Systems/                # Systèmes de jeu organisés par feature
│       ├── Resources/          # [THOM] Gestion des ressources & économie
│       │   └── ResourceManager.server.lua
│       ├── Zombies/            # [VINCENT] IA & Spawning zombies
│       │   └── ZombieManager.server.lua
│       ├── Building/           # [THOM] Système de construction
│       ├── Combat/             # [VINCENT] Combat & Dégâts
│       └── Progression/        # [THOM] XP, Jour/Nuit, Moral
│
├── StarterPlayerScripts/       # 🎮 Scripts Client
│   ├── Main.client.lua         # Script principal client
│   └── Controllers/            # Contrôleurs client par feature
│       └── ResourceController.client.lua
│
├── StarterGui/                 # 🎨 Interface Utilisateur
│   └── HUD/                    # Interface en jeu (barres, inventaire...)
│
├── ReplicatedStorage/          # 📦 Code Partagé (Serveur + Client)
│   ├── Modules/
│   │   ├── Data/               # Définitions de données
│   │   │   └── ResourceTypes.lua
│   │   └── Units/              # Logique des unités (survivants)
│   ├── Events/                 # RemoteEvents & RemoteFunctions
│   ├── Assets/                 # Assets partagés (sons, effets...)
│   └── Config/                 # Fichiers de configuration
│
└── Workspace/                  # 🗺️ Map & Objets 3D
    └── (Map, Spawns, Structures...)
```

## Correspondance avec la Roadmap

### Sprint 3-4 : Survie & Menace
- **Thom** : `Systems/Resources`
- **Vincent** : `Systems/Zombies`

### Sprint 5-6 : Fortification & Combat
- **Thom** : `Systems/Building`
- **Vincent** : `Systems/Combat`

### Sprint 7-8 : Progression & Immersion
- **Thom** : `Systems/Progression`
- **Vincent** : `StarterGui/HUD` + Polish

## Conventions de Nommage

### Scripts
- **Serveur** : `*.server.lua` (exemple : `ResourceManager.server.lua`)
- **Client** : `*.client.lua` (exemple : `ResourceController.client.lua`)
- **Module** : `*.lua` (exemple : `ResourceTypes.lua`)

### Organisation
- Un **System** = Un dossier dans `Systems/`
- Un **Controller** = Un fichier dans `Controllers/`
- Une **Data** = Un fichier dans `Modules/Data/`

## Avantages de cette Structure

✅ **Séparation claire** : Thom et Vincent travaillent sur des dossiers différents
✅ **Évolutif** : Facile d'ajouter de nouveaux systèmes
✅ **Lisible** : On sait immédiatement où se trouve chaque feature
✅ **Git-friendly** : Peu de conflits car travail dans des dossiers séparés
