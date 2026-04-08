from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import pymysql
from passlib.context import CryptContext
 
app = FastAPI()
 
# CORS: Permite que Flutter se conecte al servidor
app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=True,
    allow_methods=['*'],
    allow_headers=['*'],
)
 
# Herramienta para encriptar y verificar contraseñas
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
 
def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)
 
def get_password_hash(password):
    return pwd_context.hash(password)
 
# Conexión a MySQL
def get_db_connection():
    return pymysql.connect(
        host='127.0.0.1',
        user='root',             # Pon tu usuario de MySQL
        password='0147',             # Pon tu contraseña de MySQL si tienes
        database='auth_db',
        cursorclass=pymysql.cursors.DictCursor
    )
 
class UserData(BaseModel):
    email: str
    password: str
 
class RegisterData(BaseModel):
    name: str
    email: str
    password: str
 
# --- RUTA 1: REGISTRAR UN USUARIO ---
@app.post("/register")
def register(data: RegisterData):
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            # Evitamos correos duplicados
            cursor.execute("SELECT * FROM users WHERE email = %s", (data.email,))
            if cursor.fetchone():
                raise HTTPException(status_code=400, detail="El usuario ya existe")
 
            # ENCRIPTAMOS LA CONTRASEÑA ANTES DE GUARDARLA
            hashed_password = get_password_hash(data.password)
            sql = "INSERT INTO users (name, email, password) VALUES (%s, %s, %s)"
            cursor.execute(sql, (data.name, data.email, hashed_password))
            connection.commit()
 
            return {"success": True, "message": "Usuario creado exitosamente"}
    finally:
        connection.close()
 
# --- RUTA 2: INICIO DE SESIÓN ---
@app.post("/login")
def login(data: UserData):
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            sql = "SELECT * FROM users WHERE email = %s"
            cursor.execute(sql, (data.email,))
            user = cursor.fetchone()
 
            if not user or not verify_password(data.password, user['password']):
                raise HTTPException(status_code=401, detail="Credenciales incorrectas")
 
            return {"success": True, "message": "Autenticación exitosa", "token": "token-temporal"}
    finally:
        connection.close()