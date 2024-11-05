--1--ok
WITH durata_compagnia as (
    SELECT v.comp as nome, avg(v.durataMinuti) as media
    FROM  Volo v
    GROUP BY v.comp
)
SELECT v.codice ,v.comp as nome, v.durataMinuti
FROM Volo v, durata_compagnia dc
WHERE v.durataMinuti > dc.media and v.comp = dc.nome
GROUP BY v.codice, v.comp



--2--OK

WITH na as(
    SELECT la.citta as citta
    FROM LuogoAeroporto la
    GROUP BY la.citta
    having count(la.aeroporto) > 1
)

SELECT  DISTINCT na.citta
FROM  ArrPart ap, na, Aeroporto a, LuogoAeroporto la
    WHERE ap.comp = 'Apitalia' 
        and a.codice = la.aeroporto and la.citta = na.citta
        and (ap.arrivo = a.codice or ap.partenza = a.codice)


--3--RIVEDERE

WITH AB as (
    SELECT count(ap.codice) as num_volo
    FROM Aeroporto a, Aeroporto b, ArrPart ap
    WHERE ap.partenza = a.codice and ap.arrivo = b.codice

),
BA as(
    SELECT count(ap.codice) as num_volo
    FROM Aeroporto a, Aeroporto b, ArrPart ap
    WHERE ap.partenza = b.codice and ap.arrivo = a.codice

)

SELECT DISTINCT ap.partenza, ap.arrivo
FROM BA, AB, ArrPart ap
WHERE BA.num_volo = AB.num_volo
GROUP BY ap.partenza , ap.arrivo


--4--ok
WITH durata_compagnia as (
    SELECT v.comp as nome, avg(v.durataMinuti) as media
    FROM  Volo v
    GROUP BY v.comp
)
SELECT DISTINCT v.comp
FROM Volo v, durata_compagnia dc

GROUP BY v.comp,dc.media
HAVING AVG(v.durataMinuti) > dc.media

--5--rivedere
SELECT a.codice
from Volo v
JOIN ArrPart ap ON  ap.codice = v.codice and ap.comp = v.comp
JOIN Aeroporto a ON ap.partenza = a.codice 
JOIN LuogoAeroporto la on a.codice = la.aeroporto
GROUP BY a.codice
HAving count(la.aeroporto) >= 2

--6--rivedere
WITH la1 as 
(
    SELECT la.citta as citta , a.codice as codice 
    FROM LuogoAeroporto la , Aeroporto a
    where la.aeroporto = a.codice and la.citta <> la.citta
)
