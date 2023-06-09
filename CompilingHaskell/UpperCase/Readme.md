## Un simple ejemplo de uso del compilador de ghc

# El ejemplo tiene dos archivos: Aux.hs y Main.hs

	- Main.hs: contiene la función principal en donde se llama a las funciones en Aux.hs
	- Aux.hs: contiene las funciones auxiliares, transformar en mayusculas, etc

# Compilando el ejemplo:

Se puede compilar con: *ghc --make Main.hs* en este caso el compilador produce el codigo objeto y linkea

Otra opción es compilar por separado y despues compilar, esto se hace con los siguientes comandos:

	*ghc -c Main.hs* se compila Main.hs a cdigo objeto
	*ghc -c Aux.hs*  de compila Aux.hs a codigo objeto
	*ghc -o main Main.o Aux.o* se linkean los dos archivos 
