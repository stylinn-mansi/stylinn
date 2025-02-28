#!/bin/bash

# Install Flutter
git clone https://github.com/flutter/flutter.git --depth 1 -b stable flutter
export PATH="$PATH:`pwd`/flutter/bin"

# Check Flutter and enable web
flutter doctor -v
flutter config --enable-web

# Build the web app
flutter build web --release --no-tree-shake-icons

echo "Build completed successfully!" 