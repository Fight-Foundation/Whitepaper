---
order: 90
icon: code
---

# Jeton FIGHT - Aperçu Technique

## Vue d'Ensemble

FIGHT est un jeton fongible cross-chain déployé sur Solana et BNB Smart Chain (BSC), utilisant le protocole LayerZero V2 pour des transferts cross-chain fluides. Le jeton implémente le standard Omnichain Fungible Token (OFT), assurant un bridging sécurisé et efficace entre les chaînes.

---

## Spécifications du Jeton

### Solana (Chaîne Principale)
- **Type de Jeton :** SPL Token (Natif)
- **Token Mint :** `8f62NyJGo7He5uWeveTA2JJQf4xzf8aqxkmzxRQ3mxfU`
- **Offre Totale :** 10 000 000 000 FIGHT (10 milliards)
- **Décimales :** 9
- **Standard du Jeton :** SPL Token avec métadonnées Metaplex

### BNB Smart Chain (Chaîne Secondaire)
- **Type de Jeton :** ERC-20 (OFT)
- **Adresse du Contrat :** `0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab`
- **Modèle d'Offre :** Wrapped (pas de minting natif, tous les jetons bridgés depuis Solana)
- **Décimales :** 18
- **Standard du Jeton :** LayerZero OFT V2

---

## Architecture

### Bridge Cross-Chain (LayerZero V2)

FIGHT utilise le protocole Omnichain Fungible Token (OFT) de LayerZero pour des transferts cross-chain trustless :

**Composants Solana :**
- **Programme OFT :** `FXnms2y5FUjzxzEaDEnEF54pYWZLteTdKUwQhDbCAUfL`
- **OFT Store :** `8TRG47KgD9KgZaHyKH5CKZRCAhfUAzbqivXV8SZWWhYk`
- **Escrow du Jeton :** `6rZoHSARsboMx1vNesfqd7q1DasgxWs5yivrRJvKaSPe`
- **Endpoint LayerZero :** `76y77prsiCMvXMjuoZ5VRrhG5qYBrUMYTE5WgHqgjEn6`
- **ID Endpoint :** 30168 (Solana Mainnet)

**Composants BSC :**
- **Contrat OFT :** `0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab`
- **Endpoint LayerZero :** `0x1a44076050125825900e736c501f859c50fE728c`
- **ID Endpoint :** 30102 (BSC Mainnet)

### Mécanisme du Bridge

1. **Solana → BSC :**
   - Les jetons sont verrouillés dans le compte escrow Solana
   - Un message LayerZero est envoyé à BSC
   - Des jetons équivalents sont mintés sur BSC

2. **BSC → Solana :**
   - Les jetons sont brûlés sur BSC
   - Un message LayerZero est envoyé à Solana
   - Des jetons équivalents sont libérés de l'escrow sur Solana

---

## Gouvernance & Sécurité

### Portefeuilles Multi-Signature

Le jeton FIGHT implémente une gouvernance multi-signature pour une sécurité et décentralisation renforcées :

#### Multisig Solana (Squads V4)
- **Adresse :** `GCQ8wGjU5TYmzC1YJckqgTGQLRjRxktB4rNuemPA9XWh`
- **Type :** Coffre Squads V4
- **Contrôle :**
  - ✅ Admin OFT (configuration du programme)
  - ✅ Autorité de Mise à Jour des Métadonnées du Jeton
  - ⚠️ Délégué LayerZero (action multisig en attente)
  - ✅ Autorité de Mise à Niveau du Programme

#### Multisig BSC
- **Adresse :** `0x1381c63F11Fe73998d80e2b42876C64362cF98Ab`
- **Contrôle :**
  - ✅ Propriété du Contrat
  - ⚠️ Délégué LayerZero (action multisig en attente)

### Fonctionnalités de Sécurité

1. **Contrôle Décentralisé :** Toutes les fonctions critiques nécessitent une approbation multi-signature
2. **Protection des Mises à Niveau :** Les mises à niveau de programme/contrat nécessitent un consensus multisig
3. **Limitation de Débit :** Limites de débit intégrées pour les transferts cross-chain
4. **Sécurité DVN :** LayerZero V2 utilise des Réseaux de Vérificateurs Décentralisés (DVN) pour la vérification des messages
5. **Autorité de Mint Immuable :** L'autorité de mint du jeton Solana est contrôlée par OFT Store (aucun minting additionnel possible)

---

## Distribution des Jetons

### Offre Initiale
- **Total Minté :** 10 000 000 000 FIGHT (sur Solana)
- **En Circulation (Solana) :** Variable selon l'activité du bridge
- **Bridgé (BSC) :** Dynamique selon les transferts bridge des utilisateurs

### Détentions Actuelles
- **Trésorerie Multisig :** 10 000 000 000 FIGHT
  - Transaction : `5AGrL5Rm8sQQJnbVHYUVUAJZcYqJcEgNnyhkFiSXuXPy7iKfnMM28YjoPBEGESgHnNd5HvbbXzdJbkRhSy3aXVt6`

---

## Détails Techniques

### Programme Solana

**Type de Programme :** Programme Rust basé sur Anchor
**ID du Programme :** `FXnms2y5FUjzxzEaDEnEF54pYWZLteTdKUwQhDbCAUfL`

**Instructions Clés :**
- `send` : Initier un transfert cross-chain vers BSC
- `lz_receive` : Recevoir des jetons depuis BSC
- `set_oft_config` : Configurer admin/délégué (multisig uniquement)

**Configuration OFT Store :**
- **Type :** OFT Natif (utilise un jeton SPL existant)
- **Admin :** Multisig (contrôle la configuration)
- **Délégué :** Contrôle les paramètres de l'endpoint LayerZero
- **Autorité de Mint du Jeton :** PDA OFT Store (empêche le minting additionnel)

### Contrat Intelligent BSC

**Type de Contrat :** Solidity ERC-20 + LayerZero OFT
**Adresse :** `0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab`

**Fonctions Clés :**
- `send()` : Bridge des jetons vers Solana
- `_lzReceive()` : Recevoir des jetons depuis Solana
- `transferOwnership()` : Transférer la propriété (multisig uniquement)
- `setDelegate()` : Définir le délégué LayerZero (multisig uniquement)

**Plafond d'Offre :** 10 000 000 000 FIGHT (appliqué au niveau du contrat)

---

## Informations de Déploiement

### Dates de Déploiement
- **Programme Solana :** Déployé au slot 376682336
- **Contrat BSC :** Déployé en novembre 2025

### Transactions de Déploiement

**Solana :**
- Déploiement du Programme : Slot 376682336
- Création OFT Store : On-chain
- Transfert de Jetons au Multisig : `5AGrL5Rm8sQQJnbVHYUVUAJZcYqJcEgNnyhkFiSXuXPy7iKfnMM28YjoPBEGESgHnNd5HvbbXzdJbkRhSy3aXVt6`

**BSC :**
- Déploiement du Contrat : Novembre 2025
- Transfert de Propriété : `0xa3f30a326d76c93bd872e501b69aa2a9e67867adc084bb3b38d1ca898c124124` (Bloc 67808442)

---

## Vérification & Audit

### Vérification On-Chain

**Solana :**
- Programme déployé et vérifiable on-chain
- Code source : https://github.com/Fight-Foundation/token

**BSC :**
- Contrat vérifié sur BscScan
- Vérification : https://bscscan.com/address/0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab

### Mesures de Sécurité

1. **Exigences Multi-Signature :**
   - Toutes les actions administratives nécessitent une approbation multisig
   - Autorité de mise à niveau contrôlée par multisig
   - Configuration de délégué contrôlée par multisig

2. **Sécurité LayerZero V2 :**
   - Réseaux de Vérificateurs Décentralisés (DVN)
   - Authentification et vérification des messages
   - Paramètres de sécurité configurables

3. **Contrôles d'Offre :**
   - Offre maximale fixe (10 milliards de jetons)
   - Aucune capacité de minting sur BSC (wrapped uniquement)
   - Autorité de mint sur Solana détenue par PDA OFT Store

---

## Guide d'Intégration

### Ajouter FIGHT aux Portefeuilles

**Portefeuilles Solana (Phantom, Solflare, etc.) :**
```
Adresse du Jeton : 8f62NyJGo7He5uWeveTA2JJQf4xzf8aqxkmzxRQ3mxfU
```

**Portefeuilles BSC (MetaMask, Trust Wallet, etc.) :**
```
Adresse du Contrat : 0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab
Symbole du Jeton : FIGHT
Décimales : 18
```

### Bridge de Jetons

Les utilisateurs peuvent bridger des jetons FIGHT entre Solana et BSC en utilisant des interfaces compatibles LayerZero ou une interaction directe avec le contrat.

**Important :** Des frais de bridge s'appliquent pour les transferts cross-chain (payés en jeton de gas natif : SOL ou BNB).

---

## Liens Explorateur

### Solana
- **Token Mint :** https://explorer.solana.com/address/8f62NyJGo7He5uWeveTA2JJQf4xzf8aqxkmzxRQ3mxfU
- **Programme OFT :** https://explorer.solana.com/address/FXnms2y5FUjzxzEaDEnEF54pYWZLteTdKUwQhDbCAUfL
- **OFT Store :** https://explorer.solana.com/address/8TRG47KgD9KgZaHyKH5CKZRCAhfUAzbqivXV8SZWWhYk
- **Multisig :** https://explorer.solana.com/address/GCQ8wGjU5TYmzC1YJckqgTGQLRjRxktB4rNuemPA9XWh
- **Application Squads :** https://v4.squads.so/

### BSC
- **Contrat :** https://bscscan.com/address/0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab
- **Multisig :** https://bscscan.com/address/0x1381c63F11Fe73998d80e2b42876C64362cF98Ab
- **TX Transfert de Propriété :** https://bscscan.com/tx/0xa3f30a326d76c93bd872e501b69aa2a9e67867adc084bb3b38d1ca898c124124

### LayerZero
- **LayerZero Scan :** https://layerzeroscan.com/
- **Endpoint Solana :** https://layerzeroscan.com/endpoint/30168
- **Endpoint BSC :** https://layerzeroscan.com/endpoint/30102

---

## Dépôt & Code Source

- **GitHub :** https://github.com/Fight-Foundation/token
- **Licence :** MIT
- **Documentation :** Disponible dans le dépôt

---

## Support & Contact

Pour les questions techniques, le support d'intégration ou les préoccupations de sécurité :

- **GitHub Issues :** https://github.com/Fight-Foundation/token/issues
- **Documentation :** README.md du dépôt

---

## Annexe : Référence Complète des Adresses

### Adresses Solana
| Composant | Adresse |
|-----------|---------|
| Token Mint | `8f62NyJGo7He5uWeveTA2JJQf4xzf8aqxkmzxRQ3mxfU` |
| Programme OFT | `FXnms2y5FUjzxzEaDEnEF54pYWZLteTdKUwQhDbCAUfL` |
| OFT Store | `8TRG47KgD9KgZaHyKH5CKZRCAhfUAzbqivXV8SZWWhYk` |
| Escrow du Jeton | `6rZoHSARsboMx1vNesfqd7q1DasgxWs5yivrRJvKaSPe` |
| Endpoint LayerZero | `76y77prsiCMvXMjuoZ5VRrhG5qYBrUMYTE5WgHqgjEn6` |
| Multisig (Squads V4) | `GCQ8wGjU5TYmzC1YJckqgTGQLRjRxktB4rNuemPA9XWh` |
| Compte Jeton Multisig | `HFzqZ8c7pRstrYe9dzk9mZZP7wA2c86p7m5L73o6bsk7` |

### Adresses BSC
| Composant | Adresse |
|-----------|---------|
| Contrat FIGHT OFT | `0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab` |
| Endpoint LayerZero | `0x1a44076050125825900e736c501f859c50fE728c` |
| Multisig | `0x1381c63F11Fe73998d80e2b42876C64362cF98Ab` |

### IDs Endpoint LayerZero
| Chaîne | ID Endpoint |
|--------|-------------|
| Solana Mainnet | 30168 |
| BSC Mainnet | 30102 |

---

**Version du Document :** 1.0
**Dernière Mise à Jour :** 11 novembre 2025
**Statut :** Déploiement Production Actif
