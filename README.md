# IIC2513 — Tecnologías y Aplicaciones Web

## GRUPO 12 - Proyecto Semestral

### Integrantes

Nombre             | GitHub          | Email
------------------ | --------------- | ---------------------
Vicente Fuenzalida | [@vjfuenzalida] | [vjfuenzalida@uc.cl]
Juan Pablo Jofré   | [@jpjofre94]    | [jbjofre@uc.cl]

### Aplicación en Heroku

Visita nuestra aplicación [aquí](https://grupo-12.herokuapp.com/).

### Versiones de Software

|          | Versión |
|:--------:|:-------:|
|     Ruby |  2.4.0  |
|    Rails |  5.0.2  |
| Postgres |  9.6.2  |

## Cómo probar la aplicación?

* Clonar el repositorio

* Instalar las gemas necesarias
```
$ bundle install
```

* Crear la base de datos (es necesario tener Postgres instalado)
```
$ rails db:drop
$ rails db:create
```

* Ejectuar las migraciones
```
$ rails db:migrate
```

* Incluir seed data (generada automáticamente)
```
$ rails db:seed
```

* Iniciar el servidor
```
$ rails server
```


[@vjfuenzalida]:      https://github.com/vjfuenzalida
[@jpjofre94]: 		  https://github.com/jpjofre94

[vjfuenzalida@uc.cl]: mailto:vjfuenzalida@uc.cl
[jbjofre@uc.cl]:      mailto:jbjofre@uc.cl
