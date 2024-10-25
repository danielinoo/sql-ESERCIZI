--1--rivedre
SELECT p.id,p.nome,p.cognome
FROM Persona p
JOIN AttivitaProgetto ap ON ap.persona = p.id
JOIN AttivitaNonProgettuale anp ON anp.persona = p.id
JOIN Assenza a ON a.persona = p.id
where ap.giono <> a.giorno and anp.giorno <> a.giorno
GROUP BY p.id,p.nome,p.cognome

--2--rivedere perche ce sta anna bianchi
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
