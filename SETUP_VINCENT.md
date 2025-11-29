# 🚀 Guide d'Installation pour Vincent

Salut Vincent ! Voici comment rejoindre le projet Roblox de Thom.

## 📋 Prérequis à Installer

### 1. Git
- Télécharge et installe Git : https://git-scm.com/download/win
- Pendant l'installation, garde les options par défaut

### 2. Roblox Studio
- Télécharge : https://www.roblox.com/create
- Installe normalement

### 3. VS Code
- Télécharge : https://code.visualstudio.com/
- Installe normalement

### 4. Extension Rojo pour VS Code
1. Ouvre VS Code
2. Va dans Extensions (Ctrl+Shift+X)
3. Cherche "Rojo"
4. Installe l'extension officielle

### 5. Plugin Rojo dans Roblox Studio
1. Ouvre Roblox Studio
2. Va dans l'onglet "Plugins"
3. Clique sur "Manage Plugins"
4. Cherche "Rojo" et installe-le

---

## 📥 Installation du Projet

### Étape 1 : Cloner le projet

Ouvre PowerShell (ou le terminal de VS Code) et exécute :

```powershell
# Va dans le dossier où tu veux mettre le projet (par exemple Documents)
cd ~\Documents

# Clone le projet
git clone https://github.com/thom3412/roblox_game.git

# Entre dans le dossier
cd roblox_game
```

### Étape 2 : Installer Aftman (gestionnaire d'outils)

```powershell
# Télécharge Aftman
Invoke-WebRequest -Uri https://github.com/LPGhatguy/aftman/releases/download/v0.3.0/aftman-0.3.0-windows-x86_64.zip -OutFile aftman.zip

# Crée le dossier d'installation
New-Item -ItemType Directory -Path "$env:USERPROFILE\.aftman\bin" -Force

# Décompresse
Expand-Archive -Path aftman.zip -DestinationPath "$env:USERPROFILE\.aftman\bin" -Force

# Supprime le zip
Remove-Item aftman.zip

# Installe Aftman dans le PATH
& "$env:USERPROFILE\.aftman\bin\aftman.exe" self-install
```

**⚠️ IMPORTANT : Ferme et rouvre VS Code après cette étape !**

### Étape 3 : Installer Rojo via Aftman

```powershell
# Dans le dossier du projet
aftman install
```

Cela va installer Rojo automatiquement.

---

## 🎮 Lancer le Projet

### Chaque fois que tu veux travailler :

1. **Ouvre VS Code dans le dossier du projet** :
```powershell
cd ~\Documents\roblox_game
code .
```

2. **Lance le serveur Rojo** :
   - Méthode 1 (VS Code) : `Ctrl+Shift+P` → tape "Rojo: Start Server"
   - Méthode 2 (Terminal) : `rojo serve`

3. **Ouvre Roblox Studio**

4. **Connecte Rojo** :
   - Dans Roblox Studio, clique sur le plugin Rojo
   - Clique sur "Connect"
   - Les fichiers du projet apparaissent dans Studio !

---

## 🔄 Workflow Git (Important !)

### Avant de commencer à coder :
```bash
git pull
```
→ Récupère le travail de Thom

### Pendant que tu codes :
- ✅ Modifie SEULEMENT les fichiers dans VS Code (dossier `src/`)
- ✅ Rojo met à jour Roblox Studio automatiquement
- ❌ NE CODE JAMAIS directement dans Roblox Studio !

### Quand tu as fini une fonctionnalité :
```bash
# Regarde ce qui a changé
git status

# Ajoute tes modifications
git add .

# Crée un commit avec un message descriptif
git commit -m "Description de ce que tu as fait"

# Envoie sur GitHub
git push
```

---

## 📁 Structure du Projet

```
src/
├── Server/          # Scripts serveur (tu les vois dans ServerScriptService)
├── Client/          # Scripts client (tu les vois dans StarterPlayerScripts)
├── Shared/          # Code partagé (dans ReplicatedStorage)
│   ├── Modules/     # Modules réutilisables
│   ├── Events/      # RemoteEvents/Functions
│   ├── Assets/      # Assets partagés
│   └── Config/      # Configuration
└── Workspace/       # Objets du Workspace
```

---

## 🆘 Problèmes Courants

### "Command not found: rojo"
→ Tu n'as pas redémarré VS Code après avoir installé Aftman

### "Command not found: git"
→ Git n'est pas installé ou pas dans le PATH

### "Couldn't connect to the Rojo server"
→ Le serveur Rojo n'est pas lancé. Lance `rojo serve` d'abord.

### Conflit Git
Si Git dit "CONFLICT" :
1. Ouvre le fichier en conflit dans VS Code
2. VS Code te montre les deux versions
3. Choisis celle que tu veux garder
4. Supprime les marqueurs `<<<<`, `====`, `>>>>`
5. `git add .` puis `git commit`

---

## 🎯 Configuration Git (Première fois)

```bash
git config user.name "Vincent"
git config user.email "ton-email@example.com"
```

---

## ✅ Checklist Rapide

- [ ] Git installé
- [ ] Roblox Studio installé
- [ ] VS Code installé
- [ ] Extension Rojo pour VS Code installée
- [ ] Plugin Rojo dans Roblox Studio installé
- [ ] Aftman installé
- [ ] Projet cloné : `git clone https://github.com/thom3412/roblox_game.git`
- [ ] Rojo installé : `aftman install`
- [ ] Configuration Git : `git config user.name "Vincent"`
- [ ] Serveur Rojo lancé : `rojo serve`
- [ ] Roblox Studio connecté au serveur

---

## 🤝 Besoin d'Aide ?

Contacte Thom sur Discord/autre si tu as des problèmes !

**Bon code ! 🚀**
