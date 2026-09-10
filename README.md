# Scripts personnels

Petites commandes Bash destinées à être disponibles depuis `~/bin`. Ajoutez ce
dossier à votre `PATH` si nécessaire :

```bash
export PATH="$HOME/bin:$PATH"
```

## Commandes

### `cgo`

Raccourcis vers les dossiers de projets.

```bash
# À ajouter à ~/.bashrc ou ~/.bash_aliases pour changer le répertoire du shell courant.
cgo() { source "$HOME/bin/cgo" "$@"; }

cgo list
cgo quambio
cgo add api ~/Documents/projets-clients/api
cgo remove api
```

La configuration est stockée dans
`$XDG_CONFIG_HOME/cgo/shortcuts` (ou `~/.config/cgo/shortcuts`). Si elle
n'existe pas, `cgo` la crée et indique comment ajouter un raccourci.

### `uptime-check`

Vérifie le code HTTP et le temps de réponse de chaque URL configurée.

```bash
uptime-check
uptime-check --direct
uptime-check --timeout 20
uptime-check --file /chemin/vers/urls
```

Les URL sont stockées dans `$XDG_CONFIG_HOME/uptime-check/urls` (ou
`~/.config/uptime-check/urls`), à raison d'une URL par ligne. Si le fichier de
configuration par défaut n'existe pas, la commande le crée puis indique qu'il
faut le renseigner. Avec `--file`, le fichier indiqué doit déjà exister.

`--direct` sélectionne l'interface de la route Internet principale pour éviter
un éventuel nœud de sortie NetBird. `--interface NOM` permet de choisir une
interface explicitement.

### `ssh-list`

Liste les hôtes de `~/.ssh/config`.

```bash
ssh-list
ssh-list backtik
ssh-list --verbose
```

### `st`

Alterne les thèmes Ghostty `Catppuccin Latte` et `Monokai Pro Spectrum`, puis
recharge Ghostty.

```bash
st
```

Le fichier Ghostty attendu est
`$XDG_CONFIG_HOME/ghostty/config.ghostty` (ou `~/.config/ghostty/config.ghostty`).

### `docker-stop-all`

Arrête tous les conteneurs Docker actuellement en cours d'exécution.

```bash
docker-stop-all
```

## Vérification

Après une modification, vérifiez la syntaxe des scripts concernés :

```bash
bash -n cgo uptime-check ssh-list st docker-stop-all
```
