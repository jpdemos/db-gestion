drop database MLR2
go

/* -----------------------------------------------------------------------------
      OUVERTURE DE LA BASE MLR2
----------------------------------------------------------------------------- */

create database MLR2
go

use MLR2
go



/* -----------------------------------------------------------------------------
      TABLE : ETATTICKET
----------------------------------------------------------------------------- */

create table ETATTICKET
  (
     IDETATTICKET int  not null  ,
     LABELETAT text  null  
     ,
     constraint PK_ETATTICKET primary key (IDETATTICKET)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : LOGICIELS
----------------------------------------------------------------------------- */

create table LOGICIELS
  (
     IDLOGICIEL int  not null  ,
     NOMLOGICIEL text  null  ,
     DATEINSTALLATION datetime  null  
     ,
     constraint PK_LOGICIELS primary key (IDLOGICIEL)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : INTERVENTION
----------------------------------------------------------------------------- */

create table INTERVENTION
  (
     IDINTERVENTION int  not null  ,
     IDTICKET int  not null  ,
     IDPERSONNEL int  not null  ,
     DATEINTERVENTION datetime  null  ,
     HEUREDEB datetime  null  ,
     HEUREFIN datetime  null  ,
     TRAVAILEFFECTUE text  null  
     ,
     constraint PK_INTERVENTION primary key (IDINTERVENTION)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : TYPETICKET
----------------------------------------------------------------------------- */

create table TYPETICKET
  (
     IDTYPETICKET int  not null  ,
     LABELTYPE text  null  ,
     COUPTICKET smallint  null  
     ,
     constraint PK_TYPETICKET primary key (IDTYPETICKET)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : TICKETINCIDENT
----------------------------------------------------------------------------- */

create table TICKETINCIDENT
  (
     IDTICKET int  not null  ,
     IDTYPETICKET int  not null  ,
     IDMAT int  not null  ,
     IDPERSONNEL int  not null  ,
     IDETATTICKET int  not null  ,
     DATETICKET datetime  null  ,
     RAISON text  null  ,
     NIVURG int  null  
     ,
     constraint PK_TICKETINCIDENT primary key (IDTICKET)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : REGIONCARRIERE
----------------------------------------------------------------------------- */

create table REGIONCARRIERE
  (
     IDREGCAR int  not null  ,
     LABELREGION text  null  
     ,
     constraint PK_REGIONCARRIERE primary key (IDREGCAR)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : MATERIEL
----------------------------------------------------------------------------- */

create table MATERIEL
  (
     IDMAT int  not null  ,
     IDPERSONNEL int  not null  ,
     PROCESSEUR text  null  ,
     MEM text  null  ,
     DISQUE text  null  
     ,
     constraint PK_MATERIEL primary key (IDMAT)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : SOCIETE
----------------------------------------------------------------------------- */

create table SOCIETE
  (
     IDSOCIETE int  not null  ,
     NOMSOCIETE text  null  ,
     ADRESSESOCIETE text  null  
     ,
     constraint PK_SOCIETE primary key (IDSOCIETE)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : COMPETENCE
----------------------------------------------------------------------------- */

create table COMPETENCE
  (
     IDCOMP int  not null  ,
     LABELCOMP text  null  
     ,
     constraint PK_COMPETENCE primary key (IDCOMP)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : PERSONNEL
----------------------------------------------------------------------------- */

create table PERSONNEL
  (
     IDPERSONNEL int  not null  ,
     NOMPERSONNEL text  null  ,
     PRENOMPERSONNEL text  null  ,
     ADRESSEPERSONNEL text  null  ,
     MATRICULE text  null  ,
     DATEEMB datetime  null  
     ,
     constraint PK_PERSONNEL primary key (IDPERSONNEL)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : TECHNICIEN
----------------------------------------------------------------------------- */

create table TECHNICIEN
  (
     IDPERSONNEL int  not null  ,
     NIVINTERVENTION int  null  ,
     FORMATION text  null  ,
     NOMPERSONNEL text  null  ,
     PRENOMPERSONNEL text  null  ,
     ADRESSEPERSONNEL text  null  ,
     MATRICULE text  null  ,
     DATEEMB datetime  null  
     ,
     constraint PK_TECHNICIEN primary key (IDPERSONNEL)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : LOCATION
----------------------------------------------------------------------------- */

create table LOCATION
  (
     IDMAT int  not null  ,
     DATEDEBLOC datetime  null  ,
     DATEFINLOC datetime  null  ,
     SOCIETE text  null  ,
     TICKETSDISPO int  null  ,
     PROCESSEUR text  null  ,
     MEM text  null  ,
     DISQUE text  null  
     ,
     constraint PK_LOCATION primary key (IDMAT)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : ACHAT
----------------------------------------------------------------------------- */

create table ACHAT
  (
     IDMAT int  not null  ,
     DATEOBTENTION datetime  null  ,
     FOURNISSEUR text  null  ,
     PROCESSEUR text  null  ,
     MEM text  null  ,
     DISQUE text  null  
     ,
     constraint PK_ACHAT primary key (IDMAT)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : DISPOSER
----------------------------------------------------------------------------- */

create table DISPOSER
  (
     IDMAT int  not null  ,
     IDLOGICIEL int  not null  
     ,
     constraint PK_DISPOSER primary key (IDMAT, IDLOGICIEL)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : APPARTIENT
----------------------------------------------------------------------------- */

create table APPARTIENT
  (
     IDMAT int  not null  ,
     IDSOCIETE int  not null  
     ,
     constraint PK_APPARTIENT primary key (IDMAT, IDSOCIETE)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : EFFECTUER
----------------------------------------------------------------------------- */

create table EFFECTUER
  (
     IDREGCAR int  not null  ,
     IDPERSONNEL int  not null  
     ,
     constraint PK_EFFECTUER primary key (IDREGCAR, IDPERSONNEL)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : ACQUÉRIR
----------------------------------------------------------------------------- */

create table ACQUÉRIR
  (
     IDCOMP int  not null  ,
     IDPERSONNEL int  not null  
     ,
     constraint PK_ACQUÉRIR primary key (IDCOMP, IDPERSONNEL)
  ) 
go



/* -----------------------------------------------------------------------------
      REFERENCES SUR LES TABLES
----------------------------------------------------------------------------- */



alter table INTERVENTION 
     add constraint FK_INTERVENTION_TECHNICIEN foreign key (IDPERSONNEL) 
               references TECHNICIEN (IDPERSONNEL)
go




alter table INTERVENTION 
     add constraint FK_INTERVENTION_TICKETINCIDENT foreign key (IDTICKET) 
               references TICKETINCIDENT (IDTICKET)
go




alter table TICKETINCIDENT 
     add constraint FK_TICKETINCIDENT_TYPETICKET foreign key (IDTYPETICKET) 
               references TYPETICKET (IDTYPETICKET)
go




alter table TICKETINCIDENT 
     add constraint FK_TICKETINCIDENT_MATERIEL foreign key (IDMAT) 
               references MATERIEL (IDMAT)
go




alter table TICKETINCIDENT 
     add constraint FK_TICKETINCIDENT_PERSONNEL foreign key (IDPERSONNEL) 
               references PERSONNEL (IDPERSONNEL)
go




alter table TICKETINCIDENT 
     add constraint FK_TICKETINCIDENT_ETATTICKET foreign key (IDETATTICKET) 
               references ETATTICKET (IDETATTICKET)
go




alter table MATERIEL 
     add constraint FK_MATERIEL_TECHNICIEN foreign key (IDPERSONNEL) 
               references TECHNICIEN (IDPERSONNEL)
go




alter table TECHNICIEN 
     add constraint FK_TECHNICIEN_PERSONNEL foreign key (IDPERSONNEL) 
               references PERSONNEL (IDPERSONNEL)
go




alter table LOCATION 
     add constraint FK_LOCATION_MATERIEL foreign key (IDMAT) 
               references MATERIEL (IDMAT)
go




alter table ACHAT 
     add constraint FK_ACHAT_MATERIEL foreign key (IDMAT) 
               references MATERIEL (IDMAT)
go




alter table DISPOSER 
     add constraint FK_DISPOSER_MATERIEL foreign key (IDMAT) 
               references MATERIEL (IDMAT)
go




alter table DISPOSER 
     add constraint FK_DISPOSER_LOGICIELS foreign key (IDLOGICIEL) 
               references LOGICIELS (IDLOGICIEL)
go




alter table APPARTIENT 
     add constraint FK_APPARTIENT_LOCATION foreign key (IDMAT) 
               references LOCATION (IDMAT)
go




alter table APPARTIENT 
     add constraint FK_APPARTIENT_SOCIETE foreign key (IDSOCIETE) 
               references SOCIETE (IDSOCIETE)
go




alter table EFFECTUER 
     add constraint FK_EFFECTUER_REGIONCARRIERE foreign key (IDREGCAR) 
               references REGIONCARRIERE (IDREGCAR)
go




alter table EFFECTUER 
     add constraint FK_EFFECTUER_PERSONNEL foreign key (IDPERSONNEL) 
               references PERSONNEL (IDPERSONNEL)
go




alter table ACQUÉRIR 
     add constraint FK_ACQUÉRIR_COMPETENCE foreign key (IDCOMP) 
               references COMPETENCE (IDCOMP)
go




alter table ACQUÉRIR 
     add constraint FK_ACQUÉRIR_TECHNICIEN foreign key (IDPERSONNEL) 
               references TECHNICIEN (IDPERSONNEL)
go




/*
 -----------------------------------------------------------------------------
               FIN DE GENERATION
 -----------------------------------------------------------------------------
*/