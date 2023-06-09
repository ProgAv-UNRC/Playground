## Compilando Haskell
# Con esta actividad mostraremos como se puede compilar Haskell con gh

En el archivo helloWorld.hs tenemos un programa simple que imprime *hello world* en la pantalla:

> main = putStrLn "Hello World"

el perfil de la función *putStrLn::String -> IO()* el tipo *IO()* se utiliza para decir que la función devuelve una acción de I/O.

Para compilar un programa debemos tener un archivo conteniendo la función *main* si este archivo importa otras librerias serán encontradas
por ghc.

Para compilar el archivo debemos hacer: *ghc main.hs*, esto va a generar los siguientes archivos:

	- *main.o*, el codigo objeto que corresponde al programa este puede ser usado por el linker para producir el programa final
	- *main.hi*, es una interface (estilo .h en c) que es usada para linkear modulos

ghc tiene diversas opciones, por ejemplo on ghc -S podemos generar el assembler:
 
  
