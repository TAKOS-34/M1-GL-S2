
insert into campus values ('Triolet','Montpellier');
insert into campus values ('St Priest','Montpellier');
insert into campus values ('Pharmacie','Montpellier');
insert into campus values ('Richter','Montpellier');
insert into campus values ('FDE Mende','Mende');
insert into campus values ('Medecine Nimes','Nimes');


insert into batiment (CODEB,ANNEEC,CAMPUS) values ('triolet_b36',2019,'Triolet');
insert into batiment (CODEB,ANNEEC,CAMPUS) values ('triolet_b16',1966,'Triolet');
insert into batiment (CODEB,ANNEEC,CAMPUS) values ('triolet_b05',1964,'Triolet');
insert into batiment (CODEB,ANNEEC,CAMPUS) values ('stPriest_b02',1982,'St Priest');

insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('A36.03',120,'amphi','oui','rdc','triolet_b36');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('A36.02',120,'amphi','oui','rdc','triolet_b36');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('A36.01',120,'amphi','oui','rdc','triolet_b36');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('TD36.202',40,'numerique','oui','2','triolet_b36');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('TD36.203',40,'numerique','oui','2','triolet_b36');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('TD36.204',40,'numerique','oui','2','triolet_b36');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('SC36.04',80,'sc','oui','1','triolet_b36');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('TD36.101',40,'td','oui','1','triolet_b36');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('TD36.302',40,'td','oui','3','triolet_b36');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('TD36.402',40,'td','oui','4','triolet_b36');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('SC16.03',120,'amphi','oui','rdc','triolet_b16');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('TD16.02',18,'td','oui','rdc','triolet_b16');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('TPDeptInfo',40,'numerique','oui','rdc','triolet_b16');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('TPBio',40,'tp','oui','rdc','triolet_b16');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('SC16.05',48,'sc','oui','rdc','triolet_b16');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('A5.02',275,'amphi','oui','1','triolet_b05');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('TD5.125',20,'numerique','oui','rdc','triolet_b05');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('TD5.126',31,'numerique','oui','rdc','triolet_b05');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('TD5.210',40,'td','oui','1','triolet_b05');
insert into salle (NUMS,CAPACITE,TYPES, ACCES, ETAGE, BATIMENT) values ('A_JJMoreau',114,'amphi','oui','1','stPriest_b02');


insert into composante values ('FDS','Faculte des Sciences','JM. Marin');
insert into composante values ('IAE','Ecole Universitaire de Management','E Houze');
insert into composante values ('Polytech','Polytech Montpellier','L. Torres');


insert into exploite (TEAM, BUILDING) values ('FDS','triolet_b16');
insert into exploite (TEAM, BUILDING) values ('IAE','triolet_b16');
insert into exploite (TEAM, BUILDING) values ('FDS','triolet_b36');
insert into exploite (TEAM, BUILDING) values ('IAE','triolet_b05');
commit;


