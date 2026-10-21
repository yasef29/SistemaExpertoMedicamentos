# Sistema Experto de Medicamentos

## 1. Descripción del proyecto

Sistema experto desarrollado en Prolog para la materia de Paradigmas de Programación de la Escuela Superior de Cómputo (ESCOM), Instituto Politécnico Nacional.

El sistema utiliza una base de conocimientos y reglas lógicas para generar orientaciones relacionadas con la consulta de medicamentos. Cuenta con una interfaz web que permite ingresar el nombre de un medicamento y visualizar el resultado obtenido por el motor de inferencia Prolog.

## 2. Objetivo

Aplicar los conceptos de programación lógica, hechos, reglas, predicados, unificación e inferencia mediante un sistema experto accesible desde una interfaz web.

## 3. Tecnologías utilizadas

- SWI-Prolog: base de conocimientos, reglas e inferencia lógica.
- HTML y JavaScript: interfaz web.
- Servidor HTTP de SWI-Prolog: comunicación entre la interfaz y el motor lógico.
- Docker: empaquetado de la aplicación.
- Git y GitHub: control de versiones y alojamiento del código fuente.
- Render: despliegue público de la aplicación.

## 4. Enlaces del proyecto

- Aplicación web: https://sistemaexpertomedicamentos.onrender.com/index.html
- Repositorio de GitHub: https://github.com/yasef29/SistemaExpertoMedicamentos

## 5. Estructura del proyecto

```text
SistemaExpertoMedicamentos/
├── Dockerfile
├── .gitignore
├── README.md
├── prolog/
│   ├── conocimiento.pl
│   └── servidor.pl
├── web/
│   └── index.html
└── documentacion/
```

## 6. Requisitos para ejecutar localmente

- SWI-Prolog instalado.
- Git, si se desea clonar el repositorio.
- Un navegador web actualizado.

## 7. Instalación y ejecución local

1. Clonar el repositorio:

   ```bash
   git clone https://github.com/yasef29/SistemaExpertoMedicamentos.git
   ```

2. Entrar a la carpeta del proyecto:

   ```bash
   cd SistemaExpertoMedicamentos
   ```

3. Iniciar el servidor con SWI-Prolog desde la carpeta principal.

   En PowerShell, si SWI-Prolog está instalado en la ruta utilizada durante el desarrollo:

   ```powershell
   & "C:\Program Files\swipl\bin\swipl.exe" -s ".\prolog\servidor.pl"
   ```

4. Abrir en el navegador:

   http://localhost:8080/index.html

5. Mantener abierta la terminal mientras se utiliza la aplicación. Para detener el servidor, presionar `Ctrl + C`.

## 8. Funcionamiento

1. El usuario ingresa el nombre de un medicamento en la interfaz.
2. La página envía una solicitud al servidor Prolog.
3. Prolog consulta la base de conocimientos y aplica las reglas correspondientes.
4. El servidor devuelve el resultado.
5. La interfaz muestra la orientación obtenida.

El endpoint utilizado para realizar consultas es:

```text
/api/consultar?medicamento=aspirina
```

## 9. Pruebas

Durante el desarrollo se realizaron consultas directas en Prolog y pruebas desde la interfaz web. Se verificaron distintos medicamentos, incluyendo aspirina, paracetamol, ibuprofeno, metformina e insulina.

También se probó la consulta de un medicamento inexistente y el funcionamiento de la aplicación desplegada públicamente.

Los casos de prueba detallados, sus resultados esperados y los resultados obtenidos deben consultarse en el documento de pruebas del proyecto.

## 10. Despliegue

La aplicación se publica en Render mediante un contenedor Docker que utiliza la imagen de SWI-Prolog.

El servidor utiliza el puerto asignado por la plataforma en producción y el puerto 8080 para la ejecución local.

Para actualizar la aplicación, se deben subir los cambios al repositorio de GitHub y comprobar el resultado del nuevo despliegue en Render.

## 11. Consideraciones

Este proyecto tiene fines académicos y demostrativos. Las orientaciones generadas no representan una prescripción médica, no verifican existencias reales de medicamentos y no sustituyen la valoración de un profesional de la salud.

## 12. Uso de herramientas de inteligencia artificial

Se utilizó ChatGPT como apoyo durante el desarrollo para resolver dudas técnicas, configurar Git y GitHub, integrar la interfaz web con el servidor Prolog, preparar Docker y realizar el despliegue en Render.

La participación concreta de las herramientas de IA debe declararse de acuerdo con las actividades realizadas durante el proyecto.

## 13. Autoría

Proyecto académico de la materia de Paradigmas de Programación, ESCOM, Instituto Politécnico Nacional.
