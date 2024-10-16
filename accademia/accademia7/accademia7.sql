--1 da rivedere
SELECT posizione, AVG(stipendio) AS media_stipendio, STDDEV(stipendio) AS deviazione_standard_stipendio
FROM Persona
GROUP BY posizione;

--2


SELECT p,*
FROM Persona p,
(
    SELECT  AVG(stipendio) AS media_stipendio
    FROM Persona
    WHERE Persona.posizione = 'Ricercatore'
)pp
WHERE  p.posizione = 'Ricercatore'
and p.stipendio > pp.media_stipendio;



--3

--4--rivedere
SELECT p , SUM(ap.oreDurata) as ore_lavoro
FROM Persona p,AttivitaProgetto 
JOIN AttivitaProgetto  ap ON p.id = ap.persona
GROUP BY p
HAVING SUM(ap.oreDurata) >= 20;

--5

--6
SELECT p.nome, SUM(ap.oreDurata) AS ore_tot
FROM Progetto p, AttivitaProgetto
JOIN AttivitaProgetto ap ON P.id = ap.progetto
WHERE p.fine < CURRENT_DATE 
AND ap.tipo = 'Dimostrazione'
GROUP BY p.nome;

--7

