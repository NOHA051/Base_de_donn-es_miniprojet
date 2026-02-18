# Base_de_donn-e_miniprojet
Tu travailles dans le domaine du parfum. Ton entreprise a comme activité de parfumerie. C’est une entreprise comme Sephora, Marionnaud. •  Fiches produits disponibles sur des sites e-commerce spécialisés en parfumerie et cosmétique
•  Descriptions officielles de maisons de parfum reconnues comme Chanel, Dior et Yves Saint Laurent
•  Plateformes de classification olfactive répertoriant les familles et pyramides de notes
•  Observations des formats, concentrations et variations disponibles sur le marché
•  Analyse du fonctionnement général des ventes en ligne (gestion des stocks, déclinaisons de produits, relation client)
. Inspire-toi du site suivant : https://www.olfastory.com/famille-olfactive
Ton entreprise veut appliquer MERISE pour concevoir un système d'information. Tu es chargé de la partie analyse, c’est-à-dire de collecter les besoins auprès de l’entreprise. Elle a fait appel à un étudiant en ingénierie informatique pour réaliser ce projet, tu dois lui fournir les informations nécessaires pour qu’il applique ensuite lui-même les étapes suivantes de conception et développement de la base de données. 
D’abord, établis les règles de gestions des données de ton entreprise, sous la forme d'une liste à puce. Elle doit correspondre aux informations que fournit quelqu’un qui connaît le fonctionnement de l’entreprise, mais pas comment se construit un système d’information.
Ensuite, à partir de ces règles, fournis un dictionnaire de données brutes avec les colonnes suivantes, regroupées dans un tableau : signification de la donnée, type, taille en nombre de caractères ou de chiffres. Il doit y avoir entre 25 et 35 données. Il sert à fournir des informations supplémentaires sur chaque donnée (taille et type) mais sans a priori sur comment les données vont être modélisées ensuite.
Fournis donc les règles de gestion et le dictionnaire de données.

Réponse :

Règles de gestion des données de l’entreprise : 
Chaque parfum appartient à une maison de parfum (ex. Chanel, Dior, YSL).
Chaque parfum est associé à une famille olfactive (ex. floral, boisé, oriental).
Un parfum peut avoir plusieurs notes de tête, cœur et fond, définissant sa pyramide olfactive.
Chaque parfum peut être disponible en différentes concentrations (ex. Eau de Parfum, Eau de Toilette, Extrait).
Les parfums existent sous plusieurs formats (ml) et emballages.
Chaque parfum a un prix, éventuellement différent selon le format ou la concentration.
Les parfums peuvent avoir des promotions temporaires avec des dates de début et fin.
L’entreprise gère un stock pour chaque parfum, format et concentration.
Les clients peuvent passer des commandes composées d’un ou plusieurs parfums.
Chaque commande a une date, un statut (en cours, expédiée, annulée) et un montant total.
Les clients ont un profil avec nom, prénom, adresse, email, téléphone et historique de commandes.
Les parfums ont des descriptions officielles provenant des maisons de parfum.
Les parfums ont des images pour la présentation en ligne.
Les parfums peuvent avoir des avis clients, avec note et commentaire.
Les employés peuvent gérer les parfums, les stocks et les commandes via un profil administrateur.
Chaque maison de parfum peut avoir un site officiel et des informations de contact.
Chaque famille olfactive peut regrouper plusieurs parfums et avoir une description.
Les clients peuvent enregistrer des préférences olfactives (familles, notes).
Les formats de parfum ont un code unique pour identifier chaque déclinaison.
Les parfums peuvent être nouveautés, en promotion, ou best-sellers.
L’entreprise suit les ventes par période, pour analyser les tendances.
Chaque parfum possède un SKU pour la gestion des stocks.
Les commandes peuvent inclure des codes promotionnels.
Les parfums peuvent avoir des labels ou certifications (ex. cruelty-free, bio).
Chaque parfum peut avoir des accessoires associés (ex. coffrets, produits complémentaires).
