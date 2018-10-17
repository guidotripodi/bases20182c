CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Sumario_BEFORE_INSERT` BEFORE INSERT ON mdyb.sumario FOR EACH ROW
BEGIN
	SET @dateDesignacion = (select fecha From DESIGNACION DES WHERE DES.IDDESIGNACION = NEW.IDDESIGNACION);    
    IF @dateDesignacion > new.fecha
    THEN
              SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'la fecha del sumario no puede ser anterior a la designacion';
    END IF;
END;
