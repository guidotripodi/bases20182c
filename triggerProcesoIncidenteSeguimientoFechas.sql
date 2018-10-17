CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Seguimiento_BEFORE_INSERT` BEFORE INSERT ON mdyb.Seguimiento FOR EACH ROW
BEGIN
	SET @fecha_incidente = (select Fecha From Incidente where incidente.idincidente = new.proceso_Incidente);    
    IF @fecha_incidente > @new.Fecha
    THEN
              SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Seguimiento no puede tener fecha anterior al Incidente';
    END IF;
END;
