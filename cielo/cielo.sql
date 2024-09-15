--1
select volo.id ,volo.comp
from volo
where durataMinuti > 3

--2
select compagnia.nome
from compagnia,volo
where compagnia.id = volo.comp
and volo.durataMinuti > 3

--3
select volo.id ,volo.comp
from compagnia, volo, ArrPart, aereoporto
where ArrPart.codice = volo.codice and ArrPart.comp = volo.comp
and ArrPart.partenza = aereoporto.codice
and aereoporto.codice = 'CIE'

--4
select compagnia.nome
from compagnia, volo, ArrPart, aereoporto
where compagnia.nome = volo.comp --confronto compagnia-volo
and ArrPart.codice = volo.codice and ArrPart.comp = volo.comp --confronto arrivi/partenze-volo
and ArrPart.partenza = aereoporto.codice --confronto arrivi/partenze-aereoporto
and aereoporto.codice = 'FCO'

--5
select volo.id ,volo.comp
from compagnia, volo, ArrPart, 
     ,(select aereoporto.codice
                 from  aereoporto
                 where aereoporto.codice = 'FCO' ) partenza_fco,
     (select aereoporto.codice
                 from  aereoporto
                 where aereoporto.codice = 'FCO' ) arrivo_jfk
where ArrPart.codice = volo.codice and ArrPart.comp = volo.comp
and ArrPart.partenza = partenza_fco
and ArrPart.arrivo = arrivo_jfk

--6
select compagnia.nome
from compagnia, volo, ArrPart, 
     ,(select aereoporto.codice
                 from  aereoporto
                 where aereoporto.codice = 'FCO' ) partenza_fco,
     (select aereoporto.codice
                 from  aereoporto
                 where aereoporto.codice = 'FCO' ) arrivo_jfk
where compagnia.nome = volo.comp
and ArrPart.codice = volo.codice and ArrPart.comp = volo.comp
and ArrPart.partenza = partenza_fco
and ArrPart.arrivo = arrivo_jfk

--7
select compagnia.nome
from compagnia,volo,ArrPart,aereoporto,luogoAereoporto
where compagnia.nome = volo.comp
and ArrPart.codice = volo.codice and ArrPart.comp = volo.comp
and aereoporto.codice = luogoAereoporto.aereoporto and luogoAereoporto.citta = 'Roma'
and  aereoporto.codice = luogoAereoporto.aereoporto and luogoAereoporto.citta = 'New York'

--8

--9
select compagnia.nome
from compagnia,volo,ArrPart,aereoporto,luogoAereoporto
where compagnia.nome = volo.comp
and ArrPart.codice = volo.codice and ArrPart.comp = volo.comp
and aereoporto.codice = luogoAereoporto.aereoporto and luogoAereoporto.citta = 'Roma'
and  aereoporto.codice = luogoAereoporto.aereoporto and luogoAereoporto.citta = 'New York'