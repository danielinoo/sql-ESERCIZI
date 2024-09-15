--1

select WP.nome , WP.inizio, WP.fine
from WP
where WP.nome = 'Pegasus';

--2

select Persona.nome, Persona.cognome, Persona.posizione
from Persona 
where   AttivitaProgetto.progetto = 'Pegasus' 
        and AttivitaProgetto.persona = Persona.id
order by Persona.cognome desc;


--3

select Persona.nome, Persona.cognome, Persona.posizione
from (  select Persona.id
        from Persona 
        where AttivitaProgetto.progetto = 'Pegasus' 
        and AttivitaProgetto.persona = Persona.id) as pp
where   pp.persona

--4
select Persona.nome , Persona.cognome , Persona.posizione
from Persona
where posizione = 'Professore Ordinario' 
and Assenza.persona = Persona.id
and Assenza.tipo = 'malattia'