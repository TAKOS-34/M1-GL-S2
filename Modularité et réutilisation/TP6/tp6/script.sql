-- describe campus;
-- describe batiment;

drop table salle;
drop table batiment;
drop table campus;
drop table composante;
drop table exploite;

create table campus (nomC varchar(16), constraint campus_pk primary key(nomC), ville varchar(20));

create table batiment (codeB varchar(16), constraint batiment_pk primary key(codeB), anneeC integer, campus varchar(16), constraint campus_fk foreign key (campus) references campus(nomC) on delete cascade);

create table salle (numS varchar(16), constraint salle_pk primary key(numS), capacite integer, typeS varchar(12), acces varchar(3), etage varchar(3), batiment varchar(16), constraint batiment_fk foreign key(batiment) references batiment(codeB) on delete cascade, constraint dom_typeS check (typeS in ('amphi','sc','td','tp','numerique')));

create table composante (acronyme varchar(8), constraint composante_pk primary key (acronyme), nom varchar(50), responsable varchar(30));

create table exploite (team varchar(8), constraint exploite_fk1 foreign key(team) references composante(acronyme) on delete cascade, building varchar(16), constraint exploite_fk2 foreign key(building) references batiment(codeB) on delete cascade, constraint exploite_pk primary key(team,building));

insert into campus values ('Triolet','Montpellier');
insert into campus values ('St Priest','Montpellier');
insert into campus values ('Pharmacie','Montpellier');
insert into campus values ('Richter','Montpellier');
insert into campus values ('FDE Mende','Mende');
insert into campus values ('Medecine Nimes','Nimes');

insert into batiment values ('triolet_b36',2019,'Triolet');
insert into batiment values ('triolet_b16',1966,'Triolet');
insert into batiment values ('triolet_b05',1964,'Triolet');
insert into batiment values ('stPriest_b02',1982,'St Priest');

insert into salle values ('A36.03',120,'amphi','oui','rdc','triolet_b36');
insert into salle values ('A36.02',120,'amphi','oui','rdc','triolet_b36');
insert into salle values ('A36.01',120,'amphi','oui','rdc','triolet_b36');
insert into salle values ('TD36.202',40,'numerique','oui','2','triolet_b36');
insert into salle values ('TD36.203',40,'numerique','oui','2','triolet_b36');
insert into salle values ('TD36.204',40,'numerique','oui','2','triolet_b36');
insert into salle values ('SC36.04',80,'sc','oui','1','triolet_b36');
insert into salle values ('TD36.101',40,'td','oui','1','triolet_b36');
insert into salle values ('TD36.302',40,'td','oui','3','triolet_b36');
insert into salle values ('TD36.402',40,'td','oui','4','triolet_b36');
insert into salle values ('SC16.03',120,'amphi','oui','rdc','triolet_b16');
insert into salle values ('TD16.02',18,'td','oui','rdc','triolet_b16');
insert into salle values ('TPDeptInfo',40,'numerique','oui','rdc','triolet_b16');
insert into salle values ('TPBio',40,'tp','oui','rdc','triolet_b16');
insert into salle values ('SC16.05',48,'sc','oui','rdc','triolet_b16');
insert into salle values ('A5.02',275,'amphi','oui','1','triolet_b05');
insert into salle values ('TD5.125',20,'numerique','oui','rdc','triolet_b05');
insert into salle values ('TD5.126',31,'numerique','oui','rdc','triolet_b05');
insert into salle values ('TD5.210',40,'numerique','oui','1','triolet_b05');
insert into salle values ('A_JJMoreau',114,'amphi','oui','1','stPriest_b02');

insert into composante values ('FDS','Faculte des Sciences','JM. Marin');
insert into composante values ('IAE','Ecole Universitaire de Management','E Houze');
insert into composante values ('Polytech','Polytech Montpellier','L. Torres');

insert into exploite values ('FDS','triolet_b16');
insert into exploite values ('IAE','triolet_b16');
insert into exploite values ('FDS','triolet_b36');
insert into exploite values ('IAE','triolet_b05');
commit;




