# 🎮 State of Decay - Survival Edition
## Roadmap Collaborative (Thom & Vincent)

> **Concept** : Jeu de survie zombie en vue TPS (Third Person). Le joueur contrôle directement un survivant, explore le monde, récolte des ressources, combat des zombies, et améliore sa base pour survivre.

---

## ✅ Phase 1 : Fondations (COMPLÉTÉ - À ADAPTER)
*Socle de base déjà réalisé, mais à ajuster pour la vue TPS.*

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
- [ ] Saut (optionnel)

---

## 📅 SPRINT 1-2 : Gameplay Core (Parallèle)

> **Objectif** : Avoir un loop de gameplay fonctionnel : Explorer → Récolter → Combattre → Survivre

### [Thom] 2. Exploration & Récolte
*Focus : Interaction avec le monde et collecte de ressources.*

- [ ] **2.1 Système d'Interaction**
  - [ ] Raycast pour détecter les objets interactifs
  - [ ] UI Prompt "Press E to pick up"
  - [ ] Animation de ramassage
  
- [ ] **2.2 Points de Ressources (Loot)**
  - [ ] Containers : Armoires, Caisses, Voitures
  - [ ] Items au sol (Nourriture, Munitions, Matériaux)
  - [ ] Loot aléatoire (tableau de spawn)
  
- [ ] **2.3 Inventaire Joueur**
  - [ ] Système de slots (ex: 20 slots)
  - [ ] Stacking d'items
  - [ ] UI Inventaire (I pour ouvrir)
  - [ ] Gestion du poids (optionnel)

### [Vincent] 3. Combat & Survie
*Focus : Système de combat et menace zombie.*

- [ ] **3.1 Combat Corps-à-Corps**
  - [ ] Équiper une arme (couteau, batte)
  - [ ] Animation d'attaque (clic gauche)
  - [ ] Dégâts aux zombies
  - [ ] Système de stamina pour attaques
  
- [ ] **3.2 IA Zombie Basique**
  - [ ] Pathfinding vers le joueur
  - [ ] Détection visuelle (distance)
  - [ ] Détection sonore (footsteps, tirs)
  - [ ] Attaque au corps-à-corps
  - [ ] Points de vie & mort
  
- [ ] **3.3 Santé & Survie Joueur**
  - [ ] Barre de vie
  - [ ] Barre de stamina
  - [ ] Barre de faim (diminue avec le temps)
  - [ ] Utiliser de la nourriture (heal + faim)
  - [ ] Mort du joueur

### 🔄 Synchronization Point : "First Loop"
> **Test à faire ensemble** : Explorer, trouver un couteau, tuer un zombie, ramasser de la nourriture, l'utiliser.
- [ ] Vérifier que la détection fonctionne avec le raycast
- [ ] Vérifier que les zombies réagissent au bruit
- [ ] Tester le cycle complet de gameplay

---

## 📅 SPRINT 3-4 : Arsenal & Menace (Parallèle)

> **Objectif** : Diversifier le combat et rendre les zombies plus dangereux

### [Thom] 4. Armes & Équipement
*Focus : Système d'armes et munitions.*

- [ ] **4.1 Armes à Feu**
  - [ ] Système d'équipement (Slot arme principale)
  - [ ] Pistolet : Tir au clic, recul, son
  - [ ] Fusil d'assaut (AK-47 style)
  - [ ] Munitions : Types (9mm, 5.56mm)
  - [ ] Rechargement (R)
  
- [ ] **4.2 Système de Visée**
  - [ ] Aim Down Sights (clic droit)
  - [ ] Réticule dynamique (précision)
  - [ ] Recoil pattern
  
- [ ] **4.3 Crafting Basique**
  - [ ] Bandages (Tissu x2)
  - [ ] Molotov (Bouteille + Essence + Tissu)
  - [ ] UI de crafting

### [Vincent] 5. Types de Zombies & Vagues
*Focus : Variété des ennemis et système de vagues.*

- [ ] **5.1 Nouveaux Zombies**
  - [ ] Walker : Lent, faible
  - [ ] Runner : Rapide, dangereux
  - [ ] Tank : Lent, beaucoup de PV
  
- [ ] **5.2 Système de Vagues**
  - [ ] Nuit = Vagues de zombies
  - [ ] Spawning progressif (pas tous d'un coup)
  - [ ] Timer entre vagues
  
- [ ] **5.3 Hordes Errantes**
  - [ ] Groupes de zombies qui patrouillent
  - [ ] Si détectés → suivent le joueur

### 🔄 Synchronization Point : "Night Survival"
> **Test à faire ensemble** : Survivre à une nuit complète avec des vagues de zombies.
- [ ] Vérifier balance : armes vs zombies
- [ ] Tester si les munitions sont trop rares/abondantes

---

## 📅 SPRINT 5-6 : Base & Défense (Parallèle)

> **Objectif** : Construire et défendre un refuge

### [Thom] 6. Construction de Base
*Focus : Système de building.*

- [ ] **6.1 Placement de Structures**
  - [ ] Mode construction (B)
  - [ ] Preview fantôme
  - [ ] Snap to grid
  - [ ] Vérification collision
  
- [ ] **6.2 Structures Défensives**
  - [ ] Murs (Bois, Métal)
  - [ ] Portes (avec code/clé)
  - [ ] Barricades de fenêtres
  - [ ] Pièges (Barbelés, Mines)
  
- [ ] **6.3 Structures Utilitaires**
  - [ ] Coffre de stockage
  - [ ] Lit (point de spawn)
  - [ ] Station de craft
  - [ ] Jardin potager (food lente mais infinie)

### [Vincent] 7. Défense Active
*Focus : Tourelles et défense automatique.*

- [ ] **7.1 Tourelles & Pièges**
  - [ ] Tourelle automatique (munitions requises)
  - [ ] Tourelle laser (électricité)
  - [ ] Détection ennemis
  
- [ ] **7.2 Système de Siège**
  - [ ] Zombies attaquent les murs
  - [ ] Murs ont des PV (se détruisent)
  - [ ] Réparation des structures

### 🔄 Synchronization Point : "Base Defense"
> **Test à faire ensemble** : Construire une base et la défendre contre une vague massive.

---

## 📅 SPRINT 7-8 : Immersion & Polish (Parallèle)

> **Objectif** : Rendre le jeu plus vivant et immersif

### [Thom] 8. Systèmes de Survie Avancés
*Focus : Mécaniques de survie.*

- [ ] **8.1 Cycle Jour/Nuit**
  - [ ] Zombies plus nombreux la nuit
  - [ ] Lampe torche (Q)
  - [ ] Fatigue (besoin de dormir)
  
- [ ] **8.2 Blessures & Maladies**
  - [ ] Infection (morsure zombie → timer avant mort)
  - [ ] Antidote rare
  - [ ] Hémorragie (bandages requis)
  
- [ ] **8.3 Progression**
  - [ ] XP par kill
  - [ ] Niveaux → Augmentation stats (Vie, Stamina)

### [Vincent] 9. Audio & Feedback
*Focus : Son et retour visuel.*

- [ ] **9.1 Sound Design**
  - [ ] Sons d'ambiance (vent, nature)
  - [ ] Musique dynamique (calme → danger)
  - [ ] Sons zombies (grognements, courses)
  
- [ ] **9.2 Effets Visuels**
  - [ ] Sang (impact balle, mort zombie)
  - [ ] Particules feu/fumée
  - [ ] Écran rouge (joueur blessé)
  - [ ] Indicateurs de dégâts flottants

---

## 🚀 Phase Finale : Contenu & Multijoueur

### 10. Map & Contenu
- [ ] Map urbaine (ville abandonnée)
- [ ] Bâtiments explorables
- [ ] Quêtes/Objectifs (optionnel)

### 11. Multijoueur Coop (Si temps)
- [ ] 2-4 joueurs
- [ ] Partage de ressources
- [ ] Base commune

---

## 🎯 Priorités Immédiates (Next Steps)

1. **Thom** : Adapter le système de caméra + Implémenter le raycast d'interaction (`InteractionSystem`)
2. **Vincent** : Finaliser les contrôles TPS + Commencer l'IA zombie basique (`ZombieAI`)

**Estimated Total Development Time**: 4-6 mois (Duo dev)

---

## 📝 Notes de Design

### Différences avec l'ancienne roadmap :
- ❌ **Plus de vue RTS** → ✅ Vue TPS over-the-shoulder
- ❌ **Plus de sélection d'unités** → ✅ Contrôle direct d'UN personnage
- ✅ **Focus combat** : Corps-à-corps + Armes à feu
- ✅ **Stealth** : Accroupi, bruit, détection
- ✅ **Survie** : Faim, Stamina, Fatigue, Infection

### Inspirations :
- **State of Decay** : Survie, base, récolte, gestion communauté
- **Surrounded** : TPS zombie, combat viscéral, hordes
- **Project Zomboid** : Survie réaliste, crafting
