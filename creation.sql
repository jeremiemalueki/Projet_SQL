DROP TABLE SERVICE CASCADE CONSTRAINTS;
DROP TABLE SALLE CASCADE CONSTRAINTS;
DROP TABLE PERSONNEL CASCADE CONSTRAINTS;
DROP TABLE AFFECTATION CASCADE CONSTRAINTS;
DROP TABLE TEL_PERSONNEL CASCADE CONSTRAINTS;
DROP TABLE PATIENT CASCADE CONSTRAINTS;
DROP TABLE TEL_PATIENT CASCADE CONSTRAINTS;
DROP TABLE VISITE CASCADE CONSTRAINTS;
DROP TABLE PATHOLOGIE CASCADE CONSTRAINTS;
DROP TABLE SOIN CASCADE CONSTRAINTS;
DROP TABLE INTERVENTION CASCADE CONSTRAINTS;

CREATE TABLE SERVICE(
    Code_Service NUMBER(2),
    Nom VARCHAR2(25),
    Num_tel NUMBER(10),

    CONSTRAINT PK_SERVICE PRIMARY KEY(Code_Service),
    CONSTRAINT NN_SERVICE_NOM CHECK(Nom IS NOT NULL),
    CONSTRAINT NN_SERVICE_NUM_TEL CHECK(Num_tel IS NOT NULL)
);

CREATE TABLE SALLE(
    Num_Salle NUMBER(2),
    Code_Service NUMBER(2),
    Volume NUMBER(4),
    Taux_occupation NUMBER(3),
    

    CONSTRAINT PK_SALLE PRIMARY KEY(Num_Salle,Code_Service),
	CONSTRAINT UQ_NUMSALLE_SALLE UNIQUE(Num_Salle),
    CONSTRAINT FK_SALLE_Code_Service_SERVICE_Code_Service FOREIGN KEY (Code_Service) REFERENCES SERVICE(Code_Service),
    CONSTRAINT NN_SALLE_VOLUME CHECK(Volume IS NOT NULL),
    CONSTRAINT CK_TAUXOCCUP_SALLE CHECK(Taux_occupation <100)
);

CREATE TABLE PERSONNEL(
    Num_insee NUMBER(4),
    Prenom VARCHAR2(25),
    Nom VARCHAR2(25),
    Adresse VARCHAR2(100),
    Profession VARCHAR2(25),
    SuperNum_insee NUMBER(4),
    CONSTRAINT PK_PERSONNEL PRIMARY KEY(Num_insee),
    CONSTRAINT FK_PERSONNEL_SUPERNUMINSEE_NUM FOREIGN KEY (SuperNum_insee) REFERENCES PERSONNEL(Num_insee),
    CONSTRAINT NN_PERSONNEL_NOM CHECK(Nom IS NOT NULL),
    CONSTRAINT NN_PERSONNEL_PRENOM CHECK(Prenom IS NOT NULL),
    CONSTRAINT NN_PERSONNEL_ADRESSE CHECK(Adresse IS NOT NULL),
    CONSTRAINT NN_PERSONNEL_PROFESSION CHECK(Profession IS NOT NULL),
    CONSTRAINT CK_PERSONNEL_PROFESSION CHECK(Profession IN('Directeur','Medecin','Infirmier'))
);

CREATE TABLE AFFECTATION(
    Num_insee NUMBER(4),
    Code_Service NUMBER(2),
    CONSTRAINT PK_AFFECTATION PRIMARY KEY(Num_insee,Code_Service),
    CONSTRAINT FK_AFFECTATION_NUMINSEE_PERSONNEL_NUMINSEE FOREIGN KEY(Num_insee) REFERENCES PERSONNEL(Num_insee),
    CONSTRAINT FK_AFFECTATION_CODESERVICE_SERVICE_CODESERVICE FOREIGN KEY (Code_Service) REFERENCES SERVICE(Code_Service)
);

CREATE TABLE TEL_PERSONNEL(
    Num_tel NUMBER(10),
    Num_insee NUMBER(4),
    CONSTRAINT PK_TEL_PERSONNEL PRIMARY KEY (Num_tel,Num_insee),
    CONSTRAINT FK_TEL_PERSONNEL_NUMINSEE_PERSONNEL_NUMINSEE FOREIGN KEY(Num_insee) REFERENCES PERSONNEL(Num_insee)
);

CREATE TABLE PATIENT(
    Num_insee NUMBER(4),
    Prenom VARCHAR2(25),
    Nom VARCHAR2(25),
    Adresse VARCHAR2(100),
    Num_persHosp NUMBER(4),
    CONSTRAINT PK_PATIENT PRIMARY KEY (Num_insee),
    CONSTRAINT FK_PATIENT_NUMPERSHOSP_PERSONNEL_NUMINSEE FOREIGN KEY (Num_PersHosp) REFERENCES PERSONNEL(Num_insee),
    CONSTRAINT NN_PATIENT_NOM CHECK(Nom IS NOT NULL),
    CONSTRAINT NN_PATIENT_PRENOM CHECK(Prenom IS NOT NULL),
    CONSTRAINT NN_PATIENT_ADRESSE CHECK(Adresse IS NOT NULL)
);

CREATE TABLE TEL_PATIENT(
    Num_tel NUMBER(10),
    Num_insee NUMBER(4),
    CONSTRAINT PK_TEL_PATIENT PRIMARY KEY (Num_tel,Num_insee),
    CONSTRAINT FK_TEL_PATIENT_NUMINSEE_PATIENT_NUMINSEE FOREIGN KEY(Num_insee) REFERENCES PATIENT(Num_insee)
);


CREATE TABLE PATHOLOGIE(
    Num_patho NUMBER(4),
    Nom_patho VARCHAR2(100),
    Code_Service NUMBER(2),
    CONSTRAINT PK_PATHOLOGIE PRIMARY KEY (Num_patho),
    CONSTRAINT FK_PATHOLOGIE_CODESERVICE_SERVICE_CODESERVICE FOREIGN KEY (Code_Service) REFERENCES SERVICE(Code_Service),
    CONSTRAINT NN_PATHOLOGIE_NOMPATHO CHECK(Nom_patho IS NOT NULL)
);

CREATE TABLE VISITE(
    Num_insee NUMBER(4),
    Num_patho NUMBER(4),
    Code_Service NUMBER(2),
    Date_arrivee DATE,
    Date_sortie DATE,
    CONSTRAINT PK_VISITE PRIMARY KEY (Num_insee,Date_arrivee),
    CONSTRAINT FK_VISITE_NUMINSEE_PATIENT_NUMINSEE FOREIGN KEY(Num_insee) REFERENCES PATIENT(Num_insee),
    CONSTRAINT FK_VISITE_NUMPATHO_PATHOLOGIE_NUMPATHO FOREIGN KEY(Num_patho) REFERENCES PATHOLOGIE(Num_patho),
    CONSTRAINT FK_VISITE_CODESERVICE_SERVICE_CODESERVICE FOREIGN KEY(Code_Service) REFERENCES SERVICE(Code_Service),
    CONSTRAINT NN_VISITE_DATEARRIVEE CHECK( Date_arrivee IS NOT NULL)
);

CREATE TABLE SOIN(
    Nom_Soin VARCHAR2(100),
    Num_patho NUMBER(4),
    CONSTRAINT PK_SOIN PRIMARY KEY (Nom_Soin,Num_patho),
	CONSTRAINT UQ_NOMSOIN_SOIN UNIQUE(Nom_Soin),
	CONSTRAINT NN_NOMSOIN_SOIN CHECK(Nom_Soin IS NOT NULL),
    CONSTRAINT FK_SOIN_NUMPATHO_PATHOLOGIE_NUMPATHO FOREIGN KEY (Num_patho) REFERENCES PATHOLOGIE(Num_patho)
);

CREATE TABLE INTERVENTION(
    Num_inter NUMBER(5),
	Nom_Soin VARCHAR2(100),
    Num_patho NUMBER(4),
    Code_Service NUMBER(2),
    Num_Salle NUMBER(2),
    Num_pat NUMBER(4),
    Num_persh NUMBER(4),
    Date_inter DATE,
    cout NUMBER(6),
    resultat NUMBER(1),
    CONSTRAINT PK_INTERVENTION PRIMARY KEY (Num_inter,Nom_Soin,Num_patho),
	CONSTRAINT FK_INTERVENTION_NOMSOIN_SOIN_NOMSOIN FOREIGN KEY (Nom_Soin) REFERENCES SOIN(Nom_Soin),
    CONSTRAINT FK_INTERVENTION_NUMPATHO_PATHOLOGIE_NUMPATHO FOREIGN KEY (Num_patho) REFERENCES PATHOLOGIE(Num_patho),
    CONSTRAINT FK_INTERVENTION_CODESERVICE_SERVICE_CODESERVICE FOREIGN KEY (Code_Service) REFERENCES SERVICE(Code_Service),
    CONSTRAINT FK_INTERVENTION_NUMSALLE_SALLE_NUMSALLE FOREIGN KEY (Num_Salle) REFERENCES SALLE(Num_Salle),
    CONSTRAINT FK_INTERVENTION_NUMPERSH_PERSONNEL_NUMINSEE FOREIGN KEY (Num_persh) REFERENCES PERSONNEL(Num_insee),
    CONSTRAINT FK_INTERVENTION_NUMPAT_PATIENT_NUMINSEE FOREIGN KEY (Num_pat) REFERENCES PATIENT(Num_insee),
    CONSTRAINT NN_INTERVENTION_CODESERVICE CHECK(Code_Service IS NOT NULL),
    CONSTRAINT NN_INTERVENTION_NUMSALLE CHECK(Num_Salle IS NOT NULL),
    CONSTRAINT NN_INTERVENTION_DATEINTER CHECK(Date_inter IS NOT NULL),
    CONSTRAINT CK_INTERVENTION_RESULTAT CHECK(resultat IN (0,1))
);