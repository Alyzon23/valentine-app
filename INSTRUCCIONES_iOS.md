# 📱 INSTRUCCIONES PARA iOS (iPhone)

## ⚠️ IMPORTANTE: Para compilar para iOS necesitas una Mac

Desde Windows no se puede compilar para iOS. Tienes 3 opciones:

---

## OPCIÓN 1: Usar una Mac (Recomendado)

1. Copia toda la carpeta `valentine_app` a una Mac
2. Instala Flutter en la Mac: https://docs.flutter.dev/get-started/install/macos
3. Instala Xcode desde la App Store
4. Abre Terminal y ejecuta:
   ```bash
   cd valentine_app
   flutter pub get
   open ios/Runner.xcworkspace
   ```
5. En Xcode:
   - Conecta el iPhone
   - Selecciona el iPhone como destino
   - Presiona el botón ▶️ (Run)
   - En el iPhone: Ajustes → General → Administración de dispositivos → Confiar

---

## OPCIÓN 2: Usar un servicio en la nube (GRATIS)

### Codemagic (Recomendado - Gratis para proyectos pequeños)

1. Ve a: https://codemagic.io
2. Crea una cuenta gratis
3. Conecta tu repositorio (GitHub, GitLab, etc.)
4. Sube el proyecto `valentine_app`
5. Configura el build para iOS
6. Descarga el archivo .ipa
7. Instala en el iPhone usando TestFlight o AltStore

---

## OPCIÓN 3: Convertir a Web App (MÁS FÁCIL)

Si quieres algo rápido que funcione en iPhone SIN compilar:

```bash
flutter build web
```

Luego sube la carpeta `build/web` a cualquier hosting gratis:
- GitHub Pages
- Netlify
- Vercel

Tu ñaña solo abre el link en Safari y ¡listo! Funciona como app.

---

## 🤖 PARA ANDROID YA ESTÁ LISTA

La APK está en:
`build/app/outputs/flutter-apk/app-release.apk`

Solo envíala por WhatsApp y que la instale en su Android.

---

## 💡 RECOMENDACIÓN

Si tu ñaña tiene iPhone, la opción más fácil es:
1. Compilar como Web App
2. Subirla a un hosting gratis
3. Enviarle el link
4. Ella lo abre en Safari
5. Toca "Compartir" → "Agregar a pantalla de inicio"
6. ¡Queda como una app en su iPhone!

¿Quieres que compile la versión Web?
