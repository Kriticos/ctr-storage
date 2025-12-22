#!/bin/bash

echo "📁 Iniciando preparação do ambiente ctr-imgsrv..."

# Diretório onde o script está
BASE_DIR="$(dirname "$(realpath "$0")")"

# Pasta de storage
STORAGE_DIR="$BASE_DIR/storage"

# Subpastas esperadas
STORAGE_SUBDIRS=(
  "produtos"
  "usuarios"
  "banners"
  "logos"
)

# Criando pasta storage
if [ ! -d "$STORAGE_DIR" ]; then
  echo "📂 Criando $STORAGE_DIR"
  mkdir -p "$STORAGE_DIR"
else
  echo "✔️ Já existe: $STORAGE_DIR"
fi

# Criando subpastas
for SUB in "${STORAGE_SUBDIRS[@]}"; do
  if [ ! -d "$STORAGE_DIR/$SUB" ]; then
    echo "📂 Criando $STORAGE_DIR/$SUB"
    mkdir -p "$STORAGE_DIR/$SUB"
  else
    echo "✔️ Já existe: $STORAGE_DIR/$SUB"
  fi
done

echo "🔧 Ajustando permissões do storage..."

# Dono root (compatível com seu padrão)
chown -R root:root "$STORAGE_DIR"

# Permissões:
# - diretórios: 755
# - arquivos: 644
find "$STORAGE_DIR" -type d -exec chmod 755 {} \;
find "$STORAGE_DIR" -type f -exec chmod 644 {} \;

# Garantir bit de execução nos diretórios
chmod -R a+X "$STORAGE_DIR"

# Criando rede Docker se não existir
if ! docker network ls | grep -q "network-share"; then
  echo "🌐 Criando rede network-share..."
  docker network create \
    --driver=bridge \
    --subnet=172.18.0.0/16 \
    network-share
else
  echo "✔️ Rede network-share já existe"
fi

echo "✅ Preparação concluída com sucesso!"
