


-- 1. CONTRAINTES SUR Employes


-- Le rôle de l'employé doit appartenir à une liste définie
ALTER TABLE Employes
    ADD CONSTRAINT chk_employe_role
        CHECK (role_employe IN ('manager', 'vendeur', 'logisticien', 'directeur', 'commercial'));

-- Un employé ne peut pas être son propre manager
ALTER TABLE Employes
    ADD CONSTRAINT chk_employe_not_self_manager
        CHECK (id_manager IS NULL OR id_manager <> id_employe);



-- 2. CONTRAINTES SUR Maison_de_Parfum


-- Le nom de la maison ne peut pas être vide
ALTER TABLE Maison_de_Parfum
    ADD CONSTRAINT chk_maison_nom_non_vide
        CHECK (TRIM(nom_maison) <> '');

-- Le stock ne peut pas être négatif
ALTER TABLE Maison_de_Parfum
    ADD CONSTRAINT chk_maison_stock_positif
        CHECK (stock >= 0);

-- Le nom de la maison doit être unique
ALTER TABLE Maison_de_Parfum
    ADD CONSTRAINT uq_maison_nom
        UNIQUE (nom_maison);



-- 3. CONTRAINTES SUR Clientele


-- Le nom de la clientèle ne peut pas être vide
ALTER TABLE Clientele
    ADD CONSTRAINT chk_clientele_nom_non_vide
        CHECK (TRIM(nom_clientele) <> '');

-- Les coordonnées doivent contenir un '@' si elles ressemblent à un email
-- (format email simplifié : présence de @ et d'un point après)
ALTER TABLE Clientele
    ADD CONSTRAINT chk_clientele_email_format
        CHECK (
            coordonnees_client IS NULL
            OR coordonnees_client NOT LIKE '%@%'  -- accepte les non-emails (téléphone, adresse)
            OR (
                coordonnees_client LIKE '%@%.%'   -- format email minimal valide
                AND coordonnees_client NOT LIKE '@%'
                AND coordonnees_client NOT LIKE '%@'
            )
        );



-- 4. CONTRAINTES SUR Commande


-- La date de commande ne peut pas être dans le futur
ALTER TABLE Commande
    ADD CONSTRAINT chk_commande_date_passee
        CHECK (date_commande <= CURRENT_DATE);

-- La date de commande ne peut pas être antérieure à 2000
ALTER TABLE Commande
    ADD CONSTRAINT chk_commande_date_min
        CHECK (date_commande >= '2000-01-01');

-- L'avis ne peut pas être une chaîne vide (soit NULL, soit un vrai texte)
ALTER TABLE Commande
    ADD CONSTRAINT chk_commande_avis_non_vide
        CHECK (avis_commande IS NULL OR TRIM(avis_commande) <> '');



-- 5. CONTRAINTES SUR Prix


-- Le prix ne peut pas être négatif (déjà présent, renforcé ici)
ALTER TABLE Prix
    ADD CONSTRAINT chk_prix_valeur_positive
        CHECK (valeur > 0);

-- La date de fin de promo doit être après la date de début
ALTER TABLE Prix
    ADD CONSTRAINT chk_prix_promo_coherence
        CHECK (
            promo_debut IS NULL
            OR promo_fin IS NULL
            OR promo_debut <= promo_fin
        );

-- Si une promo est définie, les deux dates doivent être renseignées
ALTER TABLE Prix
    ADD CONSTRAINT chk_prix_promo_complete
        CHECK (
            (promo_debut IS NULL AND promo_fin IS NULL)
            OR (promo_debut IS NOT NULL AND promo_fin IS NOT NULL)
        );

-- La date de début de promo ne peut pas être dans le passé trop lointain
ALTER TABLE Prix
    ADD CONSTRAINT chk_prix_promo_debut_min
        CHECK (promo_debut IS NULL OR promo_debut >= '2000-01-01');



-- 6. CONTRAINTES SUR Parfum


-- Le nom du parfum ne peut pas être vide
ALTER TABLE Parfum
    ADD CONSTRAINT chk_parfum_nom_non_vide
        CHECK (TRIM(nom_parfum) <> '');

-- Le label doit appartenir à une liste de valeurs reconnues
ALTER TABLE Parfum
    ADD CONSTRAINT chk_parfum_label
        CHECK (
            label_parfum IS NULL
            OR label_parfum IN (
                'Eau de Parfum',
                'Eau de Toilette',
                'Eau de Cologne',
                'Parfum Extrait',
                'Eau Fraîche'
            )
        );

-- Le nom du parfum doit être unique dans une maison donnée
ALTER TABLE Parfum
    ADD CONSTRAINT uq_parfum_nom_maison
        UNIQUE (nom_parfum, id_maison);



-- 7. CONTRAINTES SUR Famille_Olfactive


-- Le nom de famille ne peut pas être vide
ALTER TABLE Famille_Olfactive
    ADD CONSTRAINT chk_famille_nom_non_vide
        CHECK (TRIM(nom_famille) <> '');

-- Le nom de la famille olfactive doit être unique
ALTER TABLE Famille_Olfactive
    ADD CONSTRAINT uq_famille_nom
        UNIQUE (nom_famille);

-- Les notes ne peuvent pas être des chaînes vides (soit NULL, soit renseignées)
ALTER TABLE Famille_Olfactive
    ADD CONSTRAINT chk_famille_note_tete
        CHECK (note_tete IS NULL OR TRIM(note_tete) <> '');

ALTER TABLE Famille_Olfactive
    ADD CONSTRAINT chk_famille_note_coeur
        CHECK (note_coeur IS NULL OR TRIM(note_coeur) <> '');

ALTER TABLE Famille_Olfactive
    ADD CONSTRAINT chk_famille_note_fond
        CHECK (note_fond IS NULL OR TRIM(note_fond) <> '');


-- =============================================-- 8. CONTRAINTES SUR Formats


-- Le format en ml doit être strictement positif (déjà défini, rappelé ici)
ALTER TABLE Formats
    ADD CONSTRAINT chk_format_ml_positif
        CHECK (format_ml > 0);

-- Le format en ml doit être un volume standard reconnu
ALTER TABLE Formats
    ADD CONSTRAINT chk_format_ml_standard
        CHECK (format_ml IN (15, 30, 50, 75, 100, 125, 150, 200));

-- Le type d'emballage doit appartenir à une liste définie
ALTER TABLE Formats
    ADD CONSTRAINT chk_format_emballage
        CHECK (
            emballage IS NULL
            OR emballage IN ('vaporisateur', 'flacon', 'roll-on', 'coffret', 'recharge')
        );

-- La concentration doit être une valeur reconnue dans le métier de la parfumerie
ALTER TABLE Formats
    ADD CONSTRAINT chk_format_concentration
        CHECK (
            concentration IS NULL
            OR concentration IN (
                'Eau de Parfum',
                'Eau de Toilette',
                'Eau de Cologne',
                'Parfum Extrait',
                'Eau Fraîche'
            )
        );

-- Un format doit être unique pour une combinaison ml + emballage + concentration
ALTER TABLE Formats
    ADD CONSTRAINT uq_format_complet
        UNIQUE (format_ml, emballage, concentration);



-- 9. CONTRAINTES SUR les tables de liaison


-- Cible : on s'assure que la paire est unique (déjà via PK, rappel explicite)
ALTER TABLE Cible
    ADD CONSTRAINT uq_cible
        UNIQUE (id_clientele, id_maison);

-- Associe : un parfum ne peut pas être associé deux fois à la même famille (déjà via PK)
ALTER TABLE Associe
    ADD CONSTRAINT uq_associe
        UNIQUE (id_parfum, id_famille);

-- Existe_sous : un parfum ne peut pas exister deux fois sous le même format (déjà via PK)
ALTER TABLE Existe_sous
    ADD CONSTRAINT uq_existe_sous
        UNIQUE (id_parfum, id_format);

