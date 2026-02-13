# 📱 CÓMO COMPILAR PARA iOS CON CODEMAGIC (GRATIS)

## Paso 1: Crear cuenta en GitHub (si no tienes)
1. Ve a https://github.com
2. Crea una cuenta gratis
3. Verifica tu email

## Paso 2: Subir el proyecto a GitHub

### Opción A: Desde GitHub Desktop (Más fácil)
1. Descarga GitHub Desktop: https://desktop.github.com
2. Instala y abre GitHub Desktop
3. Click en "File" → "Add local repository"
4. Selecciona la carpeta: `C:\my valentine\valentine_app`
5. Click en "Create repository"
6. Click en "Publish repository"
7. Desmarca "Keep this code private" (o déjalo privado si prefieres)
8. Click en "Publish repository"

### Opción B: Desde la web de GitHub
1. Ve a https://github.com/new
2. Nombre del repositorio: `valentine-app`
3. Click en "Create repository"
4. Sigue las instrucciones para subir archivos

## Paso 3: Configurar Codemagic

1. Ve a https://codemagic.io
2. Click en "Sign up for free"
3. Inicia sesión con tu cuenta de GitHub
4. Autoriza a Codemagic
5. Click en "Add application"
6. Selecciona tu repositorio `valentine-app`
7. Click en "Finish: Add application"

## Paso 4: Configurar el Build para iOS

1. En Codemagic, selecciona tu app
2. Click en "Start new build"
3. Selecciona la rama "main" o "master"
4. En "Build for platforms" selecciona **iOS**
5. Click en "Start new build"

## Paso 5: Esperar la compilación

- Toma entre 10-20 minutos
- Puedes ver el progreso en tiempo real
- Cuando termine, verás un ✅ verde

## Paso 6: Descargar el archivo

1. Click en el build completado
2. Ve a la sección "Artifacts"
3. Descarga el archivo `.app` o `.ipa`

## Paso 7: Instalar en el iPhone

### Opción A: Con AltStore (Recomendado - Gratis)
1. Descarga AltStore: https://altstore.io
2. Instala AltStore en tu PC
3. Conecta el iPhone
4. Arrastra el archivo .ipa a AltStore
5. Se instalará en el iPhone

### Opción B: Con TestFlight (Requiere cuenta de desarrollador)
1. Sube el .ipa a App Store Connect
2. Invita a tu ñaña como tester
3. Ella descarga desde TestFlight

### Opción C: Con Diawi (Más fácil)
1. Ve a https://www.diawi.com
2. Sube el archivo .ipa
3. Te da un link
4. Envía el link a tu ñaña
5. Ella lo abre en Safari y lo instala

---

## 🎯 RESUMEN RÁPIDO

1. Sube el proyecto a GitHub
2. Conecta Codemagic con GitHub
3. Compila para iOS (gratis)
4. Descarga el .ipa
5. Instala con AltStore o Diawi

---

## ⚠️ IMPORTANTE

- Codemagic es GRATIS para 500 minutos al mes
- No necesitas Mac
- No necesitas pagar cuenta de desarrollador de Apple
- El archivo .ipa funciona en cualquier iPhone

---

## 💡 ¿Necesitas ayuda?

Si tienes problemas, puedo ayudarte con cada paso. Solo dime en qué parte te quedaste.
