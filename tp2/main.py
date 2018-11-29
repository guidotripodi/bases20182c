import pyArango
from pyArango.connection import *
import json

conn = Connection(username="root", password="tp2")
if conn.hasDatabase("tp2"):
    db=conn['tp2']
    conn["tp2"].dropAllCollections()
else:
    db = conn.createDatabase(name="tp2")

def createAndLoadCollection(db, collectionName, fileName):
    collection = db.createCollection(name=collectionName)
    with open(fileName) as json_data:
        d = json.load(json_data)
        json_data.close()
        for item in d:
            doc = collection.createDocument()
            doc.set(item)
            doc.save()


createAndLoadCollection(db, "calle", "../calle.json")
createAndLoadCollection(db, "barrio", "../barrio.json")
createAndLoadCollection(db, "oficial", "../mockArango-Oficial-Completo-V1.txt")
createAndLoadCollection(db, "cerrado", "../cerrado.json")
createAndLoadCollection(db, "departamento", "../Departamento.json")
createAndLoadCollection(db, "asuntosInternos", "../asuntosInternos.json")
createAndLoadCollection(db, "habilidadSuperheroe", "../habilidad Superheroe.json")
createAndLoadCollection(db, "pendiente", "../pendiente.json")
createAndLoadCollection(db, "seguimiento", "../seguimiento.json")
createAndLoadCollection(db, "tipodesignacion", "../tipodesignacion.json")
createAndLoadCollection(db, "vinculo", "../vinculo.json")
#  createAndLoadCollection(db,'persona','../mockArango-Persona.txt')
#  createAndLoadCollection(db,'superheroe','../mockArango-Superheroe.txt')
#  createAndLoadCollection(db,'incidente','../mockArango-Incidente.txt')
#  createAndLoadCollection(db,'estadosumario','../mockArango-EstadoSumario.txt')
