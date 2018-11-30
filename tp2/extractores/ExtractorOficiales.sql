use mydb;

DELIMITER //

# SUMARIO PARA OFICIALES

drop procedure if exists generarSumariosParaDesignacionesParaOficiales; //
CREATE PROCEDURE generarSumariosParaDesignacionesParaOficiales(out v_sumarios varchar(10000), in v_designacion integer)
BEGIN

declare v_finished INTEGER DEFAULT 0;

declare j_sumario varchar(1000);

declare o_idSumario INT;
declare o_Fecha DATETIME;
declare o_Descripcion VARCHAR(45);
declare o_Resultado VARCHAR(45);
declare o_EstadoSumario INT;


declare cursorSumario cursor for 
select idSumario, fecha, descripcion, resultado, estadoSumario from Sumario
where idDesignacion = v_designacion
order by idSumario;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_sumarios = "[";
OPEN cursorSumario;
armarSumarios: LOOP
  FETCH cursorSumario INTO o_idSumario, o_fecha, o_Descripcion,o_Resultado,o_EstadoSumario; 
  IF v_finished = 1 THEN LEAVE armarSumarios; END IF;
  set j_sumario = "{";
  set j_sumario = CONCAT(j_sumario,'"idSumario": ',o_idSumario,',');
  set j_sumario = CONCAT(j_sumario,'"fecha": "',o_fecha,'",');
  set j_sumario = CONCAT(j_sumario,'"descripcion": "',o_Descripcion,'",');
  set j_sumario = CONCAT(j_sumario,'"resultado": "',o_Resultado,'",');
  set j_sumario = CONCAT(j_sumario,'"idEstado": ',o_EstadoSumario);
  set j_sumario = CONCAT(j_sumario,"}");
  set v_sumarios = CONCAT(v_sumarios,j_sumario,",");
END LOOP armarSumarios;
SET v_sumarios = CONCAT(v_sumarios,"]");
close cursorSumario;
END;//







# SUMARIO PARA OFICIALES

drop procedure if exists generarDesignacionesParaOficiales; //
CREATE PROCEDURE generarDesignacionesParaOficiales(out v_designaciones varchar(10000), in v_num integer)
BEGIN

declare v_finished INTEGER DEFAULT 0;

declare j_designacion varchar(1000);
declare o_idDesignacion INT;
declare o_fecha VARCHAR(45);
declare o_idTipo INT;

declare cursorDesignacion cursor for 
select idDesignacion, fecha, idTipo from Designacion 
where num = v_num
order by idDesignacion;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_designaciones = "[";
OPEN cursorDesignacion;
armarDesignaciones: LOOP
  FETCH cursorDesignacion INTO o_idDesignacion, o_fecha, o_idTipo; 
  IF v_finished = 1 THEN LEAVE armarDesignaciones; END IF;
  call generarSumariosParaDesignacionesParaOficiales(@o_sumarios,o_idDesignacion);
  set j_designacion = "{";
  set j_designacion = CONCAT(j_designacion,'"idDesignacion": ',o_idDesignacion,',');
  set j_designacion = CONCAT(j_designacion,'"Fecha": "',o_fecha,'",');
  set j_designacion = CONCAT(j_designacion,'"idTipo": ',o_idTipo,',');
  set j_designacion = CONCAT(j_designacion,'"sumarios": ',@o_sumarios);
  set j_designacion = CONCAT(j_designacion,"}");
  SET v_designaciones = CONCAT(v_designaciones,j_designacion,",");
END LOOP armarDesignaciones;
SET v_designaciones = CONCAT(v_designaciones,"]");
close cursorDesignacion;
END;//




#OFICIALES

drop procedure if exists generarDatosOficial; //
CREATE PROCEDURE generarDatosOficial(out v_oficiales varchar(10000000), out i integer, in minNum int, in maxNum int)
BEGIN

declare v_finished INTEGER DEFAULT 0;

declare j_oficial varchar(50000);
declare o_num INT;
declare o_Nombre VARCHAR(45);
declare o_FechaIngreso VARCHAR(45);
declare o_Rango VARCHAR(45);
declare o_idDepartamento INT;
declare o_Apellido VARCHAR(45);

declare cursorOficial cursor for 
select Num,Nombre,Apellido,FechaIngreso,Rango,idDepartamento 
from Oficial
where Num between minNum and maxNum
order by Num;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

set v_oficiales = "[";
set i = 0;
OPEN cursorOficial;
armarOficiales: LOOP
  FETCH cursorOficial INTO o_Num,o_Nombre,o_Apellido,o_FechaIngreso,o_Rango,o_idDepartamento; 
  IF v_finished = 1 THEN LEAVE armarOficiales; END IF;  
  call generarDesignacionesParaOficiales(@o_designaciones,o_Num);
  set j_oficial = "{";
  set j_oficial = CONCAT(j_oficial,'"Num": ',o_Num,',');
  set j_oficial = CONCAT(j_oficial,'"Nombre": "',o_Nombre,'",');
  set j_oficial = CONCAT(j_oficial,'"Apellido": "',o_Apellido,'",');
  set j_oficial = CONCAT(j_oficial,'"Fecha": "',o_FechaIngreso,'",');
  set j_oficial = CONCAT(j_oficial,'"Rango": "',o_Rango,'",');
  set j_oficial = CONCAT(j_oficial,'"idDepartamento": ',o_idDepartamento,',');
  set j_oficial = CONCAT(j_oficial,'"designaciones": ',@o_designaciones);
  set j_oficial = CONCAT(j_oficial,"}");

  SET v_oficiales = CONCAT(v_oficiales,j_oficial,",");
  set i = i+1;
END LOOP;
SET v_oficiales = CONCAT(v_oficiales,"]");

close cursorOficial;
END;//

call generarDatosOficial(@oficiales,@i,0,9);//   
select @oficiales,@i;//
call generarDatosOficial(@oficiales,@i,10,19);// 
select @oficiales,@i;//
call generarDatosOficial(@oficiales,@i,20,29);// 
select @oficiales,@i;//
call generarDatosOficial(@oficiales,@i,30,39);// 
select @oficiales,@i;//
call generarDatosOficial(@oficiales,@i,40,49);// 
select @oficiales,@i;//
call generarDatosOficial(@oficiales,@i,50,59);// 
select @oficiales,@i;//
call generarDatosOficial(@oficiales,@i,60,69);// 
select @oficiales,@i;//

#call generarDesignacionesParaOficiales(@designaciones,3);//
#select @designaciones;//
