delimiter $
create procedure superheroeConHabilidad(in Habilidad varchar(24))
begin
SELECT superheroe.Nombre FROM mydb.Habilidad AS habilidad, mydb.Superheroe as superheroe, mydb.EsCapazDe as esCapaz
where habilidad.Nombre = Habilidad and superheroe.idSuperheroe = esCapaz.idSuperheroe and esCapaz.idHabilidad = habilidad.idHabilidad;
end
$