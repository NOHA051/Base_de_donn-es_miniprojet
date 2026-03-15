
-- MPD SQL -- Système de Parfumerie

-- Table Employés (avec auto-référence manager)
CREATE TABLE Employes (
    id_employe      INT PRIMARY KEY,
    role_employe    VARCHAR(100) NOT NULL,
    id_manager      INT,
    CONSTRAINT fk_manager FOREIGN KEY (id_manager)
        REFERENCES Employes(id_employe)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Table Maison_de_Parfum
CREATE TABLE Maison_de_Parfum (
    id_maison       INT PRIMARY KEY,
    nom_maison      VARCHAR(150) NOT NULL,
    stock           INT DEFAULT 0,
    id_employe      INT,
    CONSTRAINT fk_maison_employe FOREIGN KEY (id_employe)
        REFERENCES Employes(id_employe)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Table Clientele
CREATE TABLE Clientele (
    id_clientele        INT PRIMARY KEY,
    nom_clientele       VARCHAR(150) NOT NULL,
    coordonnees_client  VARCHAR(255)
);

-- Table Commande
CREATE TABLE Commande (
    id_commande     INT PRIMARY KEY,
    date_commande   DATE NOT NULL,
    avis_commande   TEXT,
    id_clientele    INT NOT NULL,
    CONSTRAINT fk_commande_client FOREIGN KEY (id_clientele)
        REFERENCES Clientele(id_clientele)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Table Prix (dépend de Commande, relation possède 1,1)
CREATE TABLE Prix (
    id_commande     INT PRIMARY KEY,
    valeur          DECIMAL(10,2) NOT NULL CHECK (valeur >= 0),
    promo_debut     DATE,
    promo_fin       DATE,
    CONSTRAINT fk_prix_commande FOREIGN KEY (id_commande)
        REFERENCES Commande(id_commande)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT chk_promo_dates CHECK (promo_fin IS NULL OR promo_debut <= promo_fin)
);

-- Table Famille_Olfactive
CREATE TABLE Famille_Olfactive (
    id_famille      INT PRIMARY KEY,
    nom_famille     VARCHAR(100) NOT NULL,
    note_tete       VARCHAR(255),
    note_coeur      VARCHAR(255),
    note_fond       VARCHAR(255)
);

-- Table Formats
CREATE TABLE Formats (
    id_format       INT PRIMARY KEY,
    format_ml       INT NOT NULL CHECK (format_ml > 0),
    emballage       VARCHAR(100),
    concentration   VARCHAR(50)
);

-- Table Parfum
CREATE TABLE Parfum (
    id_parfum           INT PRIMARY KEY,
    nom_parfum          VARCHAR(150) NOT NULL,
    description_parfum  TEXT,
    label_parfum        VARCHAR(100),
    id_maison           INT NOT NULL,
    CONSTRAINT fk_parfum_maison FOREIGN KEY (id_maison)
        REFERENCES Maison_de_Parfum(id_maison)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- Tables de liaison (associations N,N)


-- Composé : Commande <-> Parfum
CREATE TABLE Compose (
    id_commande     INT NOT NULL,
    id_parfum       INT NOT NULL,
    PRIMARY KEY (id_commande, id_parfum),
    CONSTRAINT fk_compose_commande FOREIGN KEY (id_commande)
        REFERENCES Commande(id_commande)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_compose_parfum FOREIGN KEY (id_parfum)
        REFERENCES Parfum(id_parfum)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Associé : Parfum <-> Famille_Olfactive
CREATE TABLE Associe (
    id_parfum       INT NOT NULL,
    id_famille      INT NOT NULL,
    PRIMARY KEY (id_parfum, id_famille),
    CONSTRAINT fk_associe_parfum FOREIGN KEY (id_parfum)
        REFERENCES Parfum(id_parfum)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_associe_famille FOREIGN KEY (id_famille)
        REFERENCES Famille_Olfactive(id_famille)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Existe_sous : Parfum <-> Formats
CREATE TABLE Existe_sous (
    id_parfum       INT NOT NULL,
    id_format       INT NOT NULL,
    PRIMARY KEY (id_parfum, id_format),
    CONSTRAINT fk_existe_parfum FOREIGN KEY (id_parfum)
        REFERENCES Parfum(id_parfum)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_existe_format FOREIGN KEY (id_format)
        REFERENCES Formats(id_format)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Coute : Commande <-> Formats
CREATE TABLE Coute (
    id_commande     INT NOT NULL,
    id_format       INT NOT NULL,
    PRIMARY KEY (id_commande, id_format),
    CONSTRAINT fk_coute_commande FOREIGN KEY (id_commande)
        REFERENCES Commande(id_commande)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_coute_format FOREIGN KEY (id_format)
        REFERENCES Formats(id_format)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Cible : Clientele <-> Maison_de_Parfum
CREATE TABLE Cible (
    id_clientele    INT NOT NULL,
    id_maison       INT NOT NULL,
    PRIMARY KEY (id_clientele, id_maison),
    CONSTRAINT fk_cible_client FOREIGN KEY (id_clientele)
        REFERENCES Clientele(id_clientele)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_cible_maison FOREIGN KEY (id_maison)
        REFERENCES Maison_de_Parfum(id_maison)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

