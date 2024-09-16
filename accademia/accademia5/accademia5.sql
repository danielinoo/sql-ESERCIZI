--1

select WP.nome , WP.inizio, WP.fine
from WP
where WP.nome = 'Pegasus';

--2

select distinct Persona.nome, Persona.cognome, Persona.posizione
from Persona ,AttivitaProgetto,progetto,WP
where  Progetto.nome = 'Pegasus'
and AttivitaProgetto.progetto = WP.progetto and AttivitaProgetto.wp = WP.id
and WP.progetto = Progetto.id
and AttivitaProgetto.persona = Persona.id
order by Persona.cognome desc;


--3
select pero


--4
select Persona.nome , Persona.cognome , Persona.posizione
from Persona
where posizione = 'Professore Ordinario' 
and Assenza.persona = Persona.id
and Assenza.tipo = 'malattia'