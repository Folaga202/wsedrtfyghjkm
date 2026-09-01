#!/bin/bash

# Script per creare bootanimation da video
# Richiede: ffmpeg, ImageMagick (convert)
# Uso: ./create_bootanimation.sh <video.mp4>

set -e

VIDEO="${1:?Specifica il video: ./create_bootanimation.sh video.mp4}"
FPS=50
WIDTH=720
HEIGHT=240
OUTPUT_DIR="bootanimation_work"
ZIP_NAME="bootanimation.zip"

echo "🎬 Creando bootanimation da: $VIDEO"
echo "⚙️  FPS: $FPS | Risoluzione: ${WIDTH}x${HEIGHT}"

# Crea directory di lavoro
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR/part0"

echo "📹 Estraendo frame dal video..."
ffmpeg -i "$VIDEO" -vf "fps=$FPS,scale=$WIDTH:$HEIGHT:force_original_aspect_ratio=decrease,pad=$WIDTH:$HEIGHT:(ow-iw)/2:(oh-ih)/2:black" \
  "$OUTPUT_DIR/part0/%04d.png" -loglevel error

# Conta i frame
FRAME_COUNT=$(ls "$OUTPUT_DIR/part0" | wc -l)
echo "✅ Estratti $FRAME_COUNT frame"

# Crea desc.txt
echo "📝 Creando desc.txt..."
cat > "$OUTPUT_DIR/desc.txt" << EOF
$WIDTH $HEIGHT $FPS
c 0 0 part0
EOF

echo "🔧 Contenuto desc.txt:"
cat "$OUTPUT_DIR/desc.txt"

# Crea bootanimation.zip
echo "📦 Creando bootanimation.zip..."
cd "$OUTPUT_DIR"
zip -r "../$ZIP_NAME" . -q
cd ..

SIZE=$(du -h "$ZIP_NAME" | cut -f1)
echo "✅ Bootanimation creata: $ZIP_NAME ($SIZE)"
echo ""
echo "📋 Struttura:"
echo "  $ZIP_NAME"
echo "  ├── part0/ ($FRAME_COUNT PNG)"
echo "  └── desc.txt"
echo ""
echo "🚀 Prossimi passi:"
echo "1. Sposta $ZIP_NAME nella cartella del modulo Magisk"
echo "2. Struttura attesa:"
echo "   system/product/media/bootanimation.zip"
echo "3. Installa il modulo Magisk su Android"
echo ""
echo "💾 Puoi eliminare '$OUTPUT_DIR' dopo aver verificato il file zip"
