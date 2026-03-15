-- =============================================
-- 3_insertion.sql
-- Données générées par IA — Système de Parfumerie
-- =============================================
-- PROMPT UTILISÉ :
-- "Donne les requêtes d'insertion permettant de remplir la base de données
--  dont le modèle relationnel est le suivant : [MLD complet].
--  Employes: 30, Maison_de_Parfum: 5, Clientele: 20, Famille_Olfactive: 7,
--  Formats: 15, Parfum: 20, Commande: 40, Prix: 9.
--  Familles : aromatique, boisée, chyprée, fleurie, fougère, hespéridée, orientale.
--  Prix entre 90 et 200€/100mL. Formats variés : 100mL, 200mL, 80mL, etc.
--  Remplir dans l'ordre des dépendances FK."
-- =============================================

USE parfumerie;

-- =============================================
-- ÉTAPE 1 — Tables sans clés étrangères
-- =============================================

-- 1. FAMILLE_OLFACTIVE (7 lignes imposées)
INSERT INTO Famille_Olfactive (id_famille, nom_famille, note_tete, note_coeur, note_fond) VALUES
(1, 'Aromatique', 'Lavande, Basilic, Menthe',           'Romarin, Sauge, Thym',               'Cèdre, Musc, Vétiver'),
(2, 'Boisée',     'Poivre noir, Cardamome, Bergamote',  'Cèdre, Vétiver, Santal',             'Oud, Ambre, Patchouli'),
(3, 'Chyprée',    'Bergamote, Néroli, Citron',          'Rose, Géranium, Iris',               'Mousse de chêne, Labdanum, Musc'),
(4, 'Fleurie',    'Aldéhydes, Bergamote, Citron',       'Rose, Jasmin, Pivoine, Ylang-ylang', 'Musc, Santal, Vétiver'),
(5, 'Fougère',    'Lavande, Bergamote, Citron vert',    'Géranium, Fleur de sureau',          'Mousse de chêne, Coumarine, Musc'),
(6, 'Hespéridée', 'Citron, Orange, Pamplemousse',       'Néroli, Petit grain, Menthe',        'Musc blanc, Cèdre, Vétiver'),
(7, 'Orientale',  'Cannelle, Safran, Cardamome',        'Vanille, Iris, Rose',                'Benjoin, Encens, Musc ambré');

-- 2. FORMATS (15 lignes, formats variés)
INSERT INTO Formats (id_format, format_ml, emballage, concentration) VALUES
(1,  100, 'vaporisateur', 'Eau de Parfum'),
(2,  100, 'vaporisateur', 'Eau de Toilette'),
(3,  100, 'flacon',       'Parfum Extrait'),
(4,  200, 'vaporisateur', 'Eau de Parfum'),
(5,  200, 'vaporisateur', 'Eau de Toilette'),
(6,  200, 'flacon',       'Eau Fraîche'),
(7,  80,  'vaporisateur', 'Eau de Parfum'),
(8,  80,  'vaporisateur', 'Eau de Toilette'),
(9,  80,  'flacon',       'Parfum Extrait'),
(10, 50,  'vaporisateur', 'Eau de Parfum'),
(11, 50,  'vaporisateur', 'Eau de Toilette'),
(12, 50,  'recharge',     'Eau de Parfum'),
(13, 30,  'vaporisateur', 'Eau de Cologne'),
(14, 30,  'flacon',       'Parfum Extrait'),
(15, 15,  'roll-on',      'Eau de Parfum');

-- 3. CLIENTELE (20 lignes)
INSERT INTO Clientele (id_clientele, nom_clientele, coordonnees_client) VALUES
(1,  'Sophie Martin',    'sophie.martin@gmail.com'),
(2,  'Lucas Bernard',    'lucas.bernard@outlook.fr'),
(3,  'Emma Dubois',      'emma.dubois@yahoo.fr'),
(4,  'Hugo Moreau',      'hugo.moreau@gmail.com'),
(5,  'Camille Lefebvre', 'camille.lefebvre@gmail.com'),
(6,  'Léa Rousseau',     'lea.rousseau@hotmail.fr'),
(7,  'Nathan Simon',     'nathan.simon@gmail.com'),
(8,  'Inès Laurent',     'ines.laurent@outlook.com'),
(9,  'Thomas Michel',    'thomas.michel@gmail.com'),
(10, 'Julie Leroy',      'julie.leroy@yahoo.fr'),
(11, 'Antoine Fournier', 'antoine.fournier@gmail.com'),
(12, 'Marie Girard',     'marie.girard@gmail.com'),
(13, 'Clara Bonnet',     'clara.bonnet@gmail.com'),
(14, 'Pierre Dupont',    'pierre.dupont@outlook.fr'),
(15, 'Manon Durand',     'manon.durand@gmail.com'),
(16, 'Alexis Petit',     'alexis.petit@gmail.com'),
(17, 'Laura Roux',       'laura.roux@hotmail.fr'),
(18, 'Kevin Vincent',    'kevin.vincent@gmail.com'),
(19, 'Chloé Fontaine',   'chloe.fontaine@yahoo.fr'),
(20, 'Romain Faure',     'romain.faure@gmail.com');

-- =============================================
-- ÉTAPE 2 — Employes (FK auto-référente)
-- =============================================

-- 4. EMPLOYES (30 lignes)
INSERT INTO Employes (id_employe, role_employe, id_manager) VALUES
(1,  'directeur',   NULL),
(2,  'manager',     1),
(3,  'manager',     1),
(4,  'manager',     1),
(5,  'commercial',  2),
(6,  'commercial',  2),
(7,  'commercial',  3),
(8,  'commercial',  3),
(9,  'commercial',  4),
(10, 'commercial',  4),
(11, 'vendeur',     2),
(12, 'vendeur',     2),
(13, 'vendeur',     3),
(14, 'vendeur',     3),
(15, 'vendeur',     4),
(16, 'vendeur',     4),
(17, 'logisticien', 1),
(18, 'logisticien', 1),
(19, 'logisticien', 1),
(20, 'commercial',  2),
(21, 'commercial',  3),
(22, 'commercial',  4),
(23, 'vendeur',     2),
(24, 'vendeur',     3),
(25, 'vendeur',     4),
(26, 'logisticien', 1),
(27, 'commercial',  2),
(28, 'vendeur',     3),
(29, 'logisticien', 1),
(30, 'vendeur',     4);

-- =============================================
-- ÉTAPE 3 — Tables avec FK vers Employes
-- =============================================

-- 5. MAISON_DE_PARFUM (5 lignes)
INSERT INTO Maison_de_Parfum (id_maison, nom_maison, stock, id_employe) VALUES
(1, 'Chanel',   850, 2),
(2, 'Dior',     720, 3),
(3, 'Guerlain', 640, 4),
(4, 'Hermès',   510, 2),
(5, 'YSL',      690, 3);

-- =============================================
-- ÉTAPE 4 — Tables avec FK vers Maison_de_Parfum
-- =============================================

-- 6. PARFUM (20 lignes)
INSERT INTO Parfum (id_parfum, nom_parfum, description_parfum, label_parfum, id_maison) VALUES
(1,  'N°5',                'Le parfum iconique aux notes florales aldéhydées.',             'Eau de Parfum',   1),
(2,  'Coco Mademoiselle',  'Fragrance orientale florale fraîche et moderne.',                'Eau de Parfum',   1),
(3,  'Bleu de Chanel',     'Boisé aromatique frais et élégant pour homme.',                 'Eau de Parfum',   1),
(4,  'Chance',             'Un tourbillon de fraîcheur aux notes de pamplemousse.',          'Eau de Toilette', 1),
(5,  'J\'adore',           'Floral lumineux aux notes de jasmin et de rose.',                'Eau de Parfum',   2),
(6,  'Sauvage',            'Puissant et noble, boisé aromatique pour homme.',               'Eau de Toilette', 2),
(7,  'Miss Dior',          'Bouquet de roses couturier raffiné et élégant.',                'Eau de Parfum',   2),
(8,  'Hypnotic Poison',    'Oriental vanillé aux notes d\'amande et de jasmin.',            'Eau de Toilette', 2),
(9,  'Shalimar',           'Oriental mythique aux notes de vanille et bergamote.',           'Parfum Extrait',  3),
(10, 'Mon Guerlain',       'Floral aromatique inspiré de la lavande de Provence.',           'Eau de Parfum',   3),
(11, 'Mitsouko',           'Chypré fruité aux notes de pêche et mousse de chêne.',          'Eau de Parfum',   3),
(12, 'La Petite Robe Noire','Fruité floral aux notes de bergamote et cerise noire.',        'Eau de Parfum',   3),
(13, 'Terre d\'Hermès',    'Boisé minéral aux notes de pamplemousse et de silex.',          'Eau de Toilette', 4),
(14, 'Twilly d\'Hermès',   'Floral espiègle aux notes de gingembre et tubéreuse.',          'Eau de Parfum',   4),
(15, 'Jour d\'Hermès',     'Floral blanc délicat aux notes de grenadille.',                 'Eau de Parfum',   4),
(16, 'Eau d\'Orange Verte','Hespéridé frais et vivifiant aux notes d\'orange et citron.',   'Eau de Cologne',  4),
(17, 'Black Opium',        'Floral gourmand noir aux notes de café et vanille.',             'Eau de Parfum',   5),
(18, 'Libre',              'Floral aromatique solaire aux notes de lavande.',                'Eau de Parfum',   5),
(19, 'Mon Paris',          'Floral fruité aux notes de fraise et pivoine.',                 'Eau de Parfum',   5),
(20, 'Opium',              'Oriental épicé mythique aux notes de géranium et épices.',      'Eau de Parfum',   5);

-- =============================================
-- ÉTAPE 5 — Tables avec FK vers Clientele
-- =============================================

-- 7. COMMANDE (40 lignes)
INSERT INTO Commande (id_commande, date_commande, avis_commande, id_clientele) VALUES
(1,  '2023-01-10', 'Parfum sublime, tenue exceptionnelle toute la journée.',        1),
(2,  '2023-02-14', 'Cadeau Saint-Valentin parfait, ma femme a adoré.',              2),
(3,  '2023-03-05', NULL,                                                             3),
(4,  '2023-04-18', 'Produit authentique, livraison rapide, je recommande.',         4),
(5,  '2023-05-22', 'Emballage soigné, parfum conforme à la description.',           5),
(6,  '2023-06-07', 'Mon parfum préféré depuis des années, toujours parfait.',       6),
(7,  '2023-07-14', NULL,                                                             7),
(8,  '2023-08-30', 'Très bonne qualité, flacon élégant et sillage discret.',        8),
(9,  '2023-09-11', 'Commande reçue en parfait état, très beau parfum.',             9),
(10, '2023-10-03', 'Excellente fragrance, tient vraiment toute la journée.',        10),
(11, '2023-11-19', NULL,                                                             11),
(12, '2023-12-01', 'Service impeccable, produit authentique, merci.',               12),
(13, '2024-01-08', 'Belle découverte, je suis complètement conquise.',              13),
(14, '2024-02-14', 'Cadeau pour la Saint-Valentin, très bien reçu.',                14),
(15, '2024-03-20', NULL,                                                             15),
(16, '2024-04-05', 'Superbe sillage, j\'ai reçu beaucoup de compliments.',         16),
(17, '2024-05-17', 'Produit de qualité, très beau flacon en plus.',                17),
(18, '2024-06-09', NULL,                                                             18),
(19, '2024-07-25', 'Parfum envoûtant, je l\'adore absolument.',                    19),
(20, '2024-08-14', 'Livraison soignée, parfum exactement comme attendu.',           20),
(21, '2024-09-02', NULL,                                                             1),
(22, '2024-10-10', 'Très belle fragrance automnale, chaleur et profondeur.',        2),
(23, '2024-11-06', 'Parfum reçu en parfait état, je commande à nouveau.',           3),
(24, '2024-12-20', NULL,                                                             4),
(25, '2025-01-04', 'Mon nouveau parfum préféré pour cette nouvelle année.',         5),
(26, '2025-02-07', 'Belle qualité, bon rapport qualité-prix pour du luxe.',         6),
(27, '2025-02-14', NULL,                                                             7),
(28, '2025-03-01', 'Très bonne expérience d\'achat, je reviendrai.',               8),
(29, '2023-02-28', 'Parfum délicat et raffiné, idéal pour le bureau.',              9),
(30, '2023-04-01', NULL,                                                             10),
(31, '2023-06-21', 'Idéal pour l\'été, très frais et léger.',                      11),
(32, '2023-08-05', 'Produit conforme, livraison rapide, parfait.',                  12),
(33, '2023-10-15', NULL,                                                             13),
(34, '2023-12-24', 'Parfum hivernal chaleureux, cadeau de Noël idéal.',             14),
(35, '2024-02-03', 'Très bonne tenue sur la peau, je recommande vivement.',         15),
(36, '2024-04-25', NULL,                                                             16),
(37, '2024-06-30', 'Belle fragrance estivale, légère et pétillante.',               17),
(38, '2024-09-15', 'Commande bien emballée, parfum authentique garanti.',           18),
(39, '2024-11-22', NULL,                                                             19),
(40, '2025-01-30', 'Parfum chaleureux et enveloppant pour l\'hiver.',              20);

-- =============================================
-- ÉTAPE 6 — Prix (FK -> Commande)
-- Valeurs entre 90 et 200€ pour 100mL
-- =============================================

-- 8. PRIX (9 lignes)
INSERT INTO Prix (id_commande, valeur, promo_debut, promo_fin) VALUES
(1,  135.00, NULL,         NULL),
(2,  189.00, NULL,         NULL),
(3,  112.00, '2023-02-01', '2023-03-31'),
(4,  156.00, NULL,         NULL),
(5,  98.00,  '2023-04-01', '2023-05-31'),
(6,  175.00, NULL,         NULL),
(7,  200.00, '2023-06-01', '2023-06-30'),
(8,  143.00, NULL,         NULL),
(9,  91.00,  '2023-08-01', '2023-09-30');

-- =============================================
-- ÉTAPE 7 — Tables de liaison (associations N,N)
-- =============================================

-- 9. COMPOSÉ (Commande <-> Parfum)
INSERT INTO Compose (id_commande, id_parfum) VALUES
(1,  1), (1,  2),
(2,  5), (2,  7),
(3,  9),
(4,  13),(4,  14),
(5,  17),(5,  18),
(6,  3),
(7,  6),
(8,  11),(8,  12),
(9,  4),
(10, 20),
(11, 10),
(12, 16),
(13, 19),
(14, 8),
(15, 15),
(16, 2), (16, 3),
(17, 5),
(18, 9),
(19, 18),(19, 20),
(20, 1),
(21, 7),
(22, 11),
(23, 13),
(24, 17),
(25, 4),
(26, 6),
(27, 10),
(28, 14),
(29, 2),
(30, 19),
(31, 3),
(32, 8),
(33, 12),
(34, 16),
(35, 1),
(36, 5),
(37, 15),
(38, 9),
(39, 20),
(40, 7);

-- 10. ASSOCIÉ (Parfum <-> Famille_Olfactive)
INSERT INTO Associe (id_parfum, id_famille) VALUES
(1,  4), -- N°5              -> Fleurie
(2,  7), -- Coco Mademoiselle-> Orientale
(3,  1), -- Bleu de Chanel   -> Aromatique
(3,  2), -- Bleu de Chanel   -> Boisée
(4,  4), -- Chance           -> Fleurie
(5,  4), -- J'adore          -> Fleurie
(6,  2), -- Sauvage          -> Boisée
(6,  1), -- Sauvage          -> Aromatique
(7,  4), -- Miss Dior        -> Fleurie
(8,  7), -- Hypnotic Poison  -> Orientale
(9,  7), -- Shalimar         -> Orientale
(10, 1), -- Mon Guerlain     -> Aromatique
(11, 3), -- Mitsouko         -> Chyprée
(11, 2), -- Mitsouko         -> Boisée
(12, 4), -- Petite Robe Noire-> Fleurie
(13, 2), -- Terre d'Hermès   -> Boisée
(14, 4), -- Twilly d'Hermès  -> Fleurie
(15, 4), -- Jour d'Hermès    -> Fleurie
(16, 6), -- Eau d'Orange V.  -> Hespéridée
(17, 4), -- Black Opium      -> Fleurie
(17, 7), -- Black Opium      -> Orientale
(18, 1), -- Libre            -> Aromatique
(19, 4), -- Mon Paris        -> Fleurie
(20, 7); -- Opium            -> Orientale

-- 11. EXISTE_SOUS (Parfum <-> Formats)
INSERT INTO Existe_sous (id_parfum, id_format) VALUES
(1,  1), (1,  3),
(2,  1), (2,  4),
(3,  2), (3,  5),
(4,  2), (4,  10),
(5,  1), (5,  4),  (5,  7),
(6,  2), (6,  5),  (6,  8),
(7,  1), (7,  7),
(8,  2), (8,  11),
(9,  3), (9,  9),
(10, 1), (10, 7),
(11, 1), (11, 4),
(12, 1), (12, 7),
(13, 2), (13, 5),
(14, 1), (14, 7),
(15, 1), (15, 4),
(16, 13),
(17, 1), (17, 4),  (17, 7),
(18, 1), (18, 7),
(19, 1), (19, 4),
(20, 1), (20, 7);

-- 12. COUTE (Commande <-> Formats)
INSERT INTO Coute (id_commande, id_format) VALUES
(1,  1),  (2,  4),  (3,  3),  (4,  2),  (5,  1),
(6,  2),  (7,  5),  (8,  1),  (9,  7),  (10, 4),
(11, 1),  (12, 2),  (13, 1),  (14, 8),  (15, 1),
(16, 4),  (17, 2),  (18, 3),  (19, 1),  (20, 4),
(21, 7),  (22, 1),  (23, 2),  (24, 1),  (25, 4),
(26, 2),  (27, 1),  (28, 5),  (29, 1),  (30, 7),
(31, 2),  (32, 1),  (33, 4),  (34, 3),  (35, 1),
(36, 2),  (37, 7),  (38, 1),  (39, 4),  (40, 2);

-- 13. CIBLE (Clientele <-> Maison_de_Parfum)
INSERT INTO Cible (id_clientele, id_maison) VALUES
(1,  1), (1,  2),
(2,  2), (2,  5),
(3,  1), (3,  3),
(4,  4), (4,  5),
(5,  5), (5,  1),
(6,  2), (6,  3),
(7,  4), (7,  5),
(8,  1), (8,  2),
(9,  3), (9,  4),
(10, 5), (10, 1),
(11, 2), (11, 4),
(12, 3), (12, 5),
(13, 1),
(14, 2),
(15, 3),
(16, 4),
(17, 5),
(18, 1),
(19, 2),
(20, 3);

-- =============================================
-- FIN DU FICHIER 3_insertion.sql
-- =============================================