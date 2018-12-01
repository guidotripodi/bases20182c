use mydb;

DELIMITER //

drop procedure if exists generarConocidoParaSuperheroe; //
CREATE PROCEDURE generarConocidoParaSuperheroe(out v_personas varchar(10000), in v_superheroe integer)
BEGIN

declare v_finished INTEGER DEFAULT 0;
declare o_idPersona INT;

declare cursorSeguimiento cursor for 
select idPersona from Conocido 
where idSuperheroe = v_superheroe
order by idPersona;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_personas = "[";
OPEN cursorSeguimiento;
armarSeguimientos: LOOP
  FETCH cursorSeguimiento INTO o_idPersona;
  IF v_finished = 1 THEN LEAVE armarSeguimientos; END IF;
  SET v_personas = CONCAT(v_personas,o_idPersona,",");
END LOOP armarSeguimientos;
SET v_personas = CONCAT(v_personas,"]");
close cursorSeguimiento;
END;//




drop procedure if exists generarContactaParaSuperheroe; //
CREATE PROCEDURE generarContactaParaSuperheroe(out v_personas varchar(10000), in v_superheroe integer)
BEGIN

declare v_finished INTEGER DEFAULT 0;
declare o_idPersona INT;

declare cursorSeguimiento cursor for 
select idPersona from Contacta 
where idSuperheroe = v_superheroe
order by idPersona;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_personas = "[";
OPEN cursorSeguimiento;
armarSeguimientos: LOOP
  FETCH cursorSeguimiento INTO o_idPersona;
  IF v_finished = 1 THEN LEAVE armarSeguimientos; END IF;
  SET v_personas = CONCAT(v_personas,o_idPersona,",");
END LOOP armarSeguimientos;
SET v_personas = CONCAT(v_personas,"]");
close cursorSeguimiento;
END;//



drop procedure if exists generarArchienemigoParaSuperheroe; //
CREATE PROCEDURE generarArchienemigoParaSuperheroe(out v_personas varchar(10000), in v_superheroe integer)
BEGIN

declare v_finished INTEGER DEFAULT 0;
declare o_idPersona INT;

declare cursorSeguimiento cursor for 
select idPersona from Archienemigo 
where idSuperheroe = v_superheroe
order by idPersona;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_personas = "[";
OPEN cursorSeguimiento;
armarSeguimientos: LOOP
  FETCH cursorSeguimiento INTO o_idPersona;
  IF v_finished = 1 THEN LEAVE armarSeguimientos; END IF;
  SET v_personas = CONCAT(v_personas,o_idPersona,",");
END LOOP armarSeguimientos;
SET v_personas = CONCAT(v_personas,"]");
close cursorSeguimiento;
END;//


# IDs Habilidades de superhéroe

drop procedure if exists generarHabilidadesParaSuperheroe; //
CREATE PROCEDURE generarHabilidadesParaSuperheroe(out v_habilidades varchar(10000), in v_superheroe integer)
BEGIN

declare v_finished INTEGER DEFAULT 0;
declare o_idHabilidad INT;

declare cursorSeguimiento cursor for 
select idHabilidad from EsCapazDe 
where idSuperheroe = v_superheroe
order by idHabilidad;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_habilidades = "[";
OPEN cursorSeguimiento;
armarSeguimientos: LOOP
  FETCH cursorSeguimiento INTO o_idHabilidad;
  IF v_finished = 1 THEN LEAVE armarSeguimientos; END IF;
  SET v_habilidades = CONCAT(v_habilidades,o_idHabilidad,",");
END LOOP armarSeguimientos;
SET v_habilidades = CONCAT(v_habilidades,"]");
close cursorSeguimiento;
END;//

# INCIDENTE para SUPERHÉROE:

drop procedure if exists generarIncidenteParaSuperheroe; //
CREATE PROCEDURE generarIncidenteParaSuperheroe(out v_incidentes varchar(10000), in v_superheroe integer)
BEGIN

declare v_finished INTEGER DEFAULT 0;

declare j_incidente varchar(1000);
declare o_idIncidente INT;
declare o_Descripcion VARCHAR(45);
declare o_Fecha datetime;

declare cursorIncidente cursor for 
select i.idIncidente, i.Fecha, i.Descripcion 
from Participa p, Incidente i
where p.idIncidente = i.idIncidente
and p.idSuperheroe = v_superheroe
order by idIncidente;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_incidentes = "[";
OPEN cursorIncidente;
armarSeguimientos: LOOP
  FETCH cursorIncidente INTO o_idIncidente, o_Fecha,o_Descripcion;
  IF v_finished = 1 THEN LEAVE armarSeguimientos; END IF;
  set j_incidente = "{";
  set j_incidente = CONCAT(j_incidente,'"idIncidente": ',o_idIncidente,',');
  set j_incidente = CONCAT(j_incidente,'"descripcion": "',o_Descripcion,'",');
  set j_incidente = CONCAT(j_incidente,'"fecha": "',o_Fecha,'",');
  set j_incidente = CONCAT(j_incidente,"}");
  SET v_incidentes = CONCAT(v_incidentes,j_incidente,",");
END LOOP armarSeguimientos;
SET v_incidentes = CONCAT(v_incidentes,"]");
close cursorIncidente;
END;//


#SUPERHÉROE:

drop procedure if exists generarSuperheroes; //
CREATE PROCEDURE generarSuperheroes(out v_superheroes varchar(20000), in minNum int, in maxNum int)
BEGIN

declare v_finished INTEGER DEFAULT 0;

declare j_superheroe varchar(5000);

declare o_idSuperheroe INT;
declare o_nombreFantasia varchar(60);
declare o_colorDisfraz varchar(45);

declare cursorSuperheroes cursor for 
select idSuperheroe,nombre,colorDisfraz
from Superheroe
where idSuperheroe between minNum and maxNum
order by idSuperheroe;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_superheroes = "[";
OPEN cursorSuperheroes;
armarSuperheroes: LOOP
  FETCH cursorSuperheroes INTO o_idSuperheroe,o_nombreFantasia,o_colorDisfraz; 
  IF v_finished = 1 THEN LEAVE armarSuperheroes; END IF;  
  call generarIncidenteParaSuperheroe(@o_incidentes,o_idSuperheroe);
  call generarHabilidadesParaSuperheroe(@o_habilidades,o_idSuperheroe);
  call generarArchienemigoParaSuperheroe(@o_archienemigos,o_idSuperheroe);
  call generarContactaParaSuperheroe(@o_contacta,o_idSuperheroe);
  call generarConocidoParaSuperheroe(@o_conocido,o_idSuperheroe);

  set j_superheroe = "{";
  set j_superheroe = CONCAT(j_superheroe,'"idSuperheroe": ',o_idSuperheroe,',');
  set j_superheroe = CONCAT(j_superheroe,'"colorDisfraz": "',o_colorDisfraz,'",');
  set j_superheroe = CONCAT(j_superheroe,'"nombreFantasia": "',o_nombreFantasia,'",');
  set j_superheroe = CONCAT(j_superheroe,'"archienemigos": ',@o_archienemigos,',');
  set j_superheroe = CONCAT(j_superheroe,'"contacta": ',@o_contacta,',');
  set j_superheroe = CONCAT(j_superheroe,'"conocidos": ',@o_conocido,',');
  set j_superheroe = CONCAT(j_superheroe,'"habilidades": ',@o_habilidades,',');
  set j_superheroe = CONCAT(j_superheroe,'"incidentes": ',@o_incidentes,',');
  set j_superheroe = CONCAT(j_superheroe,"}");

  SET v_superheroes = CONCAT(v_superheroes,j_superheroe,",");
END LOOP armarSuperheroes;
SET v_superheroes = CONCAT(v_superheroes,"]");

close cursorSuperheroes;
END;//

call generarSuperheroes(@superheroes,0,9);//   
select @superheroes;//
call generarSuperheroes(@superheroes,10,19);//   
select @superheroes;//
call generarSuperheroes(@superheroes,20,29);//   
select @superheroes;//




