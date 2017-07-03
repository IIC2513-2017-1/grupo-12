# IIC2513 — Tecnologías y Aplicaciones Web

## GRUPO 12 - Proyecto Semestral

## *Dreamfunder*

### Integrantes

Nombre             | GitHub          | Email
------------------ | --------------- | ---------------------
Vicente Fuenzalida | [@vjfuenzalida] | [vjfuenzalida@uc.cl]
Juan Pablo Jofré   | [@jpjofre94]    | [jbjofre@uc.cl]

## Aplicación en Heroku

Visita nuestra aplicación [aquí](https://dreamfunder.herokuapp.com/).

Puedes crear tu propia cuenta, o probar las funcionalidades con la siguiente cuenta:

|      Correo       |  Contraseña  |
|:-----------------:|:------------:|
|  mail-1@mail.com  |    123123    |

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

## Cómo probar la API?

#### Projects
* GET /api/v1/projects -> Muestra todos los proyectos
* GET /api/v1/projects/:id -> Muestra proyecto con id :id
* POST /api/v1/projects -> Crea un nuevo proyecto (Requiere token)


&nbsp;
Parámetros *create*:


&nbsp;
{


&nbsp;
"category_ids": [arreglo con id's de categorias]


&nbsp;
"brief": *text*


&nbsp;
"description": *text*


&nbsp;
"funding_goal": *integer*


&nbsp;
"funding_duration": *date*


&nbsp;}

#### Users
* GET /api/v1/users/:id -> Muestra perfil de un usuario particular.

#### Follow project
* POST /api/v1/projects/:id/save -> Sigue el proyecto de con id :id (Requiere token)
* DELETE /api/v1/projects/:id/forget -> Deja de seguir el proyecto de con id :id (Requiere token)

#### Donations
* POST /api/v1/donations -> Realiza una donacion en un proyecto particular. (Requiere token)


&nbsp;
Parámetros *create*:


&nbsp;
{


&nbsp;
"amount": *integer*


&nbsp;
"project_id": *index*


&nbsp;
}

#### Comments
* POST /api/v1/comments -> Realiza un comentario en un proyecto particular. (Requiere token)


&nbsp;
Parámetros *create*:


&nbsp;
{


&nbsp;
"content": *text*


&nbsp;
"project_id": *index*


&nbsp;
}




[@vjfuenzalida]:      https://github.com/vjfuenzalida
[@jpjofre94]: 		  https://github.com/jpjofre94

[vjfuenzalida@uc.cl]: mailto:vjfuenzalida@uc.cl
[jbjofre@uc.cl]:      mailto:jbjofre@uc.cl
