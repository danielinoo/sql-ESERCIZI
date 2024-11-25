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
    SELECT ap.partenza as partenza , ap.arrivo as arrivo, count(ap.codice) as num_volo
    FROM Aeroporto a, Aeroporto b, ArrPart ap
    WHERE ap.partenza = a.codice and ap.arrivo = b.codice
    GROUP by ap.partenza, ap.arrivo
),
BA as(
    SELECT ap.partenza as partenza , ap.arrivo as arrivo, count(ap.codice) as num_volo
    FROM Aeroporto a, Aeroporto b, ArrPart ap
    WHERE ap.partenza = b.codice and ap.arrivo = a.codice
    GROUP by ap.partenza, ap.arrivo

)

SELECT DISTINCT ap.partenza, ap.arrivo
FROM BA, AB, ArrPart ap
WHERE ap.partenza = AB.partenza and ap.arrivo = AB.arrivo
and ap.partenza = BA.partenza and ap.arrivo = BA.arrivo
AND BA.num_volo = AB.num_volo
GROUP BY ap.partenza, ap.arrivo,AB.num_volo, BA.num_volo





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


--6--OK
--citta con 1 solo aeroporto
WITH num_aeroporti as 
(
select DISTINCT citta , count(la.aeroporto) as n
from LuogoAeroporto la
group by citta    
having count(la.aeroporto) = 1
)
SELECT DISTINCT ap.codice,ap.comp,ap.partenza, ap.arrivo
FROM num_aeroporti, Aeroporto a, LuogoAeroporto la, ArrPart ap
where num_aeroporti.citta = la.citta
and la.aeroporto = a.codice
and ap.partenza = a.codice


--7--query voli diretti e indiretti okk
select distinct ap.arrivo
from ArrPart d, ArrPart ap, Volo v
where d.partenza ='JFK' AND d.arrivo = ap.partenza

union

select distinct ap.arrivo
from ArrPart ap
where ap.partenza = 'JFK'


--8
select distinct la1.citta
from ArrPart d, ArrPart ap, LuogoAeroporto la, Aeroporto a, LuogoAeroporto la1
where la.aeroporto = a.codice and la.citta = 'Roma'
 and d.partenza =a.codice AND d.arrivo = ap.partenza 
 and la1.aeroporto = ap.arrivo --controllo citta d arrivo

union

select distinct la1.citta
from ArrPart ap, LuogoAeroporto la, Aeroporto a, LuogoAeroporto la1
where la.aeroporto = a.codice and la.citta = 'Roma' and ap.partenza = a.codice 
and la1.aeroporto = ap.arrivo  --controllo citta d arrivo


--9--citta da JFK con 1 scalo
SELECT DISTINCT la.citta
FROM Aeroporto a1
JOIN ArrPart partenza ON a1.codice = partenza.partenza
JOIN ArrPart scalo ON partenza.arrivo=  scalo.partenza
JOIN Aeroporto arrivo_finale ON  scalo.arrivo = arrivo_finale.codice
JOIN LuogoAeroporto la ON arrivo_finale.codice = la.aeroporto
WHERE a1.codice = 'JFK';

