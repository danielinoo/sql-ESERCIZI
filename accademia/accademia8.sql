--1--con union
SELECT p.id
FROM Persona p
WHERE

EXCEPT

(
SELECT distinct a.persona
FROM Assenza a, AttivitaProgetto ap
WHERE a.persona = ap.persona
and a.giorno = ap.giorno

Union

SELECT distinct a.persona
FROM Assenza a,,AttivitaNonProgettuale anp
WHERE a.persona = anp.persona
AND a.giorno = anp.giorno
)





--2--rivedere perche ci sta anna bianchi
--durata progetto pegasus
WITH durata_progetto AS (
    SELECT id,inizio, fine
    FROM Progetto
    WHERE nome = 'Pegasus'
)

SELECT p.id, p.nome, p.cognome
FROM Persona p
LEFT JOIN AttivitaProgetto ap ON p.id = ap.persona
LEFT JOIN WP wp ON ap.wp = wp.id
LEFT JOIN durata_progetto dp ON wp.progetto = dp.id
WHERE (dp.inizio IS NULL AND dp.fine IS NULL)  -- Nessun progetto trovato
   OR (ap.giorno < dp.inizio OR ap.giorno > dp.fine)  -- Attività Progetto fuori dall'intervallo
GROUP BY p.id, p.nome, p.cognome
order by p.id asc


--3--okk

--stipendio massimo dei professori
WITH sm AS(
    SELECT MAX(stipendio) as max_stipendio
    from persona
    WHERE posizione = 'Professore Associato' or posizione = 'Professore Ordinario'
)
SELECT distinct p.id, p.nome, p.cognome, p.stipendio
FROM Persona p, sm
WHERE p.stipendio > sm.max_stipendio
and p.posizione = 'Ricercatore'
order by p.id asc

--4
with media_budget as (
    select avg(budget) as media
    from Progetto
)
SELECT p.id,p.nome, p.cognome
FROM Persona p, Progetto pr, AttivitaProgetto ap, WP wp, media_budget
Where wp.progetto = pr.id
    and ap.progetto = wp.progetto and ap.wp = wp.id
    and ap.persona = p.id
    and pr.budget > media_budget.media
GROUP BY p.id,p.nome, p.cognome
order by p.id asc

