# Photo-sorter

Set of scripts to organize my photo pile of shame

## Getting Started

### With docker/podman

in `docker-compose.yml` uncomment and change:

```yaml
#      - /PATH/TO/UNSORTED/PICTURES:/mnt/source
#      - /PATH/TO/SORTED/PICTURES:/mnt/destination
```

eg:

```yaml
      - /mnt/sdcard:/mnt/source
      - /mnt/my-photos:/mnt/destination
```

then run `podman-compose up`

photos found in the source directory `/mnt/sdcard` will be copied and reorganised to the destination directory `/mnt/my-photos`


### Without docker/podman

edit `run.sh` and modify the following with your directories (accepting these as args is on the [todo list](https://github.com/scawp/photo-sorter/issues/11)):

```bash
source_dir="/mnt/source/"
destintion_dir="/mnt/destination/"
```
