# 🎮 State of Decay - Survival Edition
## Roadmap Collaborative (Thom & Vincent)

> **Concept** : Jeu de survie zombie en vue TPS (Third Person). Le joueur contrôle directement un survivant, explore le monde, récolte des ressources, combat des zombies, et améliore sa base pour survivre.

---

## ✅ Phase 1 : Fondations (COMPLÉTÉ)
*Socle de base réalisé.*

### 1.1 Système de Caméra & Contrôles TPS
- [x] Caméra over-the-shoulder (Vincent)
- [x] Crosshair/Réticule (Vincent)
- [ ] Rotation du personnage avec la caméra
- [ ] Sprint (Shift)
- [ ] Accroupi/Stealth (Ctrl)

### 1.2 Mouvement du Joueur
- [x] Déplacement WASD basique
- [ ] Système de stamina (course limitée)
- [ ] Animations : Walk, Run, Crouch, Idle
- [ ] Footsteps audio (bruit qui attire les zombies)

---

## 📅 SPRINT 1-2 : Gameplay Core (Parallèle)

> **Objectif** : Avoir un loop de gameplay fonctionnel : Explorer → Fouiller → Survivre

### [Thom] 2. Système de Loot & Interaction (State of Decay Style)
*Focus : Fouille de conteneurs et gestion d'inventaire.*

- [ ] **2.1 Interaction & Surbrillance**
  - [ ] Raycast TPS (corrigé pour nouvelle caméra)
  - [ ] Surbrillance (Highlight) des objets interactifs
  - [ ] Prompt "Appuyer sur E pour fouiller"

- [ ] **2.2 Système de Conteneurs**
  - [ ] Objets fouillables (Caisses, Armoires)
  - [ ] Génération de loot (Loot Tables : Médical, Munitions, Civil)
  - [ ] Persistance du contenu des conteneurs

- [ ] **2.3 Interface de Loot (Double Grille)**
  - [ ] Inventaire Joueur (Gauche)
  - [ ] Inventaire Conteneur (Droite)
  - [ ] Transfert d'items (Click to loot)

### [Thom] 3. Stats & Survie
*Focus : Gestion des besoins vitaux.*

- [ ] **3.1 Stats du Joueur**
  - [ ] Santé, Faim, Soif
  - [ ] Dégradation dans le temps (Decay)
  - [ ] Mort et Respawn

- [ ] **3.2 HUD & Consommables**
  - [ ] Barres de statut (UI)
  - [ ] Utilisation des items (Manger, Boire, Soigner)
  - [ ] Feedback sonore et visuel (Warnings)

### [Vincent] 4. Combat & Menace Zombie
*Focus : IA et danger.*

- [ ] **4.1 IA Zombie Basique**
  - [ ] Pathfinding vers le joueur
  - [ ] Détection visuelle et sonore
  - [ ] Attaque au corps-à-corps
  
- [ ] **4.2 Combat Mêlée**
  - [ ] Attaque avec arme blanche
  - [ ] Dégâts et Hitbox

---

## 📅 SPRINT 3-4 : Arsenal & Base (Parallèle)

> **Objectif** : Se défendre et s'installer.

### [Thom] 5. Armes à Feu
*Focus : Combat à distance.*

- [ ] **5.1 Système d'Armes**
  - [ ] Équiper/Déséquiper (Slot Arme)
  - [ ] Tir (Raycast), Recul, Son
  - [ ] Munitions et Rechargement

- [ ] **5.2 Visée (Aiming)**
  - [ ] Zoom (Clic Droit)
  - [ ] Dispersion dynamique

### [Thom] 6. Construction de Base
*Focus : Fortification.*

- [ ] **6.1 Système de Build**
  - [ ] Placer des barricades/murs
  - [ ] Stockage persistant (Coffres de base)

---

## 📅 SPRINT 5-6 : Polish & Immersion

- [ ] **Animations** : Fouille, Manger, Boire, Recharger
- [ ] **Cycle Jour/Nuit** : Zombies plus agressifs la nuit
- [ ] **Map** : Ville abandonnée, intérieurs visitables

---

## 🎯 Priorités Immédiates (Next Steps)

1. **Thom** : Commencer le système d'**Armes à Feu** (Pistolet).
2. **Vincent** : Avancer sur l'**IA Zombie**.

**Estimated Total Development Time**: 4-6 mois (Duo dev)
