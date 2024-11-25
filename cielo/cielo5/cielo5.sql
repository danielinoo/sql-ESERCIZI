--1
select ap.arrivo
from ArrPart ap1, ArrPart ap, Aeroporto a
where ap1.partenza = 'JFK'
and ap1.arrivo = ap.partenza 

union 

select ap.arrivo
from ArrPart ap
where ap.partenza = 'JFK'

--2
select la.citta
from ArrPart ap1, ArrPart ap, Aeroporto a,LuogoAeroporto la
where ap1.partenza = 'JFK'
and ap1.arrivo = ap.partenza 
and la.aeroporto = ap.arrivo

union 

select la.citta
from ArrPart ap, LuogoAeroporto la
where ap.partenza = 'JFK'
and la.aeroporto = ap.arrivo

--3
select ap.partenza
from ArrPart ap1, ArrPart ap, Aeroporto a
where ap1.partenza = 'FCO'
and ap1.arrivo = ap.partenza 
and ap.arrivo = 'JFK'
