--1--rivedere
SELECT Aeroporto.codice ,Aeroporto.nome,COUNT(DISTINCT Compagnia.nome) AS num_compagnie
FROM (
    SELECT Aeroporto.codice, c.nome
    FROM Aeroporto
    JOIN ArrPart ON ArrPart.partenza = Aeroporto.codice
    JOIN Volo v ON v.codice = ArrPart.codice AND v.comp = ArrPart.comp
    JOIN Compagnia c ON v.comp = c.nome

    UNION


    SELECT Aeroporto.codice, c.nome
    FROM Aeroporto
    JOIN ArrPart ON ArrPart.arrivo = Aeroporto.codice
    JOIN Volo v ON v.codice = ArrPart.codice AND v.comp = ArrPart.comp
    JOIN Compagnia c ON v.comp = c.nome
) AS compagnie_volo
GROUP BY Aeroporto.codice;


--2--rivedere
SELECT COUNT(v.codice) AS num_voli
FROM Volo v
JOIN ArrPart ap ON v.codice = ap.codice AND v.comp = ap.comp
JOIN Aeroporto a ON (ap.arrivo = a.codice OR ap.partenza = a.codice)
WHERE a.nome = 'HTR'
AND v.durataMinuti >= 100;

--3
SELECT l.nazione, COUNT(DISTINCT a.codice) AS num_aer
FROM ArrPart
JOIN Volo v ON v.codice = ArrPart.codice AND v.comp = ArrPart.comp AND v.comp = 'apitalia'
JOIN Aeroporto a ON (ArrPart.arrivo = a.codice OR ArrPart.partenza = a.codice)
JOIN LuogoAeroporto l ON a.codice = l.aeroporto
GROUP BY l.nazione

--4--rivedere
SELECT avg(v.durataMinuti) as media,max(v.durataMinuti) massima, min(v.durataMinuti) minima
FROM  Compagnia
JOIN Volo v ON v.comp = Compagnia.nome
WHERE Compagnia.nome = 'MagikFly'

--5--ok
SELECT DISTINCT a.nome, min(c.annoFondaz) as anno_fondazione
FROM ArrPart
JOIN Volo v ON v.codice = ArrPart.codice AND v.comp = ArrPart.comp 
JOIN Compagnia c ON v.comp = c.nome
JOIN Aeroporto a ON (ArrPart.arrivo = a.codice OR ArrPart.partenza = a.codice)
GROUP BY a.nome
--6

--7

--8--OK
SELECT c.nome, sum(v.durataMinuti) as durata_tot
FROM Compagnia,Aeroporto,Volo,ArrPart
JOIN Volo v ON v.codice = ArrPart.codice AND v.comp = ArrPart.comp 
JOIN Compagnia c ON v.comp = c.nome
JOIN Aeroporto a ON (ArrPart.arrivo = a.codice OR ArrPart.partenza = a.codice)
WHERE c.annoFondaz >= 1950
GROUP BY c.nome

--9--ok
SELECT a.codice,a.nome
FROM Compagnia,Aeroporto,Volo,ArrPart
JOIN Volo v ON v.codice = ArrPart.codice AND v.comp = ArrPart.comp 
JOIN Compagnia c ON v.comp = c.nome
JOIN Aeroporto a ON (ArrPart.arrivo = a.codice OR ArrPart.partenza = a.codice)
GROUP BY a.codice,a.nome
HAVING COUNT (DISTINCT v.comp) = 2

--10--ok
SELECT l.citta
FROM LuogoAeroporto l,Aeroporto a
WHERE a.codice = l.aeroporto
GROUP BY l.citta 
HAVING COUNT(a.codice) >= 2

--11--ok
SELECT c.nome
FROM Compagnia, Voli v
JOIN Compagnia c ON v.comp = c.nome
GROUP BY C.nome
HAVING avg(v.durataMinuti) >= 360

--12--ok
SELECT DISTINCT c.nome
FROM Compagnia, Voli v
JOIN  Compagnia c ON v.comp = c.nome
GROUP BY c.nome
HAVING MIN(v.durataMinuti) > 100


