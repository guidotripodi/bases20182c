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
    createAndLoadCollection("asuntosInternos", "./datos/asuntosInternos.json").then(
        ()=> createAndLoadCollection("barrio", "./datos/barrio.json"),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection("calle", "./datos/calle.json"),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection("cerrado", "./datos/cerrado.json"),
        err => console.log(err)
    
    ).then(
        ()=> createAndLoadCollection("departamento", "./datos/Departamento.json"),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection("designacion", "./datos/designacion.json"),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection("estadoSumario", "./datos/estadoSumario.json"),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection("habilidadSuperheroe", "./datos/habilidad Superheroe.json"),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection('incidentes', './datos/Incidentes.json'),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection('interviene', './datos/interviene.json'),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection('involucrado', './datos/involucrado.json'),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection("oficiales", "./datos/Oficiales.json"),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection('organizacionesdelictivas', './datos/OrganizacionesDelictivas.json'),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection("pendiente", "./datos/pendiente.json"),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection("persona", "./datos/persona.json"),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection("proceso", "./datos/proceso.json"),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection("seguimiento", "./datos/seguimiento.json"),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection("sumario", "./datos/sumario.json"),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection("superheroe", "./datos/superheroe.json"),
        err => console.log(err)
    ).then(
        ()=> createAndLoadCollection("tipodesignacion", "./datos/tipodesignacion.json"),
        err => console.log(err)
    ).then(
    ()=> createAndLoadCollection("vinculo", "./datos/vinculo.json"),
        err => console.log(err)
    )
}


const createAndLoadCollection = (collectionName, filename) => {
    const content = fs.readFileSync(filename);
    const jsonContent = JSON.parse(content);
    collection = db.collection(collectionName)

    return collection.create().then(
        () => {
            return collection.import(jsonContent)
        },
        err => console.error('Failed to create collection:', err)
    )
}
