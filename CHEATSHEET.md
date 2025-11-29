# 📜 Rojo Cheatsheet (Aide-Mémoire)

## 🏷️ Types de Scripts (Extensions)

| Extension | Type Roblox | Utilisation |
| :--- | :--- | :--- |
| **`.server.lua`** | **Script** | Code Serveur (ServerScriptService) |
| **`.client.lua`** | **LocalScript** | Code Client (StarterPlayerScripts) |
| **`.lua`** | **ModuleScript** | Modules partagés (ReplicatedStorage) |

## 📂 Structure des Dossiers

| Dossier VS Code | Service Roblox |
| :--- | :--- |
| `src/ServerScriptService` | **ServerScriptService** (Scripts serveur) |
| `src/StarterPlayerScripts` | **StarterPlayerScripts** (Scripts client) |
| `src/ReplicatedStorage` | **ReplicatedStorage** (Modules, Events, Assets) |
| `src/Workspace` | **Workspace** (La map, les objets 3D) |

## 🚀 Commandes Utiles

- **Démarrer Rojo** : `rojo serve` (ou Ctrl+Shift+P → Rojo: Start Server)
- **Git Pull** : `git pull` (Récupérer le code des autres)
- **Git Push** : `git add .` → `git commit -m "msg"` → `git push`
