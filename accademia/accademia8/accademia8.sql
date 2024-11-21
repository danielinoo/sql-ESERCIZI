-- --1--con union
-- SELECT *
-- FROM (
--     SELECT p.id pid, p.nome,p.cognome
--     FROM Persona p, Assenza a
--     WHERE true
--     EXCEPT

--     (
--     SELECT distinct  p.id,p.nome,p.cognome
--     FROM Assenza a, AttivitaProgetto ap,Persona p
--     WHERE a.persona = ap.persona
--     and a.giorno = ap.giorno
--     AND p.id = a.persona

--     Union

--     SELECT distinct  p.id,p.nome,p.cognome
--     FROM Assenza a,AttivitaNonProgettuale anp,Persona p
--     WHERE a.persona = anp.persona
--     AND a.giorno = anp.giorno
--     AND p.id = a.persona
--     )
-- )
-- order by pid



    SELECT p.id, p.nome,p.cognome
    FROM Persona p, Assenza a
    WHERE true

    EXCEPT

    (
    SELECT distinct  p.id,p.nome,p.cognome
    FROM Assenza a, AttivitaProgetto ap,Persona p
    WHERE a.persona = ap.persona
    and a.giorno = ap.giorno
    AND p.id = a.persona

    Union

    SELECT distinct  p.id,p.nome,p.cognome
    FROM Assenza a,AttivitaNonProgettuale anp,Persona p
    WHERE a.persona = anp.persona
    AND a.giorno = anp.giorno
    AND p.id = a.persona
    )
    order by id

----------------------------------------------------------------------
--2
-- con query dentro il where
WITH dp AS (
    SELECT p.inizio AS inizio, p.fine AS fine
    FROM Progetto p
    WHERE p.nome = 'Pegasus'
)
SELECT p.id, p.nome, p.cognome
FROM Persona p
LEFT JOIN AttivitaProgetto ap ON ap.persona = p.id 
   AND (ap.giorno >= (SELECT inizio FROM dp) AND ap.giorno <= (SELECT fine FROM dp))
LEFT JOIN AttivitaNonProgettuale anp ON anp.persona = p.id 
   AND (anp.giorno >= (SELECT inizio FROM dp) AND anp.giorno <= (SELECT fine FROM dp))
WHERE ap.id IS NULL OR anp.id IS NULL
ORDER BY p.id asc



-- --con except senza left join
-- WITH dp AS (
--     SELECT p.inizio AS inizio, p.fine AS fine
--     FROM Progetto p
--     WHERE p.nome = 'Pegasus'
-- ),

-- --persone che non c hanno attivita nella durata di pegasus
-- per as (
-- --seleziono tutte le persone
-- select p.id as id
-- from persona p
-- EXCEPT

-- --seleziono le persone senza attivita
-- select distinct ap.persona
-- from AttivitaProgetto ap, Progetto pr,dp
-- where pr.nome = 'Pegasus'
-- and ap.giorno BETWEEN pr.inizio AND pr.fine
-- )

-- SELECT p.id,p.nome,p.cognome
-- from Persona p,per
-- where p.id = per.id
-- order by p.id asc
------------------------------------------------------------

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

--4--ok
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

--5


with pro as (
    select prog.id as id, prog.budget as budget ,sum(ap.oreDurata) as num_ore
    from Progetto prog, AttivitaProgetto ap
    where ap.progetto = prog.id
    group by prog.id, prog.budget
),
progs as (
    SELECT avg(s.budget) as media_budget, avg(s.num_ore) as ore_media
    from pro s
)
SELECT p.*
FROM Progetto p, pro s, progs ps
where p.budget < ps.media_budget
and s.id = p.id
and ps.num_ore > s.num_ore

