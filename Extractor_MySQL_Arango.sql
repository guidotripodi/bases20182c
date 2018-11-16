select concat('{'
,' "unidad" : ' , unidad , ','
,' "calle" : "' , calle , '",'
, '}')
from z80unidad;

-- No se incluye Departamento, pero parece que no hace falta

select concat('{'
,' "id" : ' , num , ','
,' "nombre" : "' , Nombre , '",'
,' "apellido" : "' , Apellido , '",'
,' "fechaIngreso" : "' , FechaIngreso , '",'
,' "rango" : "' , Rango , '",'
, '}')
from Oficial;		-- Faltaría Departamento

-- Ver qué hacer con AsuntosInternos

select concat('{',' "id" : ' , idBarrio , ',',' "nombre" : "' , Nombre , '",', '}') from Barrio;

select concat('{'
,' "id" : ' , num , ','
,' "nombre" : "' , Nombre , '",'
, '}')
from Calle;

select concat('{'
,' "id" : ' , idDireccion , ','
-- ,' "calle" : "' , calle , '",'
,' "altura" : ' , Altura , ','
-- ,' "barrio" : ' , Barrio_idBarrio , ','
-- ,' "calleAledaña1" : ' , calleAledaña1 , ','
-- ,' "calleAledaña2" : ' , calleAledaña2 , ','
, '}')
from Direccion;			-- Faltarían las referencias a calles y barrio

select concat('{'
,' "id" : ' , idOrganizacionDelictiva , ','
,' "nombre" : "' , Nombre , '",'
, '}')
from OrganizacionDelictiva;

-- Ver qué hacer con TipoDesignación

select concat('{'
,' "id" : ' , idDesignacion , ','
,' "fecha" : "' , Fecha , '",'
, '}')
from Designacion;		-- Faltan TipoDesignación y OficialDesignado


select concat('{'
,' "id" : ' , isSuperheroe , ','
,' "nombre" : "' , Nombre , '",'
,' "colorDisfraz" : "' , ColorDisfraz , '",'
, '}')
from Superheroe;		-- Faltan TipoDesignación y OficialDesignado

select concat('{'
,' "id" : ' , idPersona , ','
,' "nombre" : "' , Nombre , '",'
,' "apellido" : "' , Apellido , '",'
, '}')
from Persona;			-- Faltan Dirección y OrganizaciónDelictiva

select concat('{'
,' "id" : ' , isIncidente , ','
,' "número" : ' , Numero , ','
,' "apellido" : "' , Descripcion , '",'
,' "fecha" : "' , Fecha , '",'
, '}')
from Incidente;			-- Faltan Dirección 

select concat('{'
,' "oficial" : ' , num , ','
,' "incidente" : "' , idIncidente , '",'
,' "rol" : "' , Rol , '",'
, '}')
from Interviene;			-- Faltan Dirección 

-- No se incluye Archienemigo, pero parece que no hace falta

select concat('{'
,' "superhéroe" : ' , idSuperheroe , ','
,' "persona" : "' , idPersona , '",'
, '}')
from Contacta;			-- Faltan Dirección 

-- No se incluye Conocido, pero parece que no hace falta
-- No se incluye SeRelacionaCon, pero parece que no hace falta
-- No se incluye Participa, pero parece que no hace falta


select concat('{'
,' "incidente" : ' , idIncidente , ','
,' "persona" : "' , idPersona , '",'
,' "rol" : "' , Rol , '",'
, '}')
from Involucra;			-- Faltan Fecha y Descripción de Incidente. El documento es RolInvolucrado.

select concat('{'
,' "incidente" : ' , idIncidente , ','
, '}')
from Proceso;			-- Le Faltan los Seguimientos Anidados


-- No se incluye Habilidad, pero parece que no hace falta
-- No se incluye EsCapazDe, pero parece que no hace falta

-- Ver qué hacer con EstadoSumario

select concat('{'
,' "id" : ' , idSumario , ','
,' "fecha" : "' , Fecha , '",'
,' "apellido" : "' , Descripcion , '",'
,' "resultado" : "' , Resultado , '",'
, '}')
from Sumario;	-- Falta OficialQueInvestiga, EstadoSumario e idDesignacion
