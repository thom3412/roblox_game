# 🎮 State of Decay - Survival Edition
## Roadmap Collaborative (Thom & Vincent)

> **Légende** :
> - ✅ **[FAIT]** : Fonctionnel et validé.
> - ⚠️ **[A REVOIR]** : Fonctionnel mais nécessite du polish ou des ajustements (Feedback utilisateur).
> - 🚧 **[EN COURS]** : Développement actif / Partiel.
> - ❌ **[A FAIRE]** : Pas encore commencé.

---

## 📦 Phase 1 : Fondations & Interaction (Thom)

### 1. Système d'Interaction
- ⚠️ **Raycast TPS** :
  - ✅ Détection globale.
  - ⚠️ **A CORRIGER** : Manque de précision pour les petits objets au sol.
- ✅ **Prompt UI** : Affichage "[E] Pick up" dynamique.
- ⚠️ **Surbrillance (Highlight)** :
  - ⚠️ **A CORRIGER** : Comportement inadéquat (brille de loin sans crosshair). Doit être lié au Raycast/Focus.

### 2. Système de Loot & Conteneurs
- 🚧 **Génération de Loot** :
  - ✅ Structure de base (Loot Tables).
  - ⚠️ **A COMPLÉTER** : Contenu très basique (test avec parts). Manque la variété (Munitions spécifiques, Nourriture variée, Équipement).
  - ❌ **Rareté** : Pas de système de rareté (Commun, Rare, Épique) pour l'instant.
- ✅ **Gestion des Conteneurs** :
  - ✅ Persistance session.
  - ✅ Attribut "IsEmpty".

### 3. Interface Utilisateur (UI)
- ⚠️ **Inventaire Joueur** :
  - ✅ Structure et Layout "State of Decay 2".
  - ⚠️ **A AMÉLIORER** : Images (Icons) des items sont des placeholders. Design global "convenable" mais à améliorer.
- ⚠️ **Inventaire Conteneur (Loot)** :
  - ✅ Fonctionnel.
  - ⚠️ **A AMÉLIORER** : Idem que joueur (Images, Polish).
- ❌ **Polish UI** :
  - ❌ Tooltips, Sons, Animations d'interface.

### 4. Stats & Survie
- 🚧 **Système de Stats** :
  - ✅ UI Barres (Santé, Faim, Soif).
  - ⚠️ **A APPROFONDIR** :
    - ❌ Logique de gain (Pain vs Soda vs Eau).
    - ❌ Logique de perte (Pourquoi on perd plus de sang/faim à tel moment ?).
    - ❌ Impact réel sur le gameplay (Stamina réduite si faim ?).

---

## 🧟 Phase 2 : Combat & Menace (Vincent)

### 1. Mouvements & Contrôles
- ✅ **Caméra** : Vue épaule (OTS).
- ✅ **Déplacements** : WASD, Sprint, Crouch.
- ❌ **Animations** :
  - ⚠️ **CRITIQUE** : Les animations ne chargent pas.

### 2. IA Zombie
- ✅ **Spawning** : ZombieManager fonctionnel.
- 🚧 **Comportement** :
  - ❌ Pathfinding complexe.
  - ❌ Détection & Attaque.

---

## 🔫 Phase 3 : Arsenal & Base (Prochaine Étape)

### 1. Armes à Feu (Thom - PRIORITÉ)
- ❌ **Système de base** : Class "Weapon", Munitions.
- ❌ **Tir** : Raycast, Recul.
- ❌ **Visée** : Zoom.

### 2. Construction
- ❌ Système de placement.

---

## 🌐 Phase 4 : Multijoueur & Polish (Futur)

### 1. Interactions Joueurs
- ❌ **Échange (Trading)** : Échanger des items entre joueurs.
- ❌ **Groupe/Escouade** : Voir la position des alliés, pas de friendly fire.
- ❌ **Revive** : Relever un joueur à terre.

### 2. Release & Optimisation
- ❌ **Optimisation** : Performance (Streaming, Memory).
- ❌ **Mobile/Console** : Support manette et tactile.
- ❌ **Bêta Test** : Session de test avec plusieurs joueurs.

---

## 📝 Backlog Technique & Améliorations

1. **[URGENT] Fixer les Animations**.
2. **[GAMEPLAY] Approfondir les Stats** : Définir des règles précises de consommation et de perte.
3. **[CONTENT] Remplir les Loot Tables** : Créer les vrais items (Data) et ajouter la rareté.
4. **[POLISH] Raycast & Highlight** : Rendre la détection plus stricte et le highlight contextuel.
5. **[UI] Assets Graphiques** : Remplacer les placeholders par de vraies icônes.

---

## 🎯 Objectif Actuel
**Consolider l'existant avant d'avancer** :
1. Corriger le Raycast/Highlight.
2. Remplir un peu plus les Loot Tables (avec Rareté).
3. Affiner la logique des Stats.
