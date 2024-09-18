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
select distinct pp.nome, pp.cognome, pp.posizione
from Persona pp
join AttivitaProgetto a1 on pp.id = a1.persona
join AttivitaProgetto a2 on  pp.id = a2.persona
join WP wp on a1.progetto = wp.progetto
where wp.nome = 'Pegasus'
and a1.id <> a2.id; 


--4
select distinct Persona.nome , Persona.cognome , Persona.posizione
from Persona,Assenza
where posizione = 'Professore Ordinario' 
and Assenza.persona = Persona.id
and Assenza.tipo = 'Malattia';

--5
select distinct pp.nome ,pp.cognome
from Persona,Assenza
join Persona pp on pp.id = Assenza.id and Assenza.tipo = 'Malattia'
where pp.posizione = 'Professore Ordinario'
and pp.id > 1;

--6
select distinct pp.nome , pp.cognome,pp.posizione
from Persona,AttivitaNonProgettuale
join Persona pp on pp.id = AttivitaNonProgettuale.persona and AttivitaNonProgettuale.tipo = 'Didattica'
where pp.posizione = 'Ricercatore';
--7
select distinct pp.nome , pp.cognome,pp.posizione
from Persona pp,AttivitaNonProgettuale
where pp.id = AttivitaNonProgettuale.persona 
and AttivitaNonProgettuale.tipo = 'Didattica'
and pp.posizione = 'Ricercatore'
and pp.id >1;

--8
select pp.nome , pp.cognome
from Persona pp,AttivitaNonProgettuale,AttivitaProgetto
where pp.id = AttivitaNonProgettuale.persona 
and pp.id = AttivitaProgetto.persona
and AttivitaNonProgettuale.giorno = AttivitaProgetto.giorno;

--9
select pp.nome,pp.cognome,AttivitaNonProgettuale.giorno,Progetto.nome,AttivitaNonProgettuale.tipo,AttivitaNonProgettuale.oreDurata,AttivitaProgetto.tipo,AttivitaProgetto.oreDurata
from Persona pp, AttivitaNonProgettuale,WP,AttivitaProgetto,Progetto
where pp.id = AttivitaNonProgettuale.persona 
and pp.id = AttivitaProgetto.persona
and AttivitaNonProgettuale.giorno = AttivitaProgetto.giorno
and AttivitaProgetto.progetto = WP.progetto and AttivitaProgetto.wp = WP.id
and WP.progetto = Progetto.id;

--10
select Persona.nome,Persona.cognome
from Persona,Assenza,AttivitaProgetto
where Persona.id = Assenza.persona and Persona.id = AttivitaProgetto.Persona
and Assenza.giorno = AttivitaProgetto.giorno;

--11
select Persona.nome,Persona.cognome,Assenza.giorno,Assenza.tipo,Progetto.nome,AttivitaProgetto.oreDurata
from Persona,Assenza,AttivitaProgetto,Progetto,WP
where Persona.id = Assenza.persona and Persona.id = AttivitaProgetto.Persona
and Assenza.giorno = AttivitaProgetto.giorno
and AttivitaProgetto.progetto = WP.progetto and AttivitaProgetto.wp = WP.id
and WP.progetto = Progetto.id;

--12
select distinct wp1.nome
from WP wp1
join WP wp2 on wp1.nome = wp2.nome and wp1.progetto <> wp2.progetto;