#!/usr/bin/env bash
# Build l'APK debug et installe sans effacer les données SQLite.
set -e

cd "$(git rev-parse --show-toplevel)"

echo "→ Build APK debug..."
nix develop --command bash -c "flutter build apk --debug"

echo "→ Install sur le device (données préservées)..."
adb install -r build/app/outputs/flutter-apk/app-debug.apk

echo "→ Lancement..."
adb shell am start -n local.gymcompanion.gym_companion/.MainActivity

echo "✓ Déployé"
