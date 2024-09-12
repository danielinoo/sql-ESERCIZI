--1
select distinct Persona.cognome
from Persona
where true;

--2
select Persona.nome, Persona.cognome
from Persona
where posizione = 'Ricercatore';

--3
select Persona.nome, Persona.cognome
from Persona
where posizione = 'Professore Associato' and cognome like 'V%';

--4
select Persona.nome, Persona.cognome
from Persona
where posizione != 'Ricercatore' and cognome like 'V%';

--5
select *
from Progetto
where fine < current_date;

--6
select Progetto.nome
from Progetto
where true
order by inizio asc;

--7
select WP.nome
from WP
where true
order by nome asc;

--8
select distinct Assenza.tipo
from Assenza
where true;

--9
select distinct AttivitaProgetto.tipo
from AttivitaProgetto
where true;


--10
select distinct AttivitaNonProgettuale.giorno
from AttivitaNonProgettuale
where tipo = 'Didattica'
order by giorno asc;


