# ctr-storage-DES

Servico de storage estatico baseado em Nginx para servir arquivos da pasta `storage/`.

## Requisitos

- Docker
- Docker Compose

## Configuracao inicial

1) Clone o repositorio.
2) Dê permissao de execucao para o script e execute-o:

```bash
chmod +x prepare.sh
./prepare.sh
```

3) Copie o arquivo de variaveis de ambiente e edite o que for necessario:

```bash
cp .env.example .env
```

## Subir o servico

```bash
docker compose up -d
```

## Notas

- O script `prepare.sh` cria a pasta `storage/` e as subpastas padrao, ajusta permissoes e cria a rede Docker `network-share`.
- O servico expõe a porta `6081`.
