--(Code_Service, Nom, Num_Tel)
insert into SERVICE values (1,'Pediatrie',0111223344);
insert into SERVICE values (2,'Cardiologie',0122334455);
insert into SERVICE values (3,'Endocrinologie',0125687498);
insert into SERVICE values (4,'Néphrologie',0178893201);

--(Num_Salle, Code_Service*, Volume, Taux_occupation)
insert into SALLE values(1,1,100,50);
insert into SALLE values(6,1,150,15);
insert into SALLE values(2,1,150,25);
insert into SALLE values(4,2,90,75);
insert into SALLE values(5,3,100,50);
insert into SALLE values(3,4,50,15);

insert into PERSONNEL (Num_insee,Prenom,Nom,Adresse,Profession) 
values(1,'Gregory','House','10 rue des presles, 75016 Paris','Directeur');
insert into PERSONNEL values(2,'Didier','Rachoul','13 rue de chloroquine,13000 Marseille','Medecin',1);
insert into PERSONNEL values(3,'Samuel','Etoo','114 route des Lions, 75001 Paris','Medecin',1);
insert into PERSONNEL values(4,'Yazid','Zidane','20 boulevard de la liberation, 13000 Marseille','Medecin',1);
insert into PERSONNEL values(5,'Jean','Doe','1 rue du Soldat inconnu, 75010 Paris','Infirmier',2);
insert into PERSONNEL values(6,'Gerard','Junior','12 rue jean baptiste clement, 93800 Epinay sur Seine','Infirmier',2);
insert into PERSONNEL values(7,'Eric','Lejeune','72 avenue Leclerc, 93270 Sevran','Infirmier',4);
insert into PERSONNEL values(8,'Gerard','Phillipe','13 rue jean baptiste clement, 93800 Epinay sur Seine','Infirmier',3);
insert into PERSONNEL values(9,'Alexandre','Grand','3 alle du port, 75018 Paris','Infirmier',3);

--(Num_INSEE*, code_service*)
insert into AFFECTATION values(2,1);
insert into AFFECTATION values(2,2);
insert into AFFECTATION values(2,3);
insert into AFFECTATION values(3,3);
insert into AFFECTATION values(4,1);
insert into AFFECTATION values(4,2);
insert into AFFECTATION values(4,3);
insert into AFFECTATION values(5,1);
insert into AFFECTATION values(6,2);
insert into AFFECTATION values(7,3);
insert into AFFECTATION values(8,4);
insert into AFFECTATION values(9,1);


insert into TEL_PERSONNEL values(0610111213,1);
insert into TEL_PERSONNEL values(0619151214,2);
insert into TEL_PERSONNEL values(0719151218,2);
insert into TEL_PERSONNEL values(0749165214,3);
insert into TEL_PERSONNEL values(0625489127,4);
insert into TEL_PERSONNEL values(0698753245,5);
insert into TEL_PERSONNEL values(0712368475,6);
insert into TEL_PERSONNEL values(0617895261,7);
insert into TEL_PERSONNEL values(0688952410,8);
insert into TEL_PERSONNEL values(0635875294,9);

insert into PATIENT (Num_insee,Prenom,Nom,Adresse) values(1,'Jean-Luc','Perez','48 alle du chene, 93800 Epinay sur Seine');
insert into PATIENT (Num_insee,Prenom,Nom,Adresse) values(2,'Louis','Perez','48 alle du chene, 93800 Epinay sur Seine');
insert into PATIENT (Num_insee,Prenom,Nom,Adresse) values(3,'Pierre','Martin','1 route du Stade, 93430 Villetaneuse');
insert into PATIENT (Num_insee,Prenom,Nom,Adresse) values(4,'Bernard','Laporte','15 route du Stade, 93430 Villetaneuse');
insert into PATIENT (Num_insee,Prenom,Nom,Adresse) values(5,'Kevin','Adama','11 rue du rire, 75015 Paris');

insert into TEL_PATIENT values(0698563214,1);
insert into TEL_PATIENT values(0628763217,2);
insert into TEL_PATIENT values(0700563214,3);
insert into TEL_PATIENT values(0720585496,4);
insert into TEL_PATIENT values(0612580096,5);

--PATHOLOGIE (Num_patho, Nom, Code_Service)
insert into PATHOLOGIE values(1,'insuffisance renale',4);
insert into PATHOLOGIE values(2,'grippe',1);
insert into PATHOLOGIE values(3,'diabete',3);
insert into PATHOLOGIE values(4,'arythmie cardiaque',2);

-- VISITE (Num_INSEE*,Num_patho*, Code_Service*,Date_arrivee, Date_sortie)
insert into VISITE values(1,1,4,'08/01/2014','20/01/2014');
insert into VISITE values(2,4,2,'25/03/2018','12/05/2018');
insert into VISITE values(3,2,1,'25/03/2020','26/03/2020');
insert into VISITE values(4,3,3,'15/02/2015','17/02/2015');
insert into VISITE values(4,3,3,'16/02/2020','17/02/2020');
insert into VISITE values(5,3,3,'14/09/2016','17/09/2016');

insert into SOIN values('greffe de rein',1);
insert into SOIN values('injection aspirine',2);
insert into SOIN values('prise d insuline',3);
insert into SOIN values('implantation d un pacemaker',4);
insert into SOIN values('Massage cardiaque',4);

--(Num_Inter, Nom_Soin*, Num_Patho*,Code_Service*, Num_Salle*, Num_pat*, Num_persh*,  Date_Inter, cout, resultat)
insert into INTERVENTION values(1,'implantation d un pacemaker',4,2,4,3,3,'27/03/2018',1000,1);
insert into INTERVENTION values(2,'Massage cardiaque',4,2,4,2,3,'27/03/2018',100,1);
insert into INTERVENTION values(3,'prise d insuline',3,3,5,4,4,'16/02/2015',150,1);
insert into INTERVENTION values(4,'prise d insuline',3,3,5,4,2,'16/02/2020',150,1);
insert into INTERVENTION values(5,'injection aspirine',2,1,6,3,1,'25/03/2020',1,0);
insert into INTERVENTION values(6,'injection aspirine',2,1,1,3,1,'25/03/2020',1,1);
insert into INTERVENTION values(7,'injection aspirine',2,1,6,3,1,'26/03/2020',1,1);
insert into INTERVENTION values(8,'greffe de rein',1,4,3,1,4,'27/03/2018',5000,0);
insert into INTERVENTION values(9,'greffe de rein',1,4,3,1,2,'27/03/2018',5000,1);