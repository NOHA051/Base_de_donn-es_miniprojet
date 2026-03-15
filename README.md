
Réponse de l'IA :

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

<img width="590" height="330" alt="image" src="https://github.com/user-attachments/assets/4c81d718-f57b-4970-9b14-a92ee9dc3094" />

-----------------------------------------------Le modèle relationel logique-----------------------------------------------------------------

Employés (id_employé, rôle_employé, #id_manager)
Maison_de_Parfum (id_maison, nom_maison, stock, #id_employé)
Clientele (id_clientele, nom_clientele, coordonnées_client)
Commande (id_commande, date_commande, avis_commande, #id_clientele)
Prix (id_commande, valeur, promo_debut, promo_fin)
Parfum (id_parfum, nom_parfum, description_parfum, label_parfum, #id_maison)
Famille_Olfactive (id_famille, nom_famille, note_tete, note_coeur, note_fond)
Formats (id_format, format_ml, emballage, concentration)
Composé (#id_commande, #id_parfum)
Associé (#id_parfum, #id_famille)
Existe_sous (#id_parfum, #id_format)
Coute (#id_commande, #id_format)
Cible (#id_clientele, #id_maison)




-----------------------------------------Prompt de l'étape 4, l'insertion des données-------------------------------------------------------

Donne les requêtes d’insertion permettant de remplir la base de données dont le modèle relationnel est le suivant : 
Employés (<u>id_employé</u>, rôle_employé, #id_manager)
Maison_de_Parfum (<u>id_maison</u>, nom_maison, stock, #id_employé)
Clientele (<u>id_clientele</u>, nom_clientele, coordonnées_client)
Commande (<u>id_commande</u>, date_commande, avis_commande, #id_clientele)
Prix (<u>id_commande</u>, valeur, promo_debut, promo_fin)
Parfum (<u>id_parfum</u>, nom_parfum, description_parfum, label_parfum, #id_maison)
Famille_Olfactive (<u>id_famille</u>, nom_famille, note_tete, note_coeur, note_fond)
Formats (<u>id_format</u>, format_ml, emballage, concentration)
Composé (<u>#id_commande, #id_parfum</u>)
Associé (<u>#id_parfum, #id_famille</u>)
Existe_sous (<u>#id_parfum, #id_format</u>)
Coute (<u>#id_commande, #id_format</u>)
Cible (<u>#id_clientele, #id_maison</u>)

Les clés primaires correspondent aux id, sauf si autre chose est précisé (quand c'est un attribut composé) les clés étrangères sont identifiées par les #, et ont le même nom que les clés primaires auxquelles elles font référence.
Voici le nombre de lignes souhaitées par table :
- Employes :  100
- Maison_de_Parfum : 5
- Clientele : 500
- Famille_Olfactive : 7
- Formats : 40
- Parfum : 100
- Commande : 500
- Prix : 30

Valeurs spécifiques souhaitées :
- [mets comme famille olfactive : aromatique, boisée, chyprée, fleurie, fougère, hesperidée, orientale ]
- [pour les prix tu les fait varier entre 90 et 200 euro les 100mL ]
- [pour les formats mets des formats suivant : 100ml, 200mL, 80mL, ect ]

Les clés étrangères doivent faire référence aux clés primaires existantes : donne les lignes en commençant par remplir les tables dans lesquelles il n'y a pas de clés étrangères, puis les tables dans lesquelles les clés étrangères font références à des clés primaires des tables déjà remplies. 

Fournis l'ensemble sous la forme d’un script SQL prêt à être exécuté.

Génère des données SQL réalistes pour une base de données de parfumerie.
