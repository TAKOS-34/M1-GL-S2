drop table campus cascade constraints ;
drop table batiment cascade constraints ;
drop table salle cascade constraints ;
drop table exploite cascade constraints ;
drop table composante cascade constraints ;


create table campus (nomC varchar(16) constraint campus_pk primary key, ville varchar(20));

create table batiment (codeB varchar(16) constraint batiment_pk primary key, annee_construction integer, nomCampus varchar(16) constraint campus_fk references campus(nomC) on delete cascade);

create table salle (numSalle varchar(16) constraint salle_pk primary key, capacite integer, typeS varchar(12), accessibilite varchar(3), etage varchar(3), codeBatiment varchar(16) constraint batiment_fk references batiment(codeB) on delete cascade, constraint dom_typeS check (typeS in ('amphi','sc','td','tp','numerique')));

create table composante (acronyme varchar(8) constraint composante_pk primary key, nom varchar(50), responsable varchar(30));

create table exploite (acronyme varchar(8) constraint exploite_fk1 references composante(acronyme) on delete cascade, codeB varchar(16) constraint exploite_fk2 references batiment(codeB) on delete cascade, constraint exploite_pk primary key(acronyme,codeB));



