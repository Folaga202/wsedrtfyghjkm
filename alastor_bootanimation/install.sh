#!/system/bin/sh
# Magisk Module Installation Script
MODDIR=${0%/*}

# Crea la cartella di destinazione nel modulo
mkdir -p "$MODDIR/system/product/media"

# Copia il bootanimation.zip nella struttura del modulo
if [ -f "$MODDIR/bootanimation.zip" ]; then
    cp "$MODDIR/bootanimation.zip" "$MODDIR/system/product/media/bootanimation.zip"
    chmod 644 "$MODDIR/system/product/media/bootanimation.zip"
    
    # Forza anche il link simbolico (se esiste)
    ln -sf bootanimation.zip "$MODDIR/system/product/media/bootanimation-dark.zip"
    
    echo "✓ Bootanimation installata!"
else
    echo "✗ ERRORE: bootanimation.zip non trovato in $MODDIR"
    exit 1
fi

exit 0
