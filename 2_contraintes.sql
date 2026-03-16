USE parfumerie;


-- 1. CONTRAINTES SUR Employes

ALTER TABLE Employes
    ADD CONSTRAINT chk_employe_role
        CHECK (role_employe IN ('manager', 'vendeur', 'logisticien', 'directeur', 'commercial'));

-- 2. CONTRAINTES SUR Maison_de_Parfum

ALTER TABLE Maison_de_Parfum
    ADD CONSTRAINT chk_maison_stock_positif
        CHECK (stock >= 0);

ALTER TABLE Maison_de_Parfum
    ADD CONSTRAINT uq_maison_nom
        UNIQUE (nom_maison);

-- 3. CONTRAINTES SUR Clientele

ALTER TABLE Clientele
    ADD CONSTRAINT chk_clientele_nom_non_vide
        CHECK (TRIM(nom_clientele) <> '');

-- 4. CONTRAINTES SUR Commande

ALTER TABLE Commande
    ADD CONSTRAINT chk_commande_date_min
        CHECK (date_commande >= '2000-01-01');

ALTER TABLE Commande
    ADD CONSTRAINT chk_commande_avis_non_vide
        CHECK (avis_commande IS NULL OR TRIM(avis_commande) <> '');

-- 5. CONTRAINTES SUR Prix

ALTER TABLE Prix
    ADD CONSTRAINT chk_prix_valeur_positive
        CHECK (valeur > 0);

ALTER TABLE Prix
    ADD CONSTRAINT chk_prix_promo_coherence
        CHECK (
            promo_debut IS NULL
            OR promo_fin IS NULL
            OR promo_debut <= promo_fin
        );

ALTER TABLE Prix
    ADD CONSTRAINT chk_prix_promo_complete
        CHECK (
            (promo_debut IS NULL AND promo_fin IS NULL)
            OR (promo_debut IS NOT NULL AND promo_fin IS NOT NULL)
        );

-- 6. CONTRAINTES SUR Parfum

ALTER TABLE Parfum
    ADD CONSTRAINT chk_parfum_nom_non_vide
        CHECK (TRIM(nom_parfum) <> '');

ALTER TABLE Parfum
    ADD CONSTRAINT chk_parfum_label
        CHECK (
            label_parfum IS NULL
            OR label_parfum IN (
                'Eau de Parfum',
                'Eau de Toilette',
                'Eau de Cologne',
                'Parfum Extrait',
                'Eau Fraiche'
            )
        );

ALTER TABLE Parfum
    ADD CONSTRAINT uq_parfum_nom_maison
        UNIQUE (nom_parfum, id_maison);

-- 7. CONTRAINTES SUR Famille_Olfactive

ALTER TABLE Famille_Olfactive
    ADD CONSTRAINT chk_famille_nom_non_vide
        CHECK (TRIM(nom_famille) <> '');

ALTER TABLE Famille_Olfactive
    ADD CONSTRAINT uq_famille_nom
        UNIQUE (nom_famille);

-- 8. CONTRAINTES SUR Formats

ALTER TABLE Formats
    ADD CONSTRAINT chk_format_ml_positif
        CHECK (format_ml > 0);

ALTER TABLE Formats
    ADD CONSTRAINT chk_format_emballage
        CHECK (
            emballage IS NULL
            OR emballage IN ('vaporisateur', 'flacon', 'roll-on', 'coffret', 'recharge')
        );

ALTER TABLE Formats
    ADD CONSTRAINT chk_format_concentration
        CHECK (
            concentration IS NULL
            OR concentration IN (
                'Eau de Parfum',
                'Eau de Toilette',
                'Eau de Cologne',
                'Parfum Extrait',
                'Eau Fraiche'
            )
        );
