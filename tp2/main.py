import pyArango
from pyArango.connection import *
import json

conn = Connection(username="root", password="tp2")
if conn.hasDatabase("tp2"):
    db=conn['tp2']
    conn["tp2"].dropAllCollections()
else:
    db = conn.createDatabase(name="tp2")


#  oficial = db.createCollection(name="oficial")
#  departamento = db.createCollection(name="departamento")
#  incidente= db.createCollection(name="incidente")
#  superheroe= db.createCollection(name="superheroe")
#  habilidad= db.createCollection(name="habilidad")
#  persona= db.createCollection(name="persona")
#  direccion= db.createCollection(name="direccion")


def createAndLoadCollection(db, collectionName, fileName):
    collection = db.createCollection(name=collectionName)
    with open(fileName) as json_data:
        d = json.load(json_data)
        json_data.close()
        for item in d:
            doc = collection.createDocument()
            doc.set(item)
            doc.save()


createAndLoadCollection(db, "calle", "../mockArango-Calle.txt")
createAndLoadCollection(db, "barrio", "../mockArango-Barrio.txt")
createAndLoadCollection(db, "oficial", "../mockArango-Oficial-Completo-V1.txt")
createAndLoadCollection(db, "direccion", "../mockArango-Direccion.txt")
#  createAndLoadCollection(db,'persona','../mockArango-Persona.txt')
#  createAndLoadCollection(db,'superheroe','../mockArango-Superheroe.txt')
#  createAndLoadCollection(db,'incidente','../mockArango-Incidente.txt')
#  createAndLoadCollection(db,'estadosumario','../mockArango-EstadoSumario.txt')
