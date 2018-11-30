const fs = require("fs");
const Database = require('arangojs').Database;



const db = new Database('http://root:tp2@127.0.0.1:8529');

db.listDatabases().then(
    (list) => {
        var db = list.filter(item => item === 'tp2')
        if (db.length === 0) {
            createDatabaseTP();
        } else {
            dropAndCreate();
        }
    },
    err => console.error('Failed to create database:', err)
)

const dropAndCreate = () => {
    db.dropDatabase('tp2').then(
        () => {
            console.log('Database Dropped')
            createDatabaseTP();
        },
        err => console.error('Failed to drop database:', err)
    )
}
const createDatabaseTP = () => {
    db.createDatabase('tp2').then(
        () => {
            console.log('Database created');
            db.useDatabase('tp2');
            createAllFiles()
        },
        err => console.error('Failed to create database:', err)
    )
}
const createAllFiles = () => {
    createAndLoadCollection("asuntosInternos", "./datos/asuntosInternos.json")
    createAndLoadCollection("barrio", "./datos/barrio.json")
    createAndLoadCollection("calle", "./datos/calle.json")
    createAndLoadCollection("cerrado", "./datos/cerrado.json")
    createAndLoadCollection("departamento", "./datos/Departamento.json")
    createAndLoadCollection("designacion", "./datos/designacion.json")
    createAndLoadCollection("estadoSumario", "./datos/estadoSumario.json")
    createAndLoadCollection("habilidadSuperheroe", "./datos/habilidad Superheroe.json")
    createAndLoadCollection('incidentes', './datos/Incidentes.json')
    createAndLoadCollection('interviene', './datos/interviene.json')
    createAndLoadCollection('involucrado', './datos/involucrado.json')
    createAndLoadCollection("oficiales", "./datos/Oficiales.json")
    createAndLoadCollection('organizacionesdelictivas', './datos/OrganizacionesDelictivas.json')
    createAndLoadCollection("pendiente", "./datos/pendiente.json")
    createAndLoadCollection("persona", "./datos/persona.json")
    createAndLoadCollection("proceso", "./datos/proceso.json")
    createAndLoadCollection("seguimiento", "./datos/seguimiento.json")
    createAndLoadCollection("sumario", "./datos/sumario.json")
    createAndLoadCollection("superheroe", "./datos/superheroe.json")
    createAndLoadCollection("tipodesignacion", "./datos/tipodesignacion.json")
    createAndLoadCollection("vinculo", "./datos/vinculo.json")
}


const createAndLoadCollection = (collectionName, filename) => {
    const content = fs.readFileSync(filename);
    const jsonContent = JSON.parse(content);
    collection = db.collection(collectionName)

    collection.create().then(
        () => {
            collection.import(jsonContent).then(
                result => console.log('Import complete:'),
                err => console.error('Import failed:'+err)
            );
        },
        err => console.error('Failed to create collection:', err)
    );
}
