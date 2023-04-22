import express from 'express';
import {createPool} from 'mysql2/promise';

const app = express();

//middlewares
app.use(express.json());

const PORT = 3000;

//DB configuration
const DB_HOST = "localhost";
const DB_PORT = 3306;
const DB_USER =  'root';
const DB_PASSWORD = 'usuario1';
const DB_DATABASE= 'ZAPATERIA';

const pool= createPool({
    host: DB_HOST,
    port: DB_PORT,
    user: DB_USER,
    password: DB_PASSWORD,
    database: DB_DATABASE
});

//Endspoints

//Metodo para obtener lista de usuarios creados 
app.get('/USUARIO',async (req,res)=>{
    try {
        const [rows]= await pool.query("SELECT Nombre_Usuario, ID_Usuario FROM USUARIO");

        res.json(rows);
    } catch (error) {
       console.error('Error',error);

       return res.status(500).json({message:'Error al procesar la solicitud'});
    }
});


// Metodo para obtener un usuario especifico
app.get('/USUARIO/:Nombre_Usuario', async (req,res)=>{
    try {
        const {Nombre_Usuario} = req.params;

        const [rows]= await pool.query("SELECT Nombre_Usuario, ID_Usuario FROM USUARIO WHERE Nombre_Usuario = ?", [Nombre_Usuario]);

        if(rows.length == 0){
            return res.status(404).json ({message:"Usuario no encontrado"});
        }

        res.json(rows);

    } catch (error) {
        console.error('Error',error);

       return res.status(500).json({message:'Error al procesar la solicitud'});
    }
});

app.post("/USUARIO", async (req, res)=>{
    try {
        const {Nombre_Usuario, Contraseña} = req.body;

        const [rows] = await pool.query(
            "INSERT INTO USUARIO(ID_Usuario, Nombre_Usuario, Contraseña) VALUES(uuid(), ?,?)", 
            [Nombre_Usuario, Contraseña]
        );

        res.status(201).json({message:"Usuario Creado"});

    } catch (error) {
        console.error('Error',error);

       return res.status(500).json({message:'Error al procesar la solicitud'});
    }
})

//Metodo Editar
app.put('/USUARIO/:Nombre_Usuario', async (req,res)=>{
    try {
        const {Nombre_Usuario} = req.params;
        const {NuevoNombre_Usuario, Contraseña} =req.body;

        const [result] = await pool.query(
            "UPDATE USUARIO SET Nombre_Usuario = IFNULL(?,Nombre_Usuario), Contraseña = IFNULL(?, Contraseña) WHERE Nombre_Usuario = ?",
            [NuevoNombre_Usuario, Contraseña, Nombre_Usuario]
        )

        if(result.affectedRows === 0)
            return res.status(404).json({message:"Usuario no encontrado"});
        else 
        res.json({message: "Datos Guardados"})
         

    } catch (error) {
        console.error('Error',error);

        return res.status(500).json({message:'Error al procesar la solicitud'});
    }
});

//Metodo para eliminar Usuario
app.delete("/USUARIO/:Nombre_Usuario", async (req,res)=>{
    try {

        const {Nombre_Usuario}=req.params;

        const [rows] = await pool.query(
            "DELETE FROM USUARIO WHERE Nombre_Usuario = ?",
            [Nombre_Usuario]
        );

        if(rows.affectedRows<=0){
            return res.status(404).json({message:"Usuario no encontrado"});
        }
        else
            res.status(204).json({message:"Usuario Eliminado"});

    } catch (error) {
        console.error('Error',error);

        return res.status(500).json({message:'Error al procesar la solicitud'});
    }
})

app.listen(PORT,()=>{
    console.log('Aplicacion corriendo en el puerto',PORT)
})

