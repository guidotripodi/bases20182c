use mydb;

DELIMITER //

# IDs Superhéroes que participan en un incidente

drop procedure if exists generarParticipaParaIncidente; //
CREATE PROCEDURE generarParticipaParaIncidente(out v_seguimientos varchar(10000), in v_incidente integer)
BEGIN

declare v_finished INTEGER DEFAULT 0;
declare o_idSuperheroe INT;

declare cursorSeguimiento cursor for 
select idSuperheroe from Participa 
where idIncidente = v_incidente
order by idSuperheroe;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_seguimientos = "[";
OPEN cursorSeguimiento;
armarSeguimientos: LOOP
  FETCH cursorSeguimiento INTO o_idSuperheroe;
  IF v_finished = 1 THEN LEAVE armarSeguimientos; END IF;
  SET v_seguimientos = CONCAT(v_seguimientos,o_idSuperheroe,",");
END LOOP armarSeguimientos;
SET v_seguimientos = CONCAT(v_seguimientos,"]");
close cursorSeguimiento;
END;//




# SEGUIMIENTO PARA INCIDENTE:

drop procedure if exists generarSeguimientoParaIncidente; //
CREATE PROCEDURE generarSeguimientoParaIncidente(out v_seguimientos varchar(10000), in v_incidente integer)
BEGIN

declare v_finished INTEGER DEFAULT 0;

declare j_seguimiento varchar(1000);
declare o_idSeguimiento INT;
declare o_Fecha TIMESTAMP;
declare o_Descripcion VARCHAR(45);
declare o_num INT;

declare cursorSeguimiento cursor for 
select idSeguimiento, Fecha, Descripcion, Oficial_num from Seguimiento 
where idIncidente = v_incidente
order by idSeguimiento;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_seguimientos = "[";
OPEN cursorSeguimiento;
armarSeguimientos: LOOP
  FETCH cursorSeguimiento INTO o_idSeguimiento, o_Fecha,o_Descripcion,o_num;
  IF v_finished = 1 THEN LEAVE armarSeguimientos; END IF;
  set j_seguimiento = "{";
  set j_seguimiento = CONCAT(j_seguimiento,'"idSeguimiento": ',o_idSeguimiento,',');
  set j_seguimiento = CONCAT(j_seguimiento,'"descripcion": "',o_Descripcion,'",');
  set j_seguimiento = CONCAT(j_seguimiento,'"fecha": "',o_Fecha,'",');
  set j_seguimiento = CONCAT(j_seguimiento,'"num": ',o_num,',');
  set j_seguimiento = CONCAT(j_seguimiento,"}");
  SET v_seguimientos = CONCAT(v_seguimientos,j_seguimiento,",");
END LOOP armarSeguimientos;
SET v_seguimientos = CONCAT(v_seguimientos,"]");
close cursorSeguimiento;
END;//


#INCIDENTE:
select * from Incidente;//


drop procedure if exists generarIncidentes; //
CREATE PROCEDURE generarIncidentes(out v_incidentes varchar(20000), in minNum int, in maxNum int)
BEGIN

declare v_finished INTEGER DEFAULT 0;

declare j_incidente varchar(5000);

declare o_idIncidente INT;
declare o_idDireccion INT;
declare o_Numero INT;
declare o_Fecha datetime;

declare cursorIncidentes cursor for 
select idIncidente,idDireccion,Numero,Fecha
from Incidente
where idIncidente between minNum and maxNum
order by idIncidente;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_incidentes = "[";
OPEN cursorIncidentes;
armarIncidentes: LOOP
  FETCH cursorIncidentes INTO o_idIncidente,o_idDireccion,o_Numero,o_Fecha; 
  IF v_finished = 1 THEN LEAVE armarIncidentes; END IF;  
  call generarSeguimientoParaIncidente(@o_seguimientos,o_idIncidente);
  call generarParticipaParaIncidente (@o_participaciones,o_idIncidente);
  set j_incidente = "{";
  set j_incidente = CONCAT(j_incidente,'"idIncidente": ',o_idIncidente,',');
  set j_incidente = CONCAT(j_incidente,'"idDireccion": ',o_idDireccion,',');
  set j_incidente = CONCAT(j_incidente,'"interviene": ',o_Numero,',');
  set j_incidente = CONCAT(j_incidente,'"fecha": "',o_Fecha,'",');
  set j_incidente = CONCAT(j_incidente,'"seguimientos": ',@o_seguimientos,',');
  set j_incidente = CONCAT(j_incidente,'"participan": ',@o_participaciones);
  set j_incidente = CONCAT(j_incidente,"}");

  SET v_incidentes = CONCAT(v_incidentes,j_incidente,",");
END LOOP armarIncidentes;
SET v_incidentes = CONCAT(v_incidentes,"]");

close cursorIncidentes;
END;//

call generarIncidentes(@incidentes,0,29);//   
select @incidentes;//
call generarIncidentes(@incidentes,30,59);//   
select @incidentes;//
call generarIncidentes(@incidentes,60,89);//   
select @incidentes;//
call generarIncidentes(@incidentes,90,119);//   
select @incidentes;//
call generarIncidentes(@incidentes,120,149);//   
select @incidentes;//

