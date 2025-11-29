# 🎮 State of Decay - Commander Edition
## Roadmap Collaborative (Thom & Vincent)

> **Concept** : Jeu de type Tower Defense / Commander où le joueur donne des ordres à des survivants pour gérer une base, récolter des ressources et se défendre contre des vagues de zombies.

---

## ✅ Phase 1 : Fondations (COMPLÉTÉ)
*Socle commun déjà réalisé.*

### 1.1 Système de Contrôle Commander
- [x] Sélection d'unités (clic gauche)
- [x] Highlight moderne sur sélection
- [x] Commandes de mouvement (clic droit)
- [x] Système de pathfinding intelligent
- [x] Évitement d'obstacles (Map)

### 1.2 Mouvement et Animation
- [x] Rotation avant déplacement
- [x] Animations Idle et Walk
- [x] Synchronisation animation/mouvement
- [x] Système anti-glissement (friction)
- [x] Vitesse de marche réaliste
- [x] Idle roaming automatique

### 1.3 Architecture Technique
- [x] RemoteEvents client-serveur
- [x] State machine pour unités
- [x] Motor6D custom rig support
- [x] Optimisations performance (RunService.Heartbeat)

---

## 📅 SPRINT 3-4 : Survie & Menace (Parallèle)

> **Objectif** : Avoir un cycle de récolte fonctionnel ET une menace active.

### [Thom] 2. Ressources & Économie
*Focus : Gestion des données et interactions de récolte.*
- [ ] **2.1 Types de Ressources** (Data structure)
  - [ ] Nourriture, Bois, Métal, Médical, Munitions
- [ ] **2.2 Système de Récolte**
  - [ ] Points de ressources sur la map (Arbres, Voitures, Bâtiments)
  - [ ] Commande "Gather" fonctionnelle
  - [ ] Animation de récolte
  - [ ] Inventaire de survivant (capacité limitée)
  - [ ] Retour automatique à la base pour déposer
  - [ ] UI d'affichage des ressources globales
- [ ] **2.3 Gestion de la Faim**
  - [ ] Barre de faim par survivant
  - [ ] Consommation de nourriture automatique
  - [ ] Malus si faim trop haute

### [Vincent] 5. Ennemis (Zombies)
*Focus : IA, Spawning et Pathfinding.*
- [ ] **5.1 Types de Zombies**
  - [ ] Création du modèle "Walker"
  - [ ] Animations (Idle, Walk, Attack)
- [ ] **5.2 IA Zombie**
  - [ ] Pathfinding vers la base/joueur
  - [ ] Détection de bruit/mouvement
  - [ ] Comportement de groupe basique
- [ ] **5.3 Système de Vagues (Basique)**
  - [ ] Spawn aléatoire aux bords de la map
  - [ ] Timer simple entre vagues

### 🔄 Synchronization Point : "Survival Test"
> **Test à faire ensemble** : Lancer une partie, essayer de récolter 100 unités de bois pendant que des zombies spawnent.
- [ ] Vérifier que la récolte ne casse pas le pathfinding des zombies.
- [ ] Vérifier que les performances tiennent avec 50 zombies + 10 survivants.

---

## 📅 SPRINT 5-6 : Fortification & Combat (Parallèle)

> **Objectif** : Pouvoir construire des défenses et éliminer les menaces.

### [Thom] 3. Construction de Base
*Focus : Système de placement et structures.*
- [ ] **3.3 Système de Construction**
  - [ ] Mode placement (preview fantôme)
  - [ ] Vérification terrain valide & Snap to grid
  - [ ] Coût en ressources (lien avec Sprint 3)
  - [ ] Survivants peuvent construire (commande "Build")
- [ ] **3.1 Structures Défensives**
  - [ ] Murs (Bois/Métal)
  - [ ] Tours de garde (bonus vision)
- [ ] **3.2 Structures Utilitaires**
  - [ ] Stockage (augmente capacité)
  - [ ] Dortoir (repos)

### [Vincent] 4. Combat & Défense
*Focus : Interaction offensive et dégâts.*
- [ ] **4.1 Système de Combat**
  - [ ] Commande "Attack" fonctionnelle
  - [ ] Système de dégâts & Points de vie (Survivants & Zombies)
  - [ ] Mort et respawn
- [ ] **4.2 Arsenal**
  - [ ] Armes de mêlée (couteau, batte)
  - [ ] Armes à distance (pistolet) + Projectiles
- [ ] **4.3 Défense Passive**
  - [ ] Tourelles automatiques (Logique de tir)

### 🔄 Synchronization Point : "Siege Test"
> **Test à faire ensemble** : Construire un fort et survivre à une grosse vague.
- [ ] Vérifier que les zombies attaquent les murs (Thom) et prennent des dégâts (Vincent).
- [ ] Vérifier que les tourelles (Vincent) visent correctement depuis les tours (Thom).

---

## 📅 SPRINT 7-8 : Progression & Immersion (Parallèle)

> **Objectif** : Transformer la boucle de gameplay en un vrai jeu complet.

### [Thom] 6. Progression & Gestion
*Focus : Systèmes globaux et meta-game.*
- [ ] **6.1 Système de Jour/Nuit**
  - [ ] Cycle jour/nuit (Impact sur gameplay)
  - [ ] Fatigue des survivants
- [ ] **6.2 Moral & Stress**
  - [ ] Calcul du moral (facteurs +/-)
  - [ ] Conséquences (désertion)
- [ ] **6.3 Compétences & XP**
  - [ ] Gain d'XP par action
  - [ ] Spécialisations (Soldat, Ingénieur...)
- [ ] **6.4 Recrutement**
  - [ ] Événements de sauvetage

### [Vincent] 7. UI & Polish
*Focus : Expérience utilisateur et "Juice".*
- [ ] **7.1 HUD Principal**
  - [ ] Intégration propre des ressources (Thom's data)
  - [ ] Minimap
  - [ ] Timer vague / Jour-Nuit
- [ ] **7.3 Feedback Visuel & Audio**
  - [ ] Indicateurs de dégâts flottants
  - [ ] Effets particules (sang, impact)
  - [ ] Sons d'ambiance et Musique dynamique
- [ ] **5.1 Nouveaux Zombies** (Bonus)
  - [ ] Runner, Tank, Spitter

### 🔄 Synchronization Point : "Alpha Loop"
> **Test à faire ensemble** : Jouer une session complète de 20 minutes.
- [ ] Vérifier l'équilibrage global.
- [ ] Polishing final des transitions UI/Gameplay.

---

## 🚀 Phase Finale : Contenu & Release

### 8. Contenu & Polish (Commun)
- [ ] **8.1 Maps** : Création de la map urbaine finale.
- [ ] **8.3 Balance** : Ajustement difficulté vagues vs coûts construction.
- [ ] **9. Multijoueur** (Si temps disponible) : Coop 2 joueurs.

---

## 🎯 Priorités Immédiates (Next Steps)

1.  **Thom** : Commencer la structure de données pour les **Ressources** (Script `ResourceManager`).
2.  **Vincent** : Commencer le modèle et l'IA du **Zombie Walker** (Script `ZombieAI`).

**Estimated Total Development Time**: 3-4 mois (Duo dev)
