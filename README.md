# Interaktiivne Linux serveri halduse abiline

Käesolev repositoorium sisaldab Tallinna Tööstushariduskeskuse
Tööstusinformaatika eriala lõputöö raames loodud rakenduse lähtekoodi ja
andmebaasi dump’i.

Töö kirjeldus, eesmärgid ja lahenduse detailne selgitus on esitatud
vastavas lõputöös.

## Andmebaasi importimine

```bash
sudo mysql -e "CREATE DATABASE error_helper;"
sudo mysql error_helper < db/error_helper.sql
