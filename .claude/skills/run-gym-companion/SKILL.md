---
name: run-gym-companion
description: Déployer Chalk sur le téléphone Android via ADB sans perdre les données SQLite. Utiliser pour tester une modification sur le device physique — flutter run efface les données, ce script non.
---

Chalk est une app Flutter Android (powerlifting tracker). Ce skill build l'APK debug et l'installe avec `adb install -r` (replace — préserve les données SQLite). Le device est un Pixel 6a connecté en USB.

## Prérequis

- Téléphone connecté en USB avec débogage USB activé (`adb devices` doit lister l'appareil)
- Shell Nix disponible (`nix develop` dans le projet)

## Déployer

```bash
bash .claude/skills/run-gym-companion/deploy.sh

Build (~30s), installe sans effacer les données, relance l'app automatiquement.

Capturer l'écran après deploy

adb shell input keyevent KEYCODE_WAKEUP
adb shell screencap -p /sdcard/s.png && adb pull /sdcard/s.png /tmp/s.png

Les coordonnées sont en pixels natifs (1080×2400 sur Pixel 6a). Pour taper :

adb shell input tap <x> <y>

Gotchas

- flutter run efface les données — ne jamais utiliser pour tester, toujours passer par ce script.
- nix develop --command "flutter build apk" échoue — obligatoirement via bash -c "...".
- L'écran dort — toujours KEYCODE_WAKEUP avant screenshot.
- Package : local.gymcompanion.gym_companion / activité .MainActivity
- APK : build/app/outputs/flutter-apk/app-debug.apk
