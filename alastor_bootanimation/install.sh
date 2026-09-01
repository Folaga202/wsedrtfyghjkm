#!/system/bin/sh
# Magisk Module Installation Script
# This script copies the bootanimation.zip to the correct location

MODDIR=${0%/*}

# Crea la cartella di destinazione se non esiste
mkdir -p $MODPATH/system/product/media

# Copia il bootanimation.zip nella posizione corretta
if [ -f "$MODDIR/bootanimation.zip" ]; then
    cp "$MODDIR/bootanimation.zip" "$MODPATH/system/product/media/bootanimation.zip"
    chmod 644 "$MODPATH/system/product/media/bootanimation.zip"
    echo "✓ Bootanimation installata con successo!"
else
    echo "✗ Errore: bootanimation.zip non trovato!"
    exit 1
fi

exit 0
