
-- Requêtes d'interrogation — Système de Parfumerie


USE parfumerie;


-- PARTIE 1 — PROJECTIONS, SÉLECTIONS, TRIS,
--            DONNÉES UNIQUES, MASQUES, IN, BETWEEN


-- 1.1 Liste de tous les parfums avec leur label et leur maison,
--     triés par nom de parfum (pour le catalogue marketing)
SELECT nom_parfum, label_parfum, id_maison
FROM Parfum
ORDER BY nom_parfum ASC;

-- 1.2 Parfums disponibles uniquement en "Eau de Parfum" ou "Parfum Extrait"
--     (produits premium à mettre en avant dans la campagne)
SELECT nom_parfum, label_parfum, description_parfum
FROM Parfum
WHERE label_parfum IN ('Eau de Parfum', 'Parfum Extrait')
ORDER BY label_parfum, nom_parfum;

-- 1.3 Commandes passées pendant la période printemps 2024
--     (mars à mai 2024) pour analyser la saison cible
SELECT id_commande, date_commande, avis_commande, id_clientele
FROM Commande
WHERE date_commande BETWEEN '2024-03-01' AND '2024-05-31'
ORDER BY date_commande;

-- 1.4 Clients dont le nom contient "Martin" ou commence par "Du"
--     (recherche de familles de clients fidèles)
SELECT id_clientele, nom_clientele, coordonnees_client
FROM Clientele
WHERE nom_clientele LIKE '%Martin%'
   OR nom_clientele LIKE 'Du%'
ORDER BY nom_clientele;

-- 1.5 Liste des prix promotionnels dont la valeur est entre 90 et 130 euros
--     (offres d'entrée de gamme à promouvoir)
SELECT id_commande, valeur, promo_debut, promo_fin
FROM Prix
WHERE valeur BETWEEN 90.00 AND 130.00
ORDER BY valeur ASC;

-- 1.6 Labels de parfums distincts présents dans le catalogue
--     (vision unique des types de produits disponibles)
SELECT DISTINCT label_parfum
FROM Parfum
ORDER BY label_parfum;

-- 1.7 Employés occupant un rôle commercial ou vendeur,
--     triés par rôle puis par id (pour la liste des équipes terrain)
SELECT id_employe, role_employe, id_manager
FROM Employes
WHERE role_employe IN ('commercial', 'vendeur')
ORDER BY role_employe, id_employe;

-- 1.8 Formats de flacons entre 50mL et 100mL
--     (formats les plus vendus à réapprovisionner en priorité)
SELECT id_format, format_ml, emballage, concentration
FROM Formats
WHERE format_ml BETWEEN 50 AND 100
ORDER BY format_ml, emballage;

-- 1.9 Commandes ayant un avis client renseigné et contenant le mot "parfait"
--     (témoignages positifs à utiliser dans les supports marketing)
SELECT id_commande, date_commande, avis_commande
FROM Commande
WHERE avis_commande LIKE '%parfait%'
ORDER BY date_commande DESC;

-- 1.10 Maisons de parfum ayant un stock supérieur à 600 unités
--      (maisons avec lesquelles relancer des partenariats)
SELECT nom_maison, stock
FROM Maison_de_Parfum
WHERE stock > 600
ORDER BY stock DESC;



-- PARTIE 2 — FONCTIONS D'AGRÉGATION,
--            GROUP BY, HAVING


-- 2.1 Nombre de parfums par maison
--     (identifier les maisons les plus représentées dans le catalogue)
SELECT id_maison, COUNT(*) AS nb_parfums
FROM Parfum
GROUP BY id_maison
ORDER BY nb_parfums DESC;

-- 2.2 Prix moyen, minimum et maximum des commandes
--     (statistiques générales pour calibrer les nouvelles offres)
SELECT
    AVG(valeur)  AS prix_moyen,
    MIN(valeur)  AS prix_minimum,
    MAX(valeur)  AS prix_maximum
FROM Prix;

-- 2.3 Nombre de commandes par client,
--     en ne gardant que les clients ayant passé plus d'une commande
--     (clients fidèles à cibler pour le programme de fidélité)
SELECT id_clientele, COUNT(*) AS nb_commandes
FROM Commande
GROUP BY id_clientele
HAVING COUNT(*) > 1
ORDER BY nb_commandes DESC;

-- 2.4 Chiffre d'affaires total par mois sur l'année 2024
--     (analyser la saisonnalité des ventes)
SELECT
    MONTH(C.date_commande) AS mois,
    YEAR(C.date_commande)  AS annee,
    SUM(P.valeur)          AS ca_mensuel
FROM Commande C
JOIN Prix P ON C.id_commande = P.id_commande
WHERE YEAR(C.date_commande) = 2024
GROUP BY YEAR(C.date_commande), MONTH(C.date_commande)
ORDER BY mois;

-- 2.5 Nombre de formats disponibles par type d'emballage
--     (savoir quels emballages sont les plus diversifiés)
SELECT emballage, COUNT(*) AS nb_formats
FROM Formats
GROUP BY emballage
ORDER BY nb_formats DESC;

-- 2.6 Parfums associés à plus d'une famille olfactive
--     (parfums complexes à valoriser dans la communication)
SELECT id_parfum, COUNT(*) AS nb_familles
FROM Associe
GROUP BY id_parfum
HAVING COUNT(*) > 1
ORDER BY nb_familles DESC;

-- 2.7 Valeur moyenne des commandes promotionnelles vs non-promotionnelles
--     (mesurer l'impact des promotions sur le panier moyen)
SELECT
    CASE
        WHEN promo_debut IS NOT NULL THEN 'Avec promotion'
        ELSE 'Sans promotion'
    END AS type_commande,
    COUNT(*)       AS nb_commandes,
    AVG(valeur)    AS valeur_moyenne,
    SUM(valeur)    AS valeur_totale
FROM Prix
GROUP BY
    CASE
        WHEN promo_debut IS NOT NULL THEN 'Avec promotion'
        ELSE 'Sans promotion'
    END;

-- 2.8 Maisons de parfum dont le stock moyen dépasse 600 unités
--     (partenaires stratégiques bien approvisionnés)
SELECT nom_maison, stock
FROM Maison_de_Parfum
GROUP BY id_maison, nom_maison, stock
HAVING stock > 600
ORDER BY stock DESC;



-- PARTIE 3 — JOINTURES (internes, externes,
--            simples, multiples)


-- 3.1 JOINTURE SIMPLE INTERNE
--     Liste des parfums avec le nom de leur maison
--     (catalogue complet pour la brochure marketing)
SELECT P.nom_parfum, P.label_parfum, M.nom_maison
FROM Parfum P
JOIN Maison_de_Parfum M ON P.id_maison = M.id_maison
ORDER BY M.nom_maison, P.nom_parfum;

-- 3.2 JOINTURE MULTIPLE INTERNE
--     Commandes avec le nom du client et le montant payé
--     (vue complète des transactions pour le reporting)
SELECT
    C.id_commande,
    C.date_commande,
    CL.nom_clientele,
    P.valeur,
    C.avis_commande
FROM Commande C
JOIN Clientele CL ON C.id_clientele = CL.id_clientele
JOIN Prix P        ON C.id_commande  = P.id_commande
ORDER BY C.date_commande DESC;

-- 3.3 JOINTURE MULTIPLE INTERNE
--     Parfums commandés avec le nom du client et la date
--     (traçabilité complète pour l'analyse des préférences)
SELECT
    CL.nom_clientele,
    C.date_commande,
    PA.nom_parfum,
    PA.label_parfum
FROM Commande C
JOIN Clientele CL  ON C.id_clientele  = CL.id_clientele
JOIN Compose CO    ON C.id_commande   = CO.id_commande
JOIN Parfum PA     ON CO.id_parfum    = PA.id_parfum
ORDER BY CL.nom_clientele, C.date_commande;

-- 3.4 JOINTURE EXTERNE GAUCHE
--     Tous les clients avec leurs commandes,
--     y compris ceux qui n'ont jamais commandé
--     (identifier les clients inactifs à relancer)
SELECT
    CL.nom_clientele,
    CL.coordonnees_client,
    C.id_commande,
    C.date_commande
FROM Clientele CL
LEFT JOIN Commande C ON CL.id_clientele = C.id_clientele
ORDER BY CL.nom_clientele;

-- 3.5 JOINTURE EXTERNE GAUCHE
--     Tous les parfums avec leurs familles olfactives associées,
--     y compris les parfums sans famille définie
--     (détecter les parfums à cataloguer)
SELECT
    P.nom_parfum,
    P.label_parfum,
    F.nom_famille
FROM Parfum P
LEFT JOIN Associe A        ON P.id_parfum  = A.id_parfum
LEFT JOIN Famille_Olfactive F ON A.id_famille = F.id_famille
ORDER BY P.nom_parfum, F.nom_famille;

-- 3.6 JOINTURE MULTIPLE INTERNE — 5 tables
--     Parfums commandés avec leur famille olfactive et le nom du client
--     (analyse croisée des goûts olfactifs par client)
SELECT
    CL.nom_clientele,
    PA.nom_parfum,
    F.nom_famille,
    C.date_commande
FROM Commande C
JOIN Clientele CL       ON C.id_clientele  = CL.id_clientele
JOIN Compose CO         ON C.id_commande   = CO.id_commande
JOIN Parfum PA          ON CO.id_parfum    = PA.id_parfum
JOIN Associe A          ON PA.id_parfum    = A.id_parfum
JOIN Famille_Olfactive F ON A.id_famille   = F.id_famille
ORDER BY CL.nom_clientele, F.nom_famille;

-- 3.7 JOINTURE INTERNE AVEC AGRÉGATION
--     Nombre de commandes par maison de parfum
--     (maisons les plus actives en termes de ventes)
SELECT
    M.nom_maison,
    COUNT(DISTINCT CO.id_commande) AS nb_commandes
FROM Maison_de_Parfum M
JOIN Parfum PA    ON M.id_maison   = PA.id_maison
JOIN Compose CO   ON PA.id_parfum  = CO.id_parfum
GROUP BY M.id_maison, M.nom_maison
ORDER BY nb_commandes DESC;

-- 3.8 JOINTURE EXTERNE DROITE
--     Toutes les maisons avec les employés qui les gèrent,
--     même si aucun employé n'est référencé
--     (vérifier la couverture managériale)
SELECT
    E.id_employe,
    E.role_employe,
    M.nom_maison
FROM Employes E
RIGHT JOIN Maison_de_Parfum M ON E.id_employe = M.id_employe
ORDER BY M.nom_maison;



-- PARTIE 4 — REQUÊTES IMBRIQUÉES
--            (NOT) IN, (NOT) EXISTS, ANY, ALL


-- 4.1 IN — Clients ayant commandé un parfum de la maison Chanel
--     (segment premium à inviter aux événements Chanel)
SELECT DISTINCT nom_clientele, coordonnees_client
FROM Clientele
WHERE id_clientele IN (
    SELECT C.id_clientele
    FROM Commande C
    JOIN Compose CO ON C.id_commande = CO.id_commande
    JOIN Parfum PA  ON CO.id_parfum  = PA.id_parfum
    WHERE PA.id_maison = 1
)
ORDER BY nom_clientele;

-- 4.2 NOT IN — Clients n'ayant jamais commandé de parfum Dior
--     (prospects à cibler pour les nouvelles sorties Dior)
SELECT nom_clientele, coordonnees_client
FROM Clientele
WHERE id_clientele NOT IN (
    SELECT C.id_clientele
    FROM Commande C
    JOIN Compose CO ON C.id_commande = CO.id_commande
    JOIN Parfum PA  ON CO.id_parfum  = PA.id_parfum
    WHERE PA.id_maison = 2
)
ORDER BY nom_clientele;

-- 4.3 EXISTS — Parfums ayant été commandés au moins une fois
--     (produits actifs à maintenir en stock)
SELECT nom_parfum, label_parfum
FROM Parfum P
WHERE EXISTS (
    SELECT 1
    FROM Compose CO
    WHERE CO.id_parfum = P.id_parfum
)
ORDER BY nom_parfum;

-- 4.4 NOT EXISTS — Parfums qui n'ont jamais été commandés
--     (produits dormants à promouvoir ou retirer du catalogue)
SELECT nom_parfum, label_parfum, description_parfum
FROM Parfum P
WHERE NOT EXISTS (
    SELECT 1
    FROM Compose CO
    WHERE CO.id_parfum = P.id_parfum
)
ORDER BY nom_parfum;

-- 4.5 ANY — Parfums dont le prix est supérieur à au moins
--     une commande promotionnelle
--     (produits dont la valeur justifie une promo)
SELECT id_commande, valeur
FROM Prix
WHERE valeur > ANY (
    SELECT valeur
    FROM Prix
    WHERE promo_debut IS NOT NULL
)
ORDER BY valeur DESC;

-- 4.6 ALL — Commandes dont la valeur est supérieure à toutes
--     les commandes promotionnelles
--     (transactions premium hors promo)
SELECT id_commande, valeur
FROM Prix
WHERE valeur > ALL (
    SELECT valeur
    FROM Prix
    WHERE promo_debut IS NOT NULL
)
ORDER BY valeur DESC;

-- 4.7 IN imbriqué — Familles olfactives présentes dans les commandes
--     de la saison printemps 2024 (pour orienter la campagne)
SELECT DISTINCT nom_famille
FROM Famille_Olfactive
WHERE id_famille IN (
    SELECT A.id_famille
    FROM Associe A
    JOIN Compose CO ON A.id_parfum    = CO.id_parfum
    JOIN Commande C ON CO.id_commande = C.id_commande
    WHERE C.date_commande BETWEEN '2024-03-01' AND '2024-05-31'
)
ORDER BY nom_famille;

-- 4.8 NOT EXISTS — Clients qui n'ont aucun avis renseigné
--     sur aucune de leurs commandes (clients silencieux)
SELECT nom_clientele, coordonnees_client
FROM Clientele CL
WHERE NOT EXISTS (
    SELECT 1
    FROM Commande C
    WHERE C.id_clientele  = CL.id_clientele
      AND C.avis_commande IS NOT NULL
)
ORDER BY nom_clientele;

-- 4.9 Sous-requête scalaire — Clients ayant dépensé plus
--     que la moyenne générale des commandes
--     (clients VIP à fidéliser avec des offres exclusives)
SELECT
    CL.nom_clientele,
    CL.coordonnees_client,
    P.valeur
FROM Clientele CL
JOIN Commande C ON CL.id_clientele = C.id_clientele
JOIN Prix P     ON C.id_commande   = P.id_commande
WHERE P.valeur > (
    SELECT AVG(valeur) FROM Prix
)
ORDER BY P.valeur DESC;

-- 4.10 IN multi-niveaux — Formats utilisés dans des commandes
--      de parfums orientaux passées après 2024
--      (formats à prévoir pour la gamme orientale 2025)
SELECT DISTINCT id_format, format_ml, emballage, concentration
FROM Formats
WHERE id_format IN (
    SELECT CO2.id_format
    FROM Coute CO2
    JOIN Commande C ON CO2.id_commande = C.id_commande
    WHERE C.date_commande >= '2024-01-01'
      AND C.id_commande IN (
          SELECT CO.id_commande
          FROM Compose CO
          JOIN Parfum PA  ON CO.id_parfum  = PA.id_parfum
          JOIN Associe A  ON PA.id_parfum  = A.id_parfum
          WHERE A.id_famille = 7 -- Orientale
      )
)
ORDER BY format_ml;

