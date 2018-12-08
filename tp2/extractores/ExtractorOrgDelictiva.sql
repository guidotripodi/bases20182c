use mydb;

DELIMITER //

# ROL INVOLUCRA PARA PERSONA PARA ORG. DELICTIVA:
drop procedure if exists generarRolInvolucradoParaPersonaParaOrgDelictiva; //
CREATE PROCEDURE generarRolInvolucradoParaPersonaParaOrgDelictiva(out v_rolInvolucra varchar(10000), in v_persona integer)
BEGIN

declare v_finished INTEGER DEFAULT 0;

declare j_rolInvolucra varchar(1000);

declare o_idIncidente INT;
declare o_Descripcion VARCHAR(45);
declare o_Fecha DATETIME;
declare o_Rol VARCHAR(45);

declare cursorRolInvolucra cursor for 
select i.idIncidente,p.Rol,i.Fecha,COALESCE(i.descripcion,'null')
from Incidente i, Involucra p
where i.idIncidente = p.idIncidente
  and p.idPersona = v_persona
  order by p.idIncidente; 
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_rolInvolucra = "[";
OPEN cursorRolInvolucra;
armarSumarios: LOOP
  FETCH cursorRolInvolucra INTO o_idIncidente,o_Rol,o_Fecha,o_Descripcion; 
  IF v_finished = 1 THEN LEAVE armarSumarios; END IF;
  set j_rolInvolucra = "{";
  set j_rolInvolucra = CONCAT(j_rolInvolucra,'"idIncidente": ',o_idIncidente,',');
  set j_rolInvolucra = CONCAT(j_rolInvolucra,'"fecha": "',o_Fecha,'",');
  set j_rolInvolucra = CONCAT(j_rolInvolucra,'"descripcion": "',o_Descripcion,'",');
  set j_rolInvolucra = CONCAT(j_rolInvolucra,'"rol": "',o_Rol,'",');
  set j_rolInvolucra = CONCAT(j_rolInvolucra,"}");
  set v_rolInvolucra = CONCAT(v_rolInvolucra,j_rolInvolucra,",");
END LOOP armarSumarios;
SET v_rolInvolucra = CONCAT(v_rolInvolucra,"]");
close cursorRolInvolucra;
END;//



# PERSONA PARA ORG. DELICTIVA:

drop procedure if exists generarPersonaParaOrgDelictiva; //
CREATE PROCEDURE generarPersonaParaOrgDelictiva(out v_personas varchar(10000), in v_orgDelictiva integer)
BEGIN

declare v_finished INTEGER DEFAULT 0;

declare j_persona varchar(1000);
declare o_idPersona INT;
declare o_idDireccion INT;
# Faltan los superhéroes

declare cursorPersona cursor for 
select idPersona, Direccion_idDireccion from Persona 
where idOrganizacionDelictiva = v_orgDelictiva
order by idPersona;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_personas = "[";
OPEN cursorPersona;
armarPersonas: LOOP
  FETCH cursorPersona INTO o_idPersona, o_idDireccion; 
  IF v_finished = 1 THEN LEAVE armarPersonas; END IF;
  call generarRolInvolucradoParaPersonaParaOrgDelictiva(@o_roles,o_idPersona);
  set j_persona = "{";
  set j_persona = CONCAT(j_persona,'"dni": ',o_idPersona,',');
  set j_persona = CONCAT(j_persona,'"idDireccion": "',o_idDireccion,'",');
  set j_persona = CONCAT(j_persona,'"rolInvolucrado": ',@o_roles);
  set j_persona = CONCAT(j_persona,"}");
  SET v_personas = CONCAT(v_personas,j_persona,",");
END LOOP armarPersonas;
SET v_personas = CONCAT(v_personas,"]");
close cursorPersona;
END;//

#ORG. DELICTIVA:

drop procedure if exists generarOrgDelictiva; //
CREATE PROCEDURE generarOrgDelictiva(out v_organizaciones varchar(10000), in minNum int, in maxNum int)
BEGIN

declare v_finished INTEGER DEFAULT 0;

declare j_OrgDelictiva varchar(5000);
declare o_idOrgDelictiva INT;
declare o_Nombre VARCHAR(45);

declare cursorOrgDelictiva cursor for 
select idOrganizacionDelictiva,Nombre 
from OrganizacionDelictiva
where idOrganizacionDelictiva between minNum and maxNum
order by idOrganizacionDelictiva;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_organizaciones = "[";
OPEN cursorOrgDelictiva;
cursorOrgDelictiva: LOOP
  FETCH cursorOrgDelictiva INTO o_idOrgDelictiva,o_Nombre; 
  IF v_finished = 1 THEN LEAVE cursorOrgDelictiva; END IF;  
  call generarPersonaParaOrgDelictiva(@o_personas,o_idOrgDelictiva);
  set j_OrgDelictiva = "{";
  set j_OrgDelictiva = CONCAT(j_OrgDelictiva,'"idOrganizacionDelictiva": ',o_idOrgDelictiva,',');
  set j_OrgDelictiva = CONCAT(j_OrgDelictiva,'"Nombre": "',o_Nombre,'",');
  set j_OrgDelictiva = CONCAT(j_OrgDelictiva,'"personas": ',@o_personas);
  set j_OrgDelictiva = CONCAT(j_OrgDelictiva,"}");

  SET v_organizaciones = CONCAT(v_organizaciones,j_OrgDelictiva,",");
END LOOP cursorOrgDelictiva;
SET v_organizaciones = CONCAT(v_organizaciones,"]");

close cursorOrgDelictiva;
END;//

call generarOrgDelictiva(@organizaciones,0,9);//   
select @organizaciones;//
call generarOrgDelictiva(@organizaciones,10,19);//   
select @organizaciones;//
call generarOrgDelictiva(@organizaciones,20,29);//   
select @organizaciones;//
call generarOrgDelictiva(@organizaciones,30,35);//   
select @organizaciones;//

#call generarDesignacionesParaOficiales(@designaciones,3);//
#select @designaciones;//
