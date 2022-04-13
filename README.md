# Playground
Repositorio público de la materia Avanzada para Analista/Licenciatura/Profesorado en Computación (UNRC).

Este README ofrece información básica para las herramientas que vamos a utilizar, para más información contamos con una [Wiki](https://github.com/ProgAv-UNRC/Playground/wiki).

## Herramientas a utilizar

Se va a utilizar GHC para Haskell, y Haddock para combinar escritura de documentación con código Haskell. Haddock viene en general junto con la instalación de GHC.
A su vez vamos a usar [git](https://git-scm.com) como sistema de versionado, [GitHub](https://github.com/) para guardar los repositorios remotos, y [OpenSSH](https://www.openssh.com/) opcionalmente si desean generar y/o utilizar claves ssh para manejar el control de acceso entre git y GitHub.

En la segunda mitad de la materia (aproximadamente), vamos a utilizar un lenguaje llamado [Dafny](https://www.microsoft.com/en-us/research/project/dafny-a-language-and-program-verifier-for-functional-correctness/) que no solo permite escribir programas imperatívos sino también permite escribir especificaciones para los mismos, ofreciendo un SMT-Solver para verificar de manera automática que el programa es correcto con respecto a las especificaciones.

## Estructura de proyectos en Haskell

Se va a tratar, siempre que sea posible, de usar [Haddock](https://hackage.haskell.org/package/haddock) con un archivo `.lhs` para representar una práctica particular e importar archivos `.hs` que resuelvan los ejercicios particulares. La estructura de archivos que vamos a utilizar va a ser la siguiente, está basada en la [sugerida en wiki de Haskell](https://wiki.haskell.org/Structure_of_a_Haskell_project).


- carpeta principal del proyecto
  - src/
    - Main.lhs (programa principal, documenta la práctica a la vez que ofrece las funcionalidades requeridas de los distintos ejercicios)
  - App/ (módulos)
  - [doc/] (opcional, la documentación va acá)

### GHC instalación

Para instalar GHC se tienen las siguientes opciones:

Si solo quieren instalar GHC (junto al intérprete GHCi) pueden ir a la siguiente [página](https://www.haskell.org/ghc/download.html), buscar la última versión estable y buscar los binarios correspondientes a su OS.

Aunque en la materia alcanza con solo GHC, si quieren instalar GHC junto a otras herramientas que pueden ser útiles como cabal, pueden ir a la siguiente [página](https://www.haskell.org/downloads/).

## Estructura de proyectos en Dafny
__TODO__

## Dafny instalación
__TODO__
