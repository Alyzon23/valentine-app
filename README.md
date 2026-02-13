# 💕 App Valentine para Mi Ñaña

## App Flutter que funciona en iOS y Android

### ¿Qué tiene la app?

1. **Pregunta inicial** - "¿Quieres ser mi Valentine?" con botón NO que se escapa
2. **Celebración** - Cuando dice SÍ
3. **Menú principal** con 3 opciones:
   - 🎮 **Juegos** - Juego tipo Flappy Bird (corazón que salta entre obstáculos)
   - 💌 **Notas de Cariño** - 8 tarjetas bonitas con mensajes
   - 📸 **Nuestras Fotos** - Galería con tus fotos

---

## 📱 Para compilar para iOS (iPhone)

### Requisitos:
- Mac con Xcode instalado
- Cuenta de Apple Developer (puede ser gratis)

### Pasos:

1. **Abre el proyecto en Xcode:**
   ```bash
   cd valentine_app
   open ios/Runner.xcworkspace
   ```

2. **Configura el Bundle Identifier:**
   - En Xcode, selecciona "Runner" en el navegador
   - En "Signing & Capabilities"
   - Cambia el Bundle Identifier a algo único: `com.tunombre.valentine`
   - Selecciona tu equipo de desarrollo

3. **Conecta el iPhone:**
   - Conecta el iPhone con cable
   - Confía en la computadora desde el iPhone
   - En Xcode, selecciona tu iPhone como destino

4. **Compila e instala:**
   ```bash
   flutter build ios
   ```
   O desde Xcode: presiona el botón ▶️ (Run)

5. **En el iPhone:**
   - Ve a Ajustes → General → Administración de dispositivos
   - Confía en el desarrollador
   - ¡Abre la app!

---

## 🤖 Para compilar para Android (APK)

```bash
cd valentine_app
flutter build apk --release
```

La APK estará en: `build/app/outputs/flutter-apk/app-release.apk`

---

## 🚀 Para probar en el emulador

### iOS Simulator:
```bash
open -a Simulator
flutter run
```

### Android Emulator:
```bash
flutter emulators --launch <emulator_id>
flutter run
```

---

## 📝 Notas importantes

- **Para iOS necesitas una Mac** con Xcode
- Si no tienes Mac, puedes usar un servicio como Codemagic o GitHub Actions
- La app funciona igual en iOS y Android con el mismo código
- Las fotos están en la carpeta `assets/`

---

## 💖 ¡Que lo disfrute tu ñaña!
