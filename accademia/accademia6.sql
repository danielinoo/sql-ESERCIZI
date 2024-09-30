--1

select Persona.posizione,count(*) as numero
from Persona
group by Persona.posizione;

--2
select count(*) as numero
from Persona
where stipendio >= 40000;

--3
select count(*) as progetto_finito
from Progetto
where budget > 50000 and fine <= CURRENT_DATE;


--4
select avg(oreDurata) as media_ore,
        max(oreDurata) as massimo_ore,
        min(oreDurata) as minimo_ore
from AttivitaProgetto as a1, WP, Progetto as pr
where a1.progetto = WP.progetto and a1.wp = WP.id
    and wp.progetto = pr.id
    and pr.nome = 'Pegasus';

--5

select pp.id,pp.nome,pp.cognome,
        avg(oreDurata) as media_ore,
        max(oreDurata) as massimo_ore,
        min(oreDurata) as minimo_ore
from AttivitaProgetto as a1, WP, Progetto as pr,persona as pp
where a1.progetto = WP.progetto and a1.wp = WP.id
    and wp.progetto = pr.id
    and pr.nome = 'Pegasus'
    and a1.persona = pp.id
group by pp.id,pp.nome,pp.cognome;



--6

select pp.id,pp.nome,pp.cognome, sum(oreDurata) as Ore_didattica
from AttivitaNonProgettuale as anp, Persona pp
where anp.tipo = 'Didattica'
    and anp.persona = pp.id
group by pp.id,pp.nome,pp.cognome;


--7

select 
    avg(stipendio) as media_stipendio,
    max(stipendio) as stipendio_massimo,
    min(stipendio) as stipendio_minimo
from Persona
where Persona.posizione = 'Ricercatore'


--8

select posizione,
    avg(stipendio) as media_stipendio,
    max(stipendio) as stipendio_massimo,
    min(stipendio) as stipendio_minimo
from Persona
group by posizione

--9

select pr.id,pr.nome, sum(oreDurata) as ore_totali
from AttivitaProgetto as ap, WP, Progetto as pr,persona as pp
where ap.progetto = WP.progetto and ap.wp = WP.id
    and wp.progetto = pr.id
    and ap.persona = pp.id
    and pp.nome = 'Ginevra' and pp.cognome = 'Riva'
group by pr.id ,pr.nome


--10
select pr.id,pr.nome
from AttivitaProgetto as ap, WP, Progetto as pr,persona as pp
where ap.progetto = WP.progetto and ap.wp = WP.id
    and wp.progetto = pr.id
    and ap.persona = pp.id
group by pr.id,pr.nome
having count(pp.id) > 2

--11
select pp.id,pp.nome,pp.cognome
from AttivitaProgetto as ap, WP, Progetto as pr,persona as pp
where ap.progetto = WP.progetto and ap.wp = WP.id
    and wp.progetto = pr.id
    and ap.persona = pp.id
    and ap.persona <> 
