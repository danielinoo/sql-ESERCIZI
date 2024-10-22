--1
select Volo.codice,Volo.comp
from Volo
where durataMinuti > 180;

--2
select Compagnia.nome
from Compagnia,Volo
where Compagnia.nome = Volo.comp
and Volo.durataMinuti > 180;

--3
select Volo.codice ,Volo.comp
from Compagnia, Volo, ArrPart, Aeroporto
where ArrPart.codice = Volo.codice and ArrPart.comp = Volo.comp
and ArrPart.partenza = Aeroporto.codice
and Aeroporto.codice = 'CIA';

--4
select Compagnia.nome
from Compagnia, Volo, ArrPart, Aeroporto
where Compagnia.nome = Volo.comp --confronto Compagnia-Volo
and ArrPart.codice = Volo.codice and ArrPart.comp = Volo.comp --confronto arrivi/partenze-Volo
and ArrPart.partenza = Aeroporto.codice --confronto arrivi/partenze-Aeroporto
and Aeroporto.codice = 'FCO';

--5 
select codice ,comp
from ArrPart
where ArrPart.partenza = 'FCO'
and ArrPart.arrivo = 'JFK';

--6
select Compagnia.nome
from Compagnia, Volo, ArrPart
where Compagnia.nome = Volo.comp
and ArrPart.codice = Volo.codice and ArrPart.comp = Volo.comp
and ArrPart.partenza =  'FCO'
and ArrPart.arrivo = 'JFK';

--7
select Compagnia.nome
from Compagnia,Volo,ArrPart,Aeroporto,LuogoAeroporto
where Compagnia.nome = Volo.comp
and ArrPart.codice = Volo.codice and ArrPart.comp = Volo.comp
and Aeroporto.codice = LuogoAeroporto.Aeroporto and LuogoAeroporto.citta = 'Roma'
and  Aeroporto.codice = LuogoAeroporto.Aeroporto and LuogoAeroporto.citta = 'New York';

--8
select Aeroporto.codice,Aeroporto.nome,LuogoAeroporto.citta
from ArrPart,Compagnia,Volo,Aeroporto,LuogoAeroporto
where Compagnia.nome = Volo.comp
and Compagnia.nome =  'MagicFly'
and ArrPart.codice = Volo.codice and ArrPart.comp = Volo.comp
and ArrPart.arrivo = Aeroporto.codice
and Aeroporto.codice = LuogoAeroporto.Aeroporto;



--9
select ArrPart .*
from ArrPart
join LuogoAeroporto arr on ArrPart.arrivo =arr.aeroporto
join LuogoAeroporto part on ArrPart.partenza = part.aeroporto
where arr.citta = 'Roma' and part.citta = 'New York';


--10
select ArrPart.comp, ArrPart.codice as volo1, ArrPart.partenza,primovolo.arrivo, ArrPart.codice as volo2,secondovolo.arrivo
from ArrPart
join ArrPart primovolo on ArrPart.partenza = primovolo.arrivo and primovolo.comp = ArrPart.partenza
join ArrPart secondovolo on secondovolo.partenza = ArrPart.arrivo and secondovolo.comp = ArrPart.arrivo
where ArrPart.partenza = 'Roma'
and ArrPart.arrivo = 'New York';

--11

select Compagnia.nome
from Compagnia,Volo,ArrPart,Aeroporto
where Compagnia.annoFondaz is not null
and Compagnia.nome = Volo.comp
and ArrPart.codice = Volo.codice and ArrPart.comp = Volo.comp
and ArrPart.partenza = Aeroporto.codice and Aeroporto.codice = 'FCO'
and ArrPart.arrivo = Aeroporto.codice and Aeroporto.codice ='JFK';