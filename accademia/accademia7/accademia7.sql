--1--ok
SELECT posizione, AVG(stipendio) AS media_stipendio, STDDEV(stipendio) AS deviazione_standard_stipendio
FROM Persona
GROUP BY posizione;

--2--ok
SELECT p.*
FROM Persona p,
(
    SELECT  AVG(stipendio) AS media_stipendio
    FROM Persona
    WHERE Persona.posizione = 'Ricercatore'
)pp
WHERE  p.posizione = 'Ricercatore'
and p.stipendio > pp.media_stipendio;


--3
WITH pa as (
    SELECT posizione, AVG(stipendio) AS media_stipendio, STDDEV(stipendio) AS deviazione_standard_stipendio
    FROM Persona
    GROUP BY posizione
)
SELECT p.posizione as posizione,count(p.id) as numero
FROM Persona p
JOIN pa ON p.posizione = pa.posizione
WHERE p.stipendio <= (pa.media_stipendio + pa.deviazione_standard_stipendio)
    and p.stipendio >= (pa.media_stipendio - pa.deviazione_standard_stipendio)
GROUP BY p.posizione
--4--ok
SELECT p.id,p.nome,p.cognome,p.posizione,p.stipendio , SUM(ap.oreDurata) as ore_lavoro
FROM AttivitaProgetto ap
JOIN Persona p ON p.id = ap.persona
GROUP BY p.id,p.nome,p.cognome,p.posizione,p.stipendio 
HAVING SUM(ap.oreDurata) >= 20;

--5--ok
WITH qq as (
    SELECT avg(p.fine - p.inizio) as durata_media
    FROM Progetto p
)
SELECT p.nome, (p.fine - p.inizio) as numero
FROM Progetto p , qq
WHERE 
    (p.fine - p.inizio) > qq.durata_media

--6--ok
SELECT p.nome, SUM(ap.oreDurata) AS ore_tot
FROM Progetto p
JOIN AttivitaProgetto ap ON P.id = ap.progetto
WHERE p.fine < CURRENT_DATE 
AND ap.tipo = 'Dimostrazione'
GROUP BY p.nome;

--7--ok
WITH a_pa as(
    SELECT p.id,p.nome,count(*) as numero_assenze
    FROM Assenza a, Persona p
    WHERE a.tipo = 'Malattia'
        AND  a.persona = p.id
        AND p.posizione = 'Professore Associato'
    GROUP BY p.id,p.nome,p.cognome
),
a_po as(
    SELECT p.id as id,p.nome as nome, p.cognome as cognome ,count(*) as numero_assenze
    FROM Assenza a, Persona p
    WHERE a.tipo = 'Malattia'
        AND  a.persona = p.id
        AND p.posizione = 'Professore Ordinario'
    GROUP BY p.id,p.nome,p.cognome
),

n_media_a as (
    SELECT avg(numero_assenze) as num_media_ga
    FROM a_pa

)

SELECT a_po.id,a_po.nome ,a_po.cognome
FROM a_po, n_media_a
WHERE a_po.numero_assenze > n_media_a.num_media_ga