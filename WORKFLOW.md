# Guide de Collaboration Roblox (Antigravity + Rojo + Git)

Ce guide explique comment travailler à deux sur le projet sans tout casser.

## 1. Installation (À faire une seule fois)

### Pour TOI et TON POTE :
1.  Installez **VS Code**.
2.  Installez l'extension **Rojo** (VS Code extension).
3.  Installez le plugin **Rojo** dans Roblox Studio (depuis le gestionnaire de plugins).

## 2. Comment lancer le projet

**👤 CHAQUE PERSONNE fait ça sur SON PC :**

1.  Ouvrez le dossier `roblox_game` dans VS Code.
2.  Lancez **VOTRE PROPRE** serveur Rojo :
    *   Méthode 1 : `Ctrl+Shift+P` → `Rojo: Start Server`
    *   Méthode 2 : Terminal → `rojo serve`
3.  Ouvrez **Roblox Studio** (sur votre PC).
4.  Connectez le plugin Rojo à **VOTRE serveur local** (bouton "Connect").
    *   ✨ *Magie : LES FICHIERS DE VOTRE DOSSIER `src` apparaissent dans Roblox Studio.*

> **⚠️ IMPORTANT** : Vous et votre pote avez chacun VOTRE PROPRE serveur Rojo qui tourne sur VOTRE PROPRE PC. Vous ne vous connectez PAS au serveur de l'autre !

## 3. Comment travailler ensemble (Workflow Git + Rojo)

**Règle d'or : Ne jamais travailler sur la même ligne du même fichier en même temps.**

### Étape A : Avant de commencer à coder
Toujours récupérer les dernières modifs de l'autre :
```bash
git pull
```

### Étape B : Coder
*   Je (Antigravity) modifie les fichiers dans `src/`.
*   Rojo les envoie tout seul dans Roblox Studio pour que tu puisses tester.

### Étape C : Sauvegarder et Partager
Quand une fonctionnalité marche :
1.  Ajouter les fichiers : `git add .`
2.  Valider : `git commit -m "J'ai ajouté le double saut"`
3.  Envoyer : `git push`

## 4. Structure des Dossiers

*   `src/Server` : Scripts serveur (ServerScriptService).
*   `src/Client` : Scripts client (StarterPlayerScripts).
*   `src/Common` : Modules partagés (ReplicatedStorage).

## 5. En cas de conflit (Panique !)
Si Git dit "CONFLICT", pas de panique.
1.  Ouvrez le fichier en rouge dans VS Code.
2.  Vous verrez les deux versions du code.
3.  Choisissez la bonne, effacez les balises `<<<<` et `>>>>`.
4.  Refaites un commit.

---

## 6. Exemple Concret : Toi et Ton Pote 👥

### Scénario : Toi tu codes le système de saut, ton pote code les armes

#### Sur TON PC (Thom) :
```bash
# 1. Récupère le dernier code
git pull

# 2. Lance TON serveur Rojo LOCAL
rojo serve
# → Serveur sur localhost:34872 (par exemple)

# 3. Dans Roblox Studio → Connect au serveur local
# → Tu vois les fichiers dans Studio

# 4. Tu modifies `src/Client/Jump.lua` dans VS Code
# → Rojo met à jour automatiquement TON Roblox Studio

# 5. Tu testes dans TON Roblox Studio

# 6. Ça marche ! Tu sauvegardes sur Git
git add .
git commit -m "Ajout du double saut"
git push
```

#### Sur le PC de TON POTE (Vincent) en MÊME TEMPS :
```bash
# 1. Récupère le dernier code (avant que tu push)
git pull

# 2. Lance SON serveur Rojo LOCAL
rojo serve
# → Serveur sur localhost:34872 (sur SON PC)

# 3. Dans Roblox Studio → Connect au serveur local
# → Il voit SES fichiers dans Studio

# 4. Il modifie `src/Server/WeaponSystem.lua` dans VS Code
# → Rojo met à jour automatiquement SON Roblox Studio

# 5. Il teste dans SON Roblox Studio

# 6. Ça marche ! Il sauvegarde sur Git
git add .
git commit -m "Système d'armes ajouté"
git push
```

#### Ensuite, tu veux voir le travail de ton pote :
```bash
# 1. Tu récupères son code
git pull
# → Le fichier `src/Server/WeaponSystem.lua` apparaît dans TON dossier

# 2. Rojo détecte le nouveau fichier automatiquement
# → Le système d'armes apparaît dans TON Roblox Studio !

# 3. Tu peux tester le double saut + les armes ensemble !
```

### 🎯 Résumé :
- ✅ Chacun son serveur Rojo LOCAL
- ✅ Git synchronise le CODE entre vous
- ✅ Travaillez sur des fichiers DIFFÉRENTS
- ✅ `git pull` régulièrement pour voir le travail de l'autre

