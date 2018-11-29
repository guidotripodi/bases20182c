CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Involucra_BEFORE_INSERT` BEFORE INSERT ON `Involucra` FOR EACH ROW
BEGIN
 if(new.Rol != 'Testigo' || new.Rol != 'Víctima' || new.Rol != 'Instigador'|| new.Rol != 'Sospechoso') then
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Atributo ROL debe ser Testigo||Victima||Instigador||Sospechoso';
end if;
END
