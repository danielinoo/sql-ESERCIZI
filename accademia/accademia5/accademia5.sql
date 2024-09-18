--1

select WP.nome , WP.inizio, WP.fine
from WP,Progetto
where WP.progetto = Progetto.id
and Progetto.nome = 'Pegasus';

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
from Persona pp,Progetto,WP,AttivitaProgetto a1,AttivitaProgetto a2
where pp.id = a1.persona
and a1.progetto = WP.progetto and a1.wp = WP.id
and a1.progetto  = Progetto.id
and Progetto.nome = 'Pegasus'
and a1.id <> a2.id
and a1.persona= a2.persona;


--4
select distinct Persona.nome , Persona.cognome , Persona.posizione
from Persona,Assenza
where posizione = 'Professore Ordinario' 
and Assenza.persona = Persona.id
and Assenza.tipo = 'Malattia';

--5
select distinct pp.nome ,pp.cognome
from Persona pp,Assenza a1, Assenza, Persona
where pp.id = a1.id and a1.tipo = 'Malattia'
and pp.posizione = 'Professore Ordinario'
and pp.id <> Persona.id
and a1.giorno <> Assenza.giorno;

--6
select distinct pp.nome , pp.cognome,pp.posizione
from Persona,AttivitaNonProgettuale
join Persona pp on pp.id = AttivitaNonProgettuale.persona and AttivitaNonProgettuale.tipo = 'Didattica'
where pp.posizione = 'Ricercatore';

--7
select distinct pp.nome , pp.cognome,pp.posizione
from Persona pp,AttivitaNonProgettuale, Persona, AttivitaNonProgettuale a1
where pp.id = a1.persona 
and a1.tipo = 'Didattica'
and pp.posizione = 'Ricercatore'
and a1.id <> AttivitaNonProgettuale.id
and a1.persona = AttivitaNonProgettuale.persona;

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