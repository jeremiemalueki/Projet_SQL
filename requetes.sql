--[1] Donnez le nom et prénom des médecins de l'hôpital.
SELECT NOM,PRENOM FROM PERSONNEL
WHERE Profession = 'Medecin';

--[2] Affichez le nombre d’infirmiers par service.
SELECT count(AFFECTATION.Num_insee) AS nombre_infirmier,Code_service FROM AFFECTATION
JOIN PERSONNEL ON PERSONNEL.Num_insee = AFFECTATION.Num_insee
WHERE PERSONNEL.Profession='Infirmier'
GROUP BY AFFECTATION.Code_service;

--[3] Donnez les noms des patients atteints de diabète, par ordre d'arrivée dans l'hôpital.
SELECT prenom,nom,nom_patho FROM PATIENT
NATURAL JOIN VISITE
NATURAL JOIN PATHOLOGIE
WHERE nom_patho = 'diabete'
ORDER BY date_arrivee;

--[4] Combien de patients ont reçu un soin dans le service cardiologie en 2015 ?
SELECT count(num_inter) FROM INTERVENTION
WHERE code_service=2 AND date_inter like('%/%/2015');

--[5] Quelle est la durée maximale de visite d’un patient depuis 2017 ?
SELECT (date_sortie - date_arrivee) FROM VISITE
WHERE date_arrivee > '01/01/2017';

--[6] Quels médecins travaillent à la fois dans les services pédiatrie et cardiologie ?
SELECT DISTINCT pers.num_insee,pers.prenom,pers.nom FROM PERSONNEL pers
JOIN AFFECTATION aff ON pers.num_insee = aff.num_insee 
JOIN SERVICE ser ON ser.code_service = aff.code_service
WHERE ser.nom IN('Pediatrie','Cardiologie');

--[7] Quels patients ont reçu un soin de la part du Dr. Rachoul, triés par ordre d'arrivée ?
SELECT pat.PRENOM,pat.NOM,pers.nom as docteur FROM PATIENT pat
JOIN INTERVENTION inter ON pat.num_insee = inter.num_pat
JOIN PERSONNEL pers ON  inter.num_persh = pers.num_insee
JOIN VISITE vis ON pat.num_insee = vis.num_insee
WHERE inter.num_persh=2
ORDER BY date_arrivee;

--[8] Afficher les salles de pédiatrie triées selon le nombre de soins (décroissant) en 2020
-- requete fausse
SELECT inter.num_salle,serv.nom FROM INTERVENTION inter
JOIN SALLE sal ON inter.num_salle = sal.num_salle
join SERVICE serv ON sal.code_service = serv.code_service
WHERE serv.nom = 'Pediatrie';


--[9] Quel médecin a effectué le plus de soins en 2015 ?
SELECT Num_persh,count(num_inter) FROM INTERVENTION inter
where EXTRACT(YEAR FROM date_inter) = '2015'
group by Num_persh;

--[10] Le soin “greffe de rein" a-t-il plus de résultats positifs que négatifs (OUI, NON) ?
SELECT avg(resultat) FROM INTERVENTION
where nom_soin = 'greffe de rein' 
	case
		when avg(resultat) >= 0.5 then 'OUI';

--[11] Affichez les soins qui ont un coût moyen supérieur 1000 euros, classés par coût.
SELECT nom_soin,avg(cout) FROM INTERVENTION
group by nom_soin
HAVING avg(cout) >= 1000;