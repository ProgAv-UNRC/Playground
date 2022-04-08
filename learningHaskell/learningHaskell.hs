{-
# Demo sobre Haskell
En este archivo se van a mostrar algunos ejemplos de los temas que se fueron viendo.

Para cargar este archivo en el interprete de _GHC_, deben abrir una terminal en la carpeta donde está el mismo y ejecutar:

```
ghci
:l learningHaskell.hs
```

Pueden listar todas las definiciones en este archivo ejecutando `:browse` dentro del interprete.

_nota: los `` en los comentarios es para denotar código, no tiene que ver con el uso en Haskell para utilizar una función en forma infija_
-}

{-
## Convenciones sobre nombres

En Haskell, los nombres de funciones, constantes (funciones sin argumentos), argumentos y definiciones internas, y tipos genéricos, se escriben en _camelCase_.

La convención _camelCase_ determina que los nombres comienzan en minúsculas y palabras subsecuentes se escriben con la primera letra en mayúscula.

Los nombres de tipos no genéricos y clases se escriben en _PascalCase_.

La convención _PascalCase_ determina que los nombres comienzan en mayúsculas y palabras subsecuentes se escriben con la primera letra en mayúscula.

Por ejemplo, escribir `varias palabras para un nombre` en _camelCase_ resulta en `variasPalabrasParaUnNombre` y en `VariasPalabrasParaUnNombre` utilizando _PascalCase_

-}


{-
## Tipos básicos, listas, tuplas, y operadores básicos

Algunos tipos básicos en Haskel son: enteros (`Int`); booleanos (`Bool`); caractéres (`Char`); cadenas (`String`). Además están las listas, el tipo de una lista es `[TIPO]` (ej.: `[Int]` para una lista de enteros).
Y las tuplas de 2 a 15 elementos (ej.: `(1,2)` es una tupla con un 1 como primer elemento, y un 2 como segundo elemento), un detalle importante de las tuplas es que su tamaño no puede variar, no es posible agregar un elemento más a una tupla de 2 elementos.

Algunos operadores y funciones básicas son:

 1. Operaciones aritméticas `+, -, *, /, mod, div, ^`, definiendo la suma, resta, multiplicación, división, división entera, resto, exponente (la división resulta en un real, y si se está trabajando con enteros es mucho mejor usar la división entera para no tener problemas).
 2. Operaciones booleanas `not, &&, ||`, definiendo la negación, la conjunción, y la disyunción. Las operaciones de conjunción y disyunción funcionan evaluando el primer argumento y solo evaluando el segundo si es necesario (ej.: `True || x` no evalúa a `x`).
 3. Operaciones de listas `[], [elementos separados por coma], :`, definiendo la lista vacía, una lista formada por elementos específicos (e.j.: `[1,2,3]`), la inserción a la cabeza de un elemento y otra lista.
 4. Operaciones de tuplas `(elementos separados por coma)`, definiendo una tupla con los elementos correspondientes (e.j.: `(1,2,3)`).

-}

{-
## Definiendo funciones

El formato general para definir el perfil de una función es

`nombre :: restricciones => argumentos y retorno`

Donde `restricciones =>` es opcional y define restricciones sobre los tipos usados como argumentos y retorno.

Por ejemplo: `existe :: (Eq a) => [a] -> a -> Bool`, es una función que toma una lista de elementos (de un tipo genérico `a`), un elemento del mismo tipo, y retorna si el elemento existe o no en la lista.
para esto define una restricción sobre el tipo a: el tipo a que se utilice debe permitir el uso de la función (==) y (/=).

En la parte de los _argumentos y retorno_ se pueden utilizar paréntesis para determinar que uno de los argumentos o el retorno debe tener un perfil particular.
Por ejemplo: `filtrar :: [a] -> (a -> Bool) -> [a]`, es una función donde el primer argumento es una lista de elementos de tipo `a`, el segundo es un argumento con el perfil `a -> Bool`, es decir una función que toma un elemento
de tipo `a` y retorna `True` o `False`, y el resultado es una lista de elementos de tipo `a`.
Esta función retorna una lista con todos los elementos en la lista original tal que la función asociada al segundo argumento retorna `True`.


-}

{-
sumar es una función que toma dos enteros y retorna un entero con la suma
-}
--CODE
sumar :: Int -> Int -> Int
sumar a b = a + b -- a y b son nombres asociados a los argumentos
--CODE

{-
Una constante es una función que no toma argumentos
-}
--CODE
cero :: Int
cero = 0
--CODE

{-
Es posible utilizar guardas para que el resultado de una función dependa de una o más condiciones.
Por ejemplo, calcular el valor absoluto se puede resolver mediante guardas
-}
--CODE
absoluto :: Int -> Int
absoluto n | n < 0 = n*(-1)
           | otherwise = n -- otherwise es similar a un else, acá se podría haber usado n >= 0 como condición
--CODE
     
{-
Determinar si un elemento pertenece a una lista se puede hacer con múltiples guardas.
-}
--CODE
perteneceSoloGuardas :: [Int] -> Int -> Bool
perteneceSoloGuardas elementos elemento | null elementos = False -- la lista está vacía, null es una función que retorna True sii una lista está vacía
                             | (head elementos) == elemento = True -- head es una función que retorna el primer elemento en una lista no vácia
                             | otherwise = perteneceSoloGuardas (tail elementos) elemento -- tail es una función que retorna todos los elementos de una lista menos el primero (ej.: tail [1,2,3] retorna [2,3])
--CODE

{-
## Pattern matching

En muchos casos es posible utilizar patrones en lugar, o en combinación, con guardas.

En una función es posible tener múltiples definiciones, en cada definición los nombres de los argumentos pueden contener patrones.
Estos patrones se van a evaluar de _arriba para abajo_, cuando se encuentra una definición donde todos los patrones se corresponden con los valores de los argumentos, se utiliza esa definición.

Los patrones utilizan constructores de los valores asociados a los argumentos.
Por ejemplo, las listas en Haskell tienen 3 constructores: `[]` para listas vacías; `(x:xs)` para listas con un elemento seguido de una lista; y `[elementos separados por coma]` para una lista con una cantidad específica de elementos (ej.: `[1,2,3]` o `[x,y,z]`).

Es posible nombrar uno o más de los argumentos con `_`, significando _existe un argumento en esta posición, pero no me interesa darle un nombre_.

Para números, cada número es su propio constructor, por ejemplo `0` se puede utilizar en un patrón.

-}

{-
Determinar si un elemento pertenece a una lista, utilizando solo patrones.
-}
--CODE
perteneceSoloPatrones :: [Int] -> Int -> Bool
perteneceSoloPatrones [] _ = False -- en una lista vacía, el elemento seguro no pertenece a la misma
perteneceSoloPatrones [x] elem = x == elem -- en una lista con un solo elemento, el elemento existe si este es igual al único elemento en la lista
perteneceSoloPatrones (x:xs) elem = (perteneceSoloPatrones [x] elem) || (perteneceSoloPatrones xs elem) -- se busca el elemento en la lista unitaria con x, y se busca recursivamente en el resto de la lista
--CODE

{-
Determinar si un elemento pertenece a una lista, utilizando patrones y guardas.
-}
--CODE
pertenece :: [Int] -> Int -> Bool
pertenece [] _ = False
pertenece (x:xs) elem | x == elem = True
                      | otherwise = pertenece xs elem
--CODE

{-
Determinar si un número es cero utilizando patrones
-}
--CODE
esCero :: Int -> Bool
esCero 0 = True
esCero _ = False -- es importante notar el orden, si esta definición estuviera primero, la función retornaría siempre False
--CODE

{-
##Listas por comprensión

Es posible construír una lista a partir de una función o valor generador y un conjunto de propiedades de los elementos.

La forma básica para construir listas por comprensión es: `[ expresión conteniendo uno o más nombres | generación de valores para los nombres en la expresión, condiciones]`.

A continuación veremos algunos ejemplos de listas por comprensión.

-}

{-
Una lista con los valores 1, 2, y 3
-}
--CODE
unoDosTres :: [Int]
unoDosTres = [ x | x <- [1,2,3]] -- la expresión es solo un nombre (x), y los valores que toma x vienen de la lista [1,2,3]
--CODE

{-
Una lista con los números pares del 1 al 10
-}
--CODE
paresDelUnoAlDiez :: [Int]
paresDelUnoAlDiez = [ x | x <- [1..10], x `mod` 2 == 0] -- La lista [1..10] define una lista que va del 1 al 10; y `mod` permite utilizar la función mod de manera infija.
--CODE

{-
Una lista cuyos valores son el triple de los valores de otra lista
-}
--CODE
triplicarDelUnoAlDiez :: [Int]
triplicarDelUnoAlDiez = [ x * 3 | x <- [1..10]]
--CODE

{-
Una función que dada una lista y una función unaria, ambas sobre enteros, retorna una lista donde se aplicó la función a cada elemento de la original.
Esta función es una ejemplo de función de alto orden, uno de sus parámetros es una función.
-}
--CODE
aplicarFuncionUnariaAEnteros :: [Int] -> (Int -> Int) -> [Int]
aplicarFuncionUnariaAEnteros lista fun = [ (fun x) | x <- lista]
--CODE

{-
## Definiciones locales

Muchas veces dentro de la definición de una función podemos tener expresiones repetidas o de cierta complejidad que hacen al código menos legible.
Haskell ofrece el uso de `where` dentro de la definición de una función para dar definiciones locales.

Es posible definir funciones dentro del `where`, en general estas no van a tener un perfil asociado pero es posible permitir la definición de funciones
completas (que incluyan un perfil) mediante argumentos al llamar al intérprete o el uso de pragmas (algo que escapa a lo que se va a ver en la materia).

A continuación se muestran algunos ejemplos.
-}

{-
Dada una lista de enteros, ordenada de manera ascendiente, y un entero, la función retorna True sii el elemento existe.
La búsqueda del elemento se hace mediante búsqueda dicotómica.
-}
--CODE
existeEntero :: [Int] -> Int -> Bool
existeEntero [] _ = False -- En una lista vacía no importa el valor a buscar, seguro no existe en la lista.
existeEntero [x] elem = x == elem -- Este caso base es para poder asumir en el caso recursivo que la lista tiene al menos dos elementos
existeEntero lista elem | elem == primeroDeLaDerecha = True
                        | elem > primeroDeLaDerecha = existeEntero mitadDerecha elem -- se sigue la búsqueda en la mitad derecha de la lista
                        | otherwise = existeEntero mitadIzquierda elem -- elem es menor al primero de la parte derecha, se sigue la búsqueda en la parte izquierda
                        where longLista = length lista -- lenght retorna la longitud de una lista
                              longMitad = longLista `div` 2 -- div es la división entera
                              mitadIzquierda = take longMitad lista -- la mitad izquierda son los primero longMitad elementos de la lista original
                              mitadDerecha = drop longMitad lista -- la mitad derecha es el resultado de tirar los primeros longMitad elementos de la lista original
                              primeroDeLaDerecha = head mitadDerecha -- por las guardas que usamos, estamos seguros que ambas mitades tienen al menos un elemento
--CODE

{-
## Funciones de alto orden

Una función que toma otra función como uno de sus argumentos se denomina _Función de Alto orden_.

En Haskell se utilizan paréntesis para determinar que una parte del perfil corresponde a un argumento, por ejemplo:

`foo :: Int -> Int -> Int` puede llamarse con `foo 1` lo que genera una función con el perfil `Int -> Int`, o como `foo 1 2` lo que genera una función (o una constante en este caso) con el perfil `Int`.

No es posible llamar a `foo` con una función `bar :: Int -> Int` como primer argumento.

En cambio, la definición `foo :: (Int -> Int) -> Int` requiere que el primer argumento sea una función con el perfil `Int -> Int`, y no es posible llamar `foo 1` para obtener una función con el perfil `Int -> Int`.

A continuación veremos algunos ejemplos.
-}

{-
Dadas dos funciones, una que permite filtrar enteros que cumplen una condición, y una que permite modificar un entero, y una lista de enteros,
se retornan todos los elementos que satisfacen la propiedad con la modificación realizada por la segunda función.
-}
--CODE
filtrarYModificar :: (Int -> Bool) -> (Int -> Int) -> [Int] -> [Int]
filtrarYModificar _ _ [] = [] -- para una lista vacía, las funciones no importan y se retorna una lista vacía
filtrarYModificar prop modif (x:xs) | prop x = (modif x) : (filtrarYModificar prop modif xs) -- es posible escribir esta función mediante listas por comprensión, intente resolverlo de esa forma
                                    | otherwise = filtrarYModificar prop modif xs
--CODE

{-
Esta función censura palabras (String) en una sentencia ([String]), y las reemplaza por una palabra (String).
Para determinar que palabras censurar, el primer argumento es una función que dada una palabra (String) determina si censurarla (True) o no (False).
_nota: utilice la función censor definida más abajo como argumento de esta función._
_nota: la función `words` transforma una cadena (String) en una lista de cadenas ([String]) separando palabras mediante espacios._
_nota: la función `unwords` transforma un lista de cadenas ([String]) en una cadena (String) concatenando cada palabra en la lista mediante espacios._
-}
--CODE
censurar :: (String -> Bool) -> String -> [String] -> [String]
censurar _ _ [] = [] -- En una sentencia vacía no hay nada para censurar
censurar censor reemplazo (palabra:sentencia) | censor palabra = reemplazo : (censurar censor reemplazo sentencia) -- podría resolver esta función mediante listas por comprensión?
                                              | otherwise = palabra : (censurar censor reemplazo sentencia)
--CODE

{-
Una función que dada una lista de palabras ([String]) y una palabra (String) retorna si la palabra pertenece a la lista de palabras a censurar.
-}
--CODE
censor :: [String] -> String -> Bool
censor palabrasCensuradas palabra = elem palabra palabrasCensuradas
--CODE

{-
## Tipos genéricos como argumentos y restricciones de tipo

Hasta ahora todas las funciones están definidas sobre tipos específicos (Int, Bool, String, y listas de estos). Muchas veces es deseable definir funciones más genericas.

Si quisieramos obtener el i-ésimo elemento de una lista, no importa de que tipo sea la lista. Si queremos buscar un elemento en una lista, solo nos interesa que los elementos en esa lista y el elemento a buscar, sean comparables entre sí.

Haskell permite utilizar tipos genéricos en los perfiles de las funciones mediante el uso de nombres que empiezan con mínuscula, por ejemplo `a` en lugar de `Int`. Utilizar un nombre en lugar de un tipo particular, es equivalente a decir que
_"se espera un valor de cualquier tipo"_. Veamos un ejemplo:

```
agregarAlFinal -> [a] -> a -> [a]
agregarAlFinal [] elem = [elem]
agregarAlFinal (x:xs) elem = x : (agregarAlFinal xs elem)
```

Para esta función, no importa el tipo particular de los argumentos, pero si importa que todos los argumentos sean del mismo tipo o involucren al mismo tipo.

```
:t agregarAlFinal
agregarAlFinal :: [a] -> a -> [a]
:t agregarAlFinal "Hola Mund"
agregarAlFinal :: Char -> [Char]
```

Al pasar como primer argumento `"Hola Mund"` (tipo `[Char]`), Haskell infiere que `a` es de tipo `Char`.

A su vez, como mencionamos anteriormente, hay situaciones en donde aceptar cualquier tipo no sirve, como por ejemplo determinar que un elemento existe en una lista, en estos casos podemos agregar restricciones:

```
existe :: (Eq a) => [a] -> a -> Bool
existe [] _ = False
existe (x:xs) elem = x == elem || existe xs elem -- la evaluación de la disyunción asegura que solo se realiza la llamada recursiva si `x == elem` es falso.
```

En este ejemplo se restringe el tipo `a` a cualquier tipo para el cual se pueda aplicar la función de igualdad `(==)`.

A continuación se muestran algunos ejemplos.

-}

{-
Esta función obtiene el i-ésimo elemento en una lista.

_precondición: el índice del elemento a obtener debe estar entre 0 y la longitud de la lista - 1._
-}
--CODE
nth :: [a] -> Int -> a
nth (x:_) 0 = x
nth (x:xs) n = nth xs (n - 1)
--CODE

{-
Esta función permite obtener todos los elementos que sean iguales a uno buscado, determinando un límite a los elementos a retornar.
-}
--CODE
buscarN :: (Eq a) => [a] -> a -> Int -> [a]
buscarN [] _ _ = []
buscarN _ _ 0 = []
buscarN (x:xs) elem n | elem == x = x : (buscarN xs elem (n - 1))
                      | otherwise = buscarN xs elem n
--CODE

{-
Función que implementa el Algoritmo de BubbleSort.
-}
--CODE
bubblesort :: (Ord a) => [a] -> [a]
bubblesort [] = []
bubblesort [x] = [x]
bubblesort xs | modificada = bubblesort listaBurbujeada
              | otherwise = listaBurbujeada
           where (listaBurbujeada, modificada) = burbujear xs
--CODE

{-
Función que ordena de menor a mayor, pero solo mirando elementos de a dos y haciendo un solo recorrido.

La función retorna una tupla con la lista resultante y un booleando indicando si se hizo algún cambio con respecto a la lista original.
-}
--CODE
burbujear :: (Ord a) => [a] -> ([a], Bool)
burbujear [] = ([], False)
burbujear [x] = ([x], False)
burbujear (x:(y:xs)) = ((minVal:resto), (cambio || minVal /= x))
                   where minVal = minimo x y
                         maxVal = maximo x y
                         (resto, cambio) = burbujear (maxVal:xs)
--CODE
      
{-
Función que retorna el mínimo de dos valores.
-}  
--CODE             
minimo :: (Ord a) => a -> a -> a
minimo x y | x > y = y
           | otherwise = x
--CODE

{-
Función que retorna el máximos de dos valores.
-}  
--CODE
maximo :: (Ord a) => a -> a -> a
maximo x y | x > y = x
           | otherwise = y
--CODE
