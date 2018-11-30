-- Designación
select concat('{'
,' "idDesignacion" : ' , idDesignacion , ','
,' "idTipo" : ' , idTipo , ','
,' "oficial" : ' , num , ','
,' "fecha" : "' , Fecha  ,'",'
,' "sumarios" : [' , '--> INCRUSTAR_SUMARIOS <--'  ,']'
, '}')
from Designacion		
order by num,idDesignacion;

-- Sumario para Designación
select concat('{'
,' "idSumario" : ' , idSumario , ','
,' "descripcion" : "' , Descripcion , '",'
,' "resultado" : "' , Resultado  , '",'
,' "idEstado" : "' , EstadoSumario 
, '}')
, idDesignacion as ''
from Sumario
order by idDesignacion,idSumario;

-- Designación para Oficial
select concat('{'
,' "idDesignacion" : ' , idDesignacion , ','
,' "idTipo" : ' , idTipo , ','
,' "fecha" : "' , Fecha  ,'",'
,' "sumarios" : [' , '--> INCRUSTAR_SUMARIOS <--'  ,']'
, '}')
, num as ''
from Designacion		
order by num,idDesignacion;

-- Sumario
select concat('{'
,' "idSumario" : ' , idSumario , ','
,' "fecha" : "' , Fecha , '",'
,' "descripcion" : "' , Descripcion , '",'
,' "resultado" : "' , Resultado  , '",'
,' "idEstado" : "' , EstadoSumario  , ','
,' "oficial" : "' , OficialQueInvestiga 
, '}')
from Sumario
order by idSumario;

-- EstadoSumario
select concat('{"idEstado" : ',idEstado,', "descripcion" : "',Descripcion,'"}') from EstadoSumario;  -- En JSONSchema creo que sobra idSumario

-- TipoDesignacion
select concat('{"idTipo" : ',idTipo,', "nombre" : "',Nombre,'"}') from TipoDesignacion;  -- En JSONSchema creo que sobra idDesignacion

-- Oficial
select concat('{',' "num" : ' , num 
,', "nombre" : "' , Nombre , '"'
,', "apellido" : "' , Apellido , '"'
,', "fechaIngreso" : "' , FechaIngreso , '"'
,', "rango" : "' , Rango , '"'
,', "designaciones" : [' , ' --> INCRUSTAR_DESIGNACIONES <-- ',']'
, '}')
from Oficial order by num;		
-- En JSONSchema creo que sobran idSeguimiento e idRolInterviene

-- Seguimiento
select concat('{'
,' "idSeguimiento" : ' , idSeguimiento
,', "fecha" : "' , Fecha , '"'
,', "descripcion" : "' , Descripcion , '"'
,', "oficial" : "' , Oficial_num 
,', "idIncidente" : "' , idIncidente 
, '}')
from Seguimiento
order by idSeguimiento;

-- Incidente para Superheroe
select concat('{'
,' "idIncidente" : ' , i.idIncidente
,', "descripcion" : null'
,', "fecha" : "' , i.Fecha , '"'
, '}'), p.idSuperheroe as ''
from Incidente i, Participa p
where i.idIncidente = p.idIncidente
order by p.idSuperheroe, p.idIncidente;

-- Superheroe
select concat('{'
,' "idSuperheroe" : ' , idSuperheroe
,', "nombreFantasia" : "' , Nombre , '"'
,', "colorDisfraz" : "' , ColorDisfraz , '"'
,', "incidentes" : [' , ' --> INCRUSTAR_INCIDENTES <-- ',']'
, '}')
from Superheroe
order by idSuperheroe; 		-- Faltan las relaciones con Personas

select concat('{"id" : ' , idBarrio , ',',' "nombre" : "' , Nombre , '"}') from Barrio;
select concat('{"id" : ' , idCalle , ', "nombre" : "' , Nombre , '"}') from Calle; 

select concat('{'
,' "id" : ' , idDireccion
,', "calle" : ' , calle 
,', "altura" : ' , Altura 
,', "barrio" : ' , Barrio_idBarrio 
,', "calleAledaña1" : ' , calleAledaña1 
,', "calleAledaña2" : ' , calleAledaña2 
, '}')
from Direccion order by idDireccion;	

-- Persona
select concat('{'
,' "dni" : ' , idPersona
,', "idDireccion" : ' , Direccion_idDireccion 
,', "idOrg" : ' , COALESCE(idOrganizacionDelictiva,'') 
,', "incidentes" : [' , ' --> INCRUSTAR_ROLES_INVOLUCRADOS <-- ',']'
, '}')
from Persona order by idPersona;  -- Faltan relaciones con Superhéroe

-- RolInvolucrado
select concat('{'
,' "idIncidente" : ' , i.idIncidente
,', "fecha" : "' , i.Fecha , '"'
,', "descripcion" : ', COALESCE(i.descripcion,'null')
,', "rol" : "' , p.Rol 
,' "persona" : ' , p.idPersona
, '}')
from Incidente i, Involucra p
where i.idIncidente = p.idIncidente
order by p.idPersona, p.idIncidente;

-- Persona para OrgDelictiva
select concat('{'
,' "dni" : ' , idPersona
,', "idDireccion" : ' , Direccion_idDireccion 
,', "idOrg" : ' , COALESCE(idOrganizacionDelictiva,'') 
,', "incidentes" : [' , ' --> INCRUSTAR_ROLES_INVOLUCRADOS <-- ',']'
, '}')
from Persona order by idPersona;

-- OrgDelictiva
select concat('{'
,' "idOrg" : ' , idOrganizacionDelictiva
,', "nombre" : "' , Nombre , '"'
,', "personas" : [' , ' --> INCRUSTAR_PERSONAS <-- ',']'
, '}')
from OrganizacionDelictiva order by idOrganizacionDelictiva; 


-- Seguimiento para Incidente 
select concat('{'
,' "idSeguimiento" : ' , idSeguimiento
,', "fecha" : "' , Fecha , '"'
,', "descripcion" : "' , Descripcion , '"'
,', "oficial" : "' , Oficial_num 
,', "idIncidente" : "' , idIncidente 
, '}')
from Seguimiento
order by idIncidente,idSeguimiento;

-- RolInterviene
select concat('{'
,' "idIncidente" : ' ,idIncidente
,', "num" : ' , num
,', "rol" : "' , Rol , '"'
, '}')
from Interviene 
order by idIncidente,num;


-- Incidente
select concat('{'
,' "idIncidente" : ' , idIncidente
,', "fecha" : "' , Fecha , '"'
,', "descripcion" : ', COALESCE(descripcion,'null')
,', "direccion" : ' , idDireccion
,', "personasInvolucradas" : [' , ' --> INCRUSTAR_ID_PERSONAS_INVOLUCRA <-- ',']'
,', "superheroesParticipan" : [' , ' --> INCRUSTAR_ID_SUPERHEROES_PARTICIPA <-- ',']'
,', "oficialInterviene" : [' , ' --> INCRUSTAR_ID_ROL_INTERVIENE <-- ',']'
,', "seguimientos" : [' , ' --> INCRUSTAR_SEGUIMIENTOS <-- ',']'
, '}')
from Incidente order by idIncidente;

-- ¡¡¡Faltan AsuntosInternos y Proceso!!!




-- Documentos con los que se resuelven las consultas del TP:
-- a) OrgDelictiva / Personas / Roles Involucrados (Incidentes)
-- b) Oficial / Designación / Sumarios
-- c) Superheroe / Incidentes   (¿ó Incidente / Superheroes?)
-- d) Incidente / Seguimiento


