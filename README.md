# Redis RPM Builder Image

## Prepare specs and sources

Place **SPECS** and **SOURCES** subdirectories into cloned repo directory:

```
redisrpm/
├── ...
├── SOURCES
├── SPECS
├── Makefile
├── redisrpm.Dockerfile
└── ...
```

## Launch build

```
make
```

## Get packages

```
redisrpm/
├── ...
├── RPMS/x86_64..
└── ...
```