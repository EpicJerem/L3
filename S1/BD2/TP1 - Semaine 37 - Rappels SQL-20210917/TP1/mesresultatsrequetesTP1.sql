/*
USAGE :
Utiliser ce fichier pour répondre aux différentes questions. Penser à remplir les champs Numéro carte, nom, prénom, date.
Pour chaque requete vous avez le résultat que vous devez obtenir.
Les questions sont entre commentaires (sauf la première). 
Attention sous ORACLE pour les marques des commentaires (le slash et l'étoile) doivent être seuls sur une ligne.
*/


/*
Numéro de carte étudiant : 21906253
Nom : Bentolila
Prénom : Jérémie
Date : 17/09/21
*/

/*
Mise en page - Ne pas toucher
*/
CLEAR SCREEN
SET PAGESIZE 30
COLUMN COLUMN_NAME FORMAT A30
SET LINESIZE 300



prompt -- Q1 - Quels sont les différents services (LIBELLE) proposés ?


SELECT LIBELLE FROM SERVICE;

/*
Résultat attendu :
LIBELLE
------------
BABYSITTING
PEINTURE
MENUISERIE
PLOMBERIE
JARDINAGE
*/

prompt -- Q2 - Quels sont les services (LIBELLES, DATESERVICE) qui ont été utilisés par le voisin DURAND PAUL ?

/*privilégier cette solution*/
SELECT LIBELLE,DATESERVICE 
FROM VOISIN
JOIN TRAVAIL ON IDVOIS=IDVOISIN
JOIN SERVICE ON IDSERV=IDSERVICE
WHERE NOM='DURAND' AND PRENOM='PAUL';

/*produit cartésien*/
SELECT LIBELLE,DATESERVICE 
FROM VOISIN,SERVICE,TRAVAIL 
WHERE NOM='DURAND' AND PRENOM='PAUL' AND IDSERV=IDSERVICE AND IDVOIS=IDVOISIN;
/*
Résultat attendu : 
LIBELLE      DATESERVIC
------------ ----------
BABYSITTING  02-05-2021
BABYSITTING  07-06-2021
BABYSITTING  08-06-2021
PLOMBERIE    06-06-2021

*/

prompt -- Q3 - Quel est le prix moyen et le prix maximum des services ? 

SELECT AVG(PRIX) AS "Moyenne des prix", MAX(PRIX) AS "Maximum des prix" FROM TRAVAIL;

/*
Résultat attendu :
Moyenne des prix Maximum des prix
---------------- ----------------
      69,3333333	      100

*/

prompt -- Q4 - Quels sont les voisins qui n ont pas de ville ?

SELECT NOM FROM VOISIN WHERE VILLE IS NULL;

/*
Résultat attendu : 
NOM
----------
DULAC
*/

prompt -- Q5 - Quels sont les voisins (NOM, PRENOM) qui ont eu au moins un service dont le prix est supérieur au prix moyen des services ?

SELECT NOM,PRENOM,LIBELLE,PRIX
FROM VOISIN 
JOIN TRAVAIL ON IDVOIS=IDVOISIN
JOIN SERVICE ON IDSERV=IDSERVICE
WHERE (SELECT AVG(PRIX) FROM TRAVAIL)<PRIX;

/*
Résulat attendu : 
NOM	   PRENOM     LIBELLE		 PRIX
---------- ---------- ------------ ----------
DUPOND	   PIERRE     MENUISERIE	   70
DUPOND	   PIERRE     PLOMBERIE 	   80
DUPOND	   PIERRE     JARDINAGE 	   90
DUPOND	   PIERRE     JARDINAGE 	   80
DUPOND	   PIERRE     BABYSITTING	  100
DUPOND	   PIERRE     BABYSITTING	   70
DURAND	   PAUL       BABYSITTING	   70
DURAND	   PAUL       PLOMBERIE 	  100
*/

prompt -- Q6 - Insérer dans la relation SERVICE, deux nouveaux tuples dont les identifiants (IDSERVICE) sont respectivement 6 et 7 et les libellés (LIBELLE) 'JARDINAGE' et 'MENAGE' (en majuscule).

INSERT INTO SERVICE(IDSERVICE,LIBELLE) VALUES ('6','JARDINAGE');
INSERT INTO SERVICE(IDSERVICE,LIBELLE) VALUES ('7','MENAGE');

/*
Résulat attendu : 
1 ligne creee.
1 ligne creee.
*/

prompt -- Q7 - Quels sont les services (LIBELLE) qui ne sont proposés par aucun voisin ? 

SELECT LIBELLE
FROM SERVICE
WHERE IDSERVICE NOT IN(SELECT IDSERV FROM TRAVAIL);

/*
Résulat attendu : 
LIBELLE
------------
JARDINAGE
MENAGE
*/

prompt -- Q8 - Quels sont les différents services (LIBELLE) proposés ? Proposez 2 solutions différentes pour ne pas voir apparaître 2 fois le libellé JARDINAGE - Solution avec les duplicats

SELECT LIBELLE FROM SERVICE;

/*
Résulat attendu : 
LIBELLE
------------
BABYSITTING
PEINTURE
MENUISERIE
PLOMBERIE
JARDINAGE
JARDINAGE
MENAGE

7 lignes selectionnees.
*/

prompt -- Q8 - Quels sont les différents services (LIBELLE) proposés ? Proposez 2 solutions différentes pour ne pas voir apparaître 2 fois le libellé JARDINAGE - Solution 1

SELECT LIBELLE FROM SERVICE GROUP BY LIBELLE;
/*
Résulat attendu : 
LIBELLE
------------
MENUISERIE
PEINTURE
JARDINAGE
MENAGE
BABYSITTING
PLOMBERIE

6 lignes selectionnees.
*/

prompt -- Q8 - Quels sont les différents services (LIBELLE) proposés ? Proposez 2 solutions différentes pour ne pas voir apparaître 2 fois le libellé JARDINAGE - Solution 2

SELECT DISTINCT LIBELLE FROM SERVICE;
/*
Résulat attendu : 
LIBELLE
------------
MENUISERIE
PEINTURE
JARDINAGE
MENAGE
BABYSITTING
PLOMBERIE

6 lignes selectionnees.
*/

prompt -- Q9 - Supprimer les deux derniers tuples insérés précédemment dans la relation SERVICE (C.f. question Q6)

DELETE FROM SERVICE WHERE IDSERVICE='6' OR IDSERVICE='7';

/*
Résulat attendu : 
1 ligne supprimee.
1 ligne supprimee.
*/

prompt -- Q10 - Quels sont les voisins (NOM, PRENOM) qui ont fait le plus de prestations ? 

/*
VOTRE REPONSE ICI
*/
SELECT NOM,PRENOM 
FROM TRAVAIL 
WHERE COUNT(*)=MAX(SELECT COUNT(*) FROM TRAVAIL GROUP BY IDVOIS);


/*
Résulat attendu : 
NOM	   PRENOM
---------- ----------
DUPOND	   PIERRE
*/

prompt -- Q11 - Quels sont les services (LIBELLE) facturés les plus chers (PRIX) mais par catégorie de service pour chaque voisin (NOM, PRENOM) ?  Par exemple si Dupond Pierre fait deux fois du  Babysitting pour 200 euros et 100 euros puis  du Jardinage pour 80 euros, le résultat attendu est  : Babysitting Dupond Pierre 200 Jardinage   Dupond Pierre 80

/*
VOTRE REPONSE ICI
*/
	   
/*
Résulat attendu :  
LIBELLE        IDVOISIN NOM	   PRENOM	    PRIX
------------ ---------- ---------- ---------- ----------
BABYSITTING	      1 DUPOND	   PIERRE	      50
PEINTURE	      1 DUPOND	   PIERRE	      60
MENUISERIE	      1 DUPOND	   PIERRE	      70
PLOMBERIE	      1 DUPOND	   PIERRE	      80
JARDINAGE	      1 DUPOND	   PIERRE	      90
BABYSITTING	      2 DUPOND	   PIERRE	     100
PLOMBERIE	      3 DURAND	   PAUL 	     100
BABYSITTING	      3 DURAND	   PAUL 	      70
MENUISERIE	      4 DUCHEMIN   MICHEL	      60
PLOMBERIE	      4 DUCHEMIN   MICHEL	      50

10 lignes selectionnees.
*/
prompt -- Q12 - Quels sont les voisins (NOM, PRENOM) qui ont fait tous les services ?

/*
VOTRE REPONSE ICI
*/
	 
/*
Résulat attendu :
NOM	   PRENOM
---------- ----------
DUPOND	   PIERRE
*/

