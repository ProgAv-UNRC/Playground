
# Demo sobre Haskell
En este archivo se van a mostrar algunos ejemplos de los temas que se fueron viendo.

Para cargar este archivo en el interprete de _GHC_, deben abrir una terminal en la carpeta donde está el mismo y ejecutar:

```
ghci
:l learningHaskell.hs
```

Pueden listar todas las definiciones en este archivo ejecutando `:browse` dentro del interprete.

_nota: los `` en los comentarios es para denotar código, no tiene que ver con el uso en Haskell para utilizar una función en forma infija_



## Convenciones sobre nombres

En Haskell, los nombres de funciones, constantes (funciones sin argumentos), argumentos y definiciones internas, y tipos genéricos, se escriben en _camelCase_.

La convención _camelCase_ determina que los nombres comienzan en minúsculas y palabras subsecuentes se escriben con la primera letra en mayúscula.

Los nombres de tipos no genéricos y clases se escriben en _PascalCase_.

La convención _PascalCase_ determina que los nombres comienzan en mayúsculas y palabras subsecuentes se escriben con la primera letra en mayúscula.

Por ejemplo, escribir `varias palabras para un nombre` en _camelCase_ resulta en `variasPalabrasParaUnNombre` y en `VariasPalabrasParaUnNombre` utilizando _PascalCase_





## Tipos básicos, listas, tuplas, y operadores básicos

Algunos tipos básicos en Haskel son: enteros (`Int`); booleanos (`Bool`); caractéres (`Char`); cadenas (`String`). Además están las listas, el tipo de una lista es `[TIPO]` (ej.: `[Int]` para una lista de enteros).
Y las tuplas de 2 a 15 elementos (ej.: `(1,2)` es una tupla con un 1 como primer elemento, y un 2 como segundo elemento), un detalle importante de las tuplas es que su tamaño no puede variar, no es posible agregar un elemento más a una tupla de 2 elementos.

Algunos operadores y funciones básicas son:

 1. Operaciones aritméticas `+, -, *, /, mod, div, ^`, definiendo la suma, resta, multiplicación, división, división entera, resto, exponente (la división resulta en un real, y si se está trabajando con enteros es mucho mejor usar la división entera para no tener problemas).
 2. Operaciones booleanas `not, &&, ||`, definiendo la negación, la conjunción, y la disyunción. Las operaciones de conjunción y disyunción funcionan evaluando el primer argumento y solo evaluando el segundo si es necesario (ej.: `True || x` no evalúa a `x`).
 3. Operaciones de listas `[], [elementos separados por coma], :`, definiendo la lista vacía, una lista formada por elementos específicos (e.j.: `[1,2,3]`), la inserción a la cabeza de un elemento y otra lista.
 4. Operaciones de tuplas `(elementos separados por coma)`, definiendo una tupla con los elementos correspondientes (e.j.: `(1,2,3)`).




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





sumar es una función que toma dos enteros y retorna un entero con la suma

```
sumar :: Int -> Int -> Int
sumar a b = a + b -- a y b son nombres asociados a los argumentos
```


Una constante es una función que no toma argumentos

```
cero :: Int
cero = 0
```


Es posible utilizar guardas para que el resultado de una función dependa de una o más condiciones.
Por ejemplo, calcular el valor absoluto se puede resolver mediante guardas

```
absoluto :: Int -> Int
absoluto n | n < 0 = n*(-1)
           | otherwise = n -- otherwise es similar a un else, acá se podría haber usado n >= 0 como condición
```
     

Determinar si un elemento pertenece a una lista se puede hacer con múltiples guardas.

```
perteneceSoloGuardas :: [Int] -> Int -> Bool
perteneceSoloGuardas elementos elemento | null elementos = False -- la lista está vacía, null es una función que retorna True sii una lista está vacía
                             | (head elementos) == elemento = True -- head es una función que retorna el primer elemento en una lista no vácia
                             | otherwise = perteneceSoloGuardas (tail elementos) elemento -- tail es una función que retorna todos los elementos de una lista menos el primero (ej.: tail [1,2,3] retorna [2,3])
```


## Pattern matching

En muchos casos es posible utilizar patrones en lugar, o en combinación, con guardas.

En una función es posible tener múltiples definiciones, en cada definición los nombres de los argumentos pueden contener patrones.
Estos patrones se van a evaluar de _arriba para abajo_, cuando se encuentra una definición donde todos los patrones se corresponden con los valores de los argumentos, se utiliza esa definición.

Los patrones utilizan constructores de los valores asociados a los argumentos.
Por ejemplo, las listas en Haskell tienen 3 constructores: `[]` para listas vacías; `(x:xs)` para listas con un elemento seguido de una lista; y `[elementos separados por coma]` para una lista con una cantidad específica de elementos (ej.: `[1,2,3]` o `[x,y,z]`).

Es posible nombrar uno o más de los argumentos con `_`, significando _existe un argumento en esta posición, pero no me interesa darle un nombre_.

Para números, cada número es su propio constructor, por ejemplo `0` se puede utilizar en un patrón.




Determinar si un elemento pertenece a una lista, utilizando solo patrones.

```
perteneceSoloPatrones :: [Int] -> Int -> Bool
perteneceSoloPatrones [] _ = False -- en una lista vacía, el elemento seguro no pertenece a la misma
perteneceSoloPatrones [x] elem = x == elem -- en una lista con un solo elemento, el elemento existe si este es igual al único elemento en la lista
perteneceSoloPatrones (x:xs) elem = (perteneceSoloPatrones [x] elem) || (perteneceSoloPatrones xs elem) -- se busca el elemento en la lista unitaria con x, y se busca recursivamente en el resto de la lista
```


Determinar si un elemento pertenece a una lista, utilizando patrones y guardas.

```
pertenece :: [Int] -> Int -> Bool
pertenece [] _ = False
pertenece (x:xs) elem | x == elem = True
                      | otherwise = pertenece xs elem
```


Determinar si un número es cero utilizando patrones

```
esCero :: Int -> Bool
esCero 0 = True
esCero _ = False -- es importante notar el orden, si esta definición estuviera primero, la función retornaría siempre False
```


##Listas por comprensión

Es posible construír una lista a partir de una función o valor generador y un conjunto de propiedades de los elementos.

La forma básica para construir listas por comprensión es: `[ expresión conteniendo uno o más nombres | generación de valores para los nombres en la expresión, condiciones]`.

A continuación veremos algunos ejemplos de listas por comprensión.




Una lista con los valores 1, 2, y 3

```
unoDosTres :: [Int]
unoDosTres = [ x | x <- [1,2,3]] -- la expresión es solo un nombre (x), y los valores que toma x vienen de la lista [1,2,3]
```


Una lista con los números pares del 1 al 10

```
paresDelUnoAlDiez :: [Int]
paresDelUnoAlDiez = [ x | x <- [1..10], x `mod` 2 == 0] -- La lista [1..10] define una lista que va del 1 al 10; y `mod` permite utilizar la función mod de manera infija.
```


Una lista cuyos valores son el triple de los valores de otra lista

```
triplicarDelUnoAlDiez :: [Int]
triplicarDelUnoAlDiez = [ x * 3 | x <- [1..10]]
```


Una función que dada una lista y una función unaria, ambas sobre enteros, retorna una lista donde se aplicó la función a cada elemento de la original.
Esta función es una ejemplo de función de alto orden, uno de sus parámetros es una función.

```
aplicarFuncionUnariaAEnteros :: [Int] -> (Int -> Int) -> [Int]
aplicarFuncionUnariaAEnteros lista fun = [ (fun x) | x <- lista]
```


## Definiciones locales

Muchas veces dentro de la definición de una función podemos tener expresiones repetidas o de cierta complejidad que hacen al código menos legible.
Haskell ofrece el uso de `where` dentro de la definición de una función para dar definiciones locales.

Es posible definir funciones dentro del `where`, en general estas no van a tener un perfil asociado pero es posible permitir la definición de funciones
completas (que incluyan un perfil) mediante argumentos al llamar al intérprete o el uso de pragmas (algo que escapa a lo que se va a ver en la materia).

A continuación se muestran algunos ejemplos.



Dada una lista de enteros, ordenada de manera ascendiente, y un entero, la función retorna True sii el elemento existe.
La búsqueda del elemento se hace mediante búsqueda dicotómica.

```
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
```


## Funciones de alto orden

Una función que toma otra función como uno de sus argumentos se denomina _Función de Alto orden_.

En Haskell se utilizan paréntesis para determinar que una parte del perfil corresponde a un argumento, por ejemplo:

`foo :: Int -> Int -> Int` puede llamarse con `foo 1` lo que genera una función con el perfil `Int -> Int`, o como `foo 1 2` lo que genera una función (o una constante en este caso) con el perfil `Int`.

No es posible llamar a `foo` con una función `bar :: Int -> Int` como primer argumento.

En cambio, la definición `foo :: (Int -> Int) -> Int` requiere que el primer argumento sea una función con el perfil `Int -> Int`, y no es posible llamar `foo 1` para obtener una función con el perfil `Int -> Int`.

A continuación veremos algunos ejemplos.



Dadas dos funciones, una que permite filtrar enteros que cumplen una condición, y una que permite modificar un entero, y una lista de enteros,
se retornan todos los elementos que satisfacen la propiedad con la modificación realizada por la segunda función.

```
filtrarYModificar :: (Int -> Bool) -> (Int -> Int) -> [Int] -> [Int]
filtrarYModificar _ _ [] = [] -- para una lista vacía, las funciones no importan y se retorna una lista vacía
filtrarYModificar prop modif (x:xs) | prop x = (modif x) : (filtrarYModificar prop modif xs) -- es posible escribir esta función mediante listas por comprensión, intente resolverlo de esa forma
                                    | otherwise = filtrarYModificar prop modif xs
```


Esta función censura palabras (String) en una sentencia ([String]), y las reemplaza por una palabra (String).
Para determinar que palabras censurar, el primer argumento es una función que dada una palabra (String) determina si censurarla (True) o no (False).
_nota: utilice la función censor definida más abajo como argumento de esta función._
_nota: la función `words` transforma una cadena (String) en una lista de cadenas ([String]) separando palabras mediante espacios._
_nota: la función `unwords` transforma un lista de cadenas ([String]) en una cadena (String) concatenando cada palabra en la lista mediante espacios._

```
censurar :: (String -> Bool) -> String -> [String] -> [String]
censurar _ _ [] = [] -- En una sentencia vacía no hay nada para censurar
censurar censor reemplazo (palabra:sentencia) | censor palabra = reemplazo : (censurar censor reemplazo sentencia) -- podría resolver esta función mediante listas por comprensión?
                                              | otherwise = palabra : (censurar censor reemplazo sentencia)
```


Una función que dada una lista de palabras ([String]) y una palabra (String) retorna si la palabra pertenece a la lista de palabras a censurar.

```
censor :: [String] -> String -> Bool
censor palabrasCensuradas palabra = elem palabra palabrasCensuradas
```


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




Esta función obtiene el i-ésimo elemento en una lista.

_precondición: el índice del elemento a obtener debe estar entre 0 y la longitud de la lista - 1._

```
nth :: [a] -> Int -> a
nth (x:_) 0 = x
nth (x:xs) n = nth xs (n - 1)
```


Esta función permite obtener todos los elementos que sean iguales a uno buscado, determinando un límite a los elementos a retornar.

```
buscarN :: (Eq a) => [a] -> a -> Int -> [a]
buscarN [] _ _ = []
buscarN _ _ 0 = []
buscarN (x:xs) elem n | elem == x = x : (buscarN xs elem (n - 1))
                      | otherwise = buscarN xs elem n
```


Función que implementa el Algoritmo de BubbleSort.

```
bubblesort :: (Ord a) => [a] -> [a]
bubblesort [] = []
bubblesort [x] = [x]
bubblesort xs | modificada = bubblesort listaBurbujeada
              | otherwise = listaBurbujeada
           where (listaBurbujeada, modificada) = burbujear xs
```


Función que ordena de menor a mayor, pero solo mirando elementos de a dos y haciendo un solo recorrido.

La función retorna una tupla con la lista resultante y un booleando indicando si se hizo algún cambio con respecto a la lista original.

```
burbujear :: (Ord a) => [a] -> ([a], Bool)
burbujear [] = ([], False)
burbujear [x] = ([x], False)
burbujear (x:(y:xs)) = ((minVal:resto), (cambio || minVal /= x))
                   where minVal = minimo x y
                         maxVal = maximo x y
                         (resto, cambio) = burbujear (maxVal:xs)
```
      

Función que retorna el mínimo de dos valores.
  
```             
minimo :: (Ord a) => a -> a -> a
minimo x y | x > y = y
           | otherwise = x
```


Función que retorna el máximos de dos valores.
  
```
maximo :: (Ord a) => a -> a -> a
maximo x y | x > y = x
           | otherwise = y
```


## Tipos

Hasta ahora hemos utilizados tipos ya definidos en Haskell. Estos permiten atacar una gran cantidad de problemas, de hecho sería posible atacar cualquier problema sin definir nuevos tipos.
Una persona podría definirse utilizando tuplas, por ejemplo `(84758475, "Bruce", "Wayne", 27/05/1939)`; un tipo que representa un resultado opcional puede definirse utilizando una lista (`[]` para _ningún resultado_, y `[r]` para _el resultado fue **r**_.
Sin embargo, esto haría el código más complejo (se requiere lógica extra para el manejo de los datos), y menos legible (no se entiende a simple vista que hace un código particular).

Por esto, definir tipos propios es indispensable. Haskell ofrece la siguiente gramática para definir un nuevo tipo:

```
TIPO -> data NOMBRE_T [VARIABLES] = CONSTRUCTORES deriving CLASES
    NOMBRE_T -> un nombre escrito en PascalCase comenzando con una letra
    VARIABLES -> NOMBRE_V [VARIABLES]
    NOMBRE_V -> un nombre escrito en camelCase comenzando con una letra
    CONSTRUCTORES -> CONSTRUCTOR [| CONSTRUCTORES]
    CONSTRUCTOR -> NOMBRE_T [PARAMETROS]
    PARAMETROS -> PARAMETROS_SIMPLES
    PARAMETROS -> PARAMETROS_CON_NOMBRE
    PARAMETROS_SIMPLES -> NOMBRE_T [PARAMETROS_SIMPLES]
    PARAMETROS_CON_NOMBRE -> {NOMBRE_V::NOMBRE_T[, PARAMETROS_CON_NOMBRE]}
    CLASES -> NOMBRE_T
    CLASES -> (NOMBRE_T[, CLASES])
```
_nota: palabras en mayúscula requieren ser expandidas usando otras reglas; palabras entre corchetes significa que son opcionales; pueden haber varias reglas de expansión para un nombre en mayúscula_

El _NOMBRE_T_ luego de `data` corresponde al nombre del nuevo tipo, por ejemplo _Lista_. Las _VARIABLES_ corresponden a variables de tipo para el tipo que definimos, por ejemplo `data Lista a = ...` significa _Listas de a_.
Los _CONSTRUCTORES_ son funciones que permiten la construcción de valores del nuevo tipo, por ejemplo `True` y `False` son constructores para valores del tipo `Bool` de Haskell.
Los parámetros de un constructor definen el tipo, cantidad, y orden de los argumentos que va a tomar cada uno de los constructores, por ejemplo el constructor de listas `:` toma __2__ argumentos, un elemento de tipo `a` y una lista de tipo `[a]`, en ese orden.
El uso de parámetros con nombre permite acceder a los componentes de un valor particular de un tipo, por ejemplo un constructor de un tipo _Lista_ `Cons {primero::a, resto::[a]}` permite acceder al primer elemento y al resto de la lista respectivamente sin necesidad
de utilizar _patter matching_, pero solo con valores construídos por el constructor _Cons_. El uso de parámetros con nombres en constructores también permite construir valores utilizando a los mismos, por ejemplo un valor de tipo _Lista_ puede ser construído como
`Cons 1 otraLista` o `Cons {primero = 1, resto = otraLista}`, en el segundo caso, el orden de los argumentos no importa por que se especifíca a que componente se le está asignando cada valor.
Finalmente, un tipo puede derivar clases, en términos simples una clase en Haskell define un conjunto de funciones que todo tipo que implemente esa clase va a tener. El uso del _deriving_ significa que se va a utilizar una definición por defecto de las funciones de una clase,
aunque no siempre existe esa definición por defecto. En la sección de __Tipos genéricos como argumentos y restricciones de tipo__ vimos el uso de `... (Eq a) => ...` como una restricción sobre el tipo genérico _a_ que indica _el tipo a debe soportar las operaciones de igualdad (==) y desigualdad (/=)_. _Eq_ es una clase que define las operaciones _==_ y _/=_, esta clase tiene una implementación por defecto que utiliza los constructores utilizados para la comparación de dos valores, por ejemplo `(Succ (Succ Zero)) == (Succ Zero)` compara los nombres de los operadores, primero comparando _Succ_ con _Succ_, y luego comparando _Succ_ con _Zero_, y retornando `False`.

A continuación se muestran algunos ejemplos.





Un tipo que define un valor booleano.

```
data Booleano = Verdadero | Falso deriving (Show, Eq)
```


Una función que traduce un valor booleano (Booleano) a un valor booleano de Haskell (Bool).

```
esVerdadero :: Booleano -> Bool
esVerdadero Verdadero = True
esVerdadero Falso = False
```


Un tipo que define una variable entera y define que el tipo Variable tiene asociadas las operaciones _==_ y _/=_ provenientes de _Eq_, y _show_ proveniente de _Show_ (esta última permite visualizar valores de este tipo por terminal).

```
data Variable = Variable {valor::Int} deriving (Show, Eq)
```


Una función que determina si el valor asociado a una variable (Variable) es positivo utilizando patrones.

```
variablePositivaPatrones :: Variable -> Bool
variablePositivaPatrones (Variable n) = n >= 0
```


Una función que determina si el valor asociado a una variable (Variable) es positivo utilizando constructores con argumentos con nombres.

```
variablePositivaParametrosConNombres :: Variable -> Bool
variablePositivaParametrosConNombres v = (valor v) >= 0
```

```
variable3EsPositiva :: Bool
variable3EsPositiva = variablePositivaParametrosConNombres (Variable 3)
```

```
variable5NegNoEsPositiva :: Bool
variable5NegNoEsPositiva = variablePositivaPatrones (Variable {valor = (-5)})
```


Un tipo que define listas de enteros

```
data ListaEntera = Vacia | Cons Int ListaEntera deriving (Show, Eq)
```

```
listaEnteraVacia :: ListaEntera
listaEnteraVacia = Vacia
```

```
listaEntera123 :: ListaEntera
listaEntera123 = Cons 1 (Cons 2 (Cons 3 Vacia))
--                      ^       ^       ^
--                      |       |       | La ListaEntera que toma el tecer Cons
--                      |       | La ListaEntera que toma el segundo Cons
--                      | La ListaEnera que toma el primer Cons
```


Una función que dadas dos listas enteras (ListaEntera) retorna la concatencación de la primera con la segunda.

```
concatenarListasEnteras :: ListaEntera -> ListaEntera -> ListaEntera
concatenarListasEnteras Vacia ys = ys
concatenarListasEnteras (Cons x xs) ys = Cons x (concatenarListasEnteras xs ys)
```


Una función que dada una lista entera (ListaEntera) retorna la reversa de la misma.

```
reversaListaEntera :: ListaEntera -> ListaEntera
reversaListaEntera Vacia = Vacia
reversaListaEntera (Cons x xs) = concatenarListasEnteras (reversaListaEntera xs) (Cons x Vacia)
```


Un tipo que define un valor opcional, que puede representar como ningún valor (Nada) o un valor específico (Justo a).
Haskell ofrece un tipo similar llamado _Maybe_.

```
data Quizas a = Nada | Justo a deriving (Show, Eq)
```


Función que retorna el índice en el que está un elemento en una lista, si el elemento no existe entonces retorna Nada.

```
indiceDe :: [Int] -> Int -> Quizas Int
indiceDe [] _ = Nada
indiceDe xs elem = indiceDe' xs elem 0 
```


Función auxiliar para _indiceDe_, que agrega un índice actual a los parámetros de la función

```
indiceDe' :: [Int] -> Int -> Int -> Quizas Int
indiceDe' [] _ _ = Nada
indiceDe' (x:xs) elem indiceActual | x == elem = Justo indiceActual
                                   | otherwise = indiceDe' xs elem (indiceActual + 1)
```


Un tipo que define un árbol binario genérico

```
data ArbolBinario a = Vacio | Nodo {raiz::a, izquierdo::ArbolBinario a, derecho::ArbolBinario a} deriving (Show, Eq)
```


Función que dado un elemento, y un árbol binario del mismo tipo, retorna (si existe) el antecesor del elemento en el árbol.
Ejemplo:

Dado el árbol

```
****1
**2***3
```

El 2 y el 3 tienen como antecesor al 1, el 1 no tiene antecesor, y el 4 no existe en el árbol.

```
antecesor :: (Eq a) => a -> ArbolBinario a -> Quizas a
antecesor _ Vacio = Nada
antecesor elem ab = antecesor' elem ab Nada
```


Función auxiliar para _antecesor_ que agrega un argumento extra que determina el antecesor actual.

```
antecesor' :: (Eq e) => e -> ArbolBinario e -> Quizas e -> Quizas e
antecesor' _ Vacio _ = Nada
antecesor' elem (Nodo raiz rI rD) ant | elem == raiz = ant
                                    | antI /= Nada = antI
                                    | antD /= Nada = antD
                                    | otherwise = Nada
                                    where antI = antecesor' elem rI (Justo raiz)
                                          antD = antecesor' elem rD (Justo raiz)
```


## Clases

En la sección de __Tipos__ mencionamos brevemente a las clases de Haskell cuando hablamos del `deriving` en la declaración de un nuevo tipo.
En términos generales, una clase define un conjunto de propiedades o funciones. La clase _Ord_ por ejemplo, define la propiedad de órden, definiendo las operaciones _<_, _<=_, _>_, _>=_, _min_, y _max_.

En la materia no nos vamos a centrar en la declaración de nuevas clases, aunque vamos a dar un ejemplo a modo ilustrativo, sino que nos vamos a centrar en dar definiciones de clases existentes para los tipos nuevos que desarrollemos,
o en términos más cercanos a Haskell, vamos a instanciar clases para tipos particulares.



Ejemplo de una clase Igualdad que define las operaciones _iguales_ y _distintos_.
En `Igualdad a`, `a` se refiere a un tipo genérico, en otros términos estamos diciendo _a va a tener la propiedad de Igualdad_ cuando defina las siguientes funciones.

Un detalle importante, y algo que puede parecer extraño e incluso incorrecto, es que las funciones `iguales` y `distintos` están definidas de manera circular.
Las funciones dentro de una clase no tienen por qué tener una implementación, con solo definir el perfil alcanza. El definir una función en base a la otra y viceversa, nos permite
solo dar la definición de una de estas cuando instanciemos la clase a un tipo particular.

Así como vimos la gramática para definir un nuevo tipo, vamos a ver la gramática para instanciar una clase para un tipo particular:

```
INSTANCIACION -> instance [(RESTRICCIONES)] CLASE TIPO where DEFINICIONES
    RESTRICCIONES -> NOMBRE_T VARIABLES [, RESTRICCIONES]
    NOMBRE_T -> un nombre escrito en PascalCase comenzando con una letra
    VARIABLES -> NOMBRE_V [VARIABLES]
    CLASE -> NOMBRE_T
    TIPO -> TIPO_SIN_ARGUMENTOS
    TIPO -> TIPO_CON_ARGUMENTOS
    TIPO_SIN_ARGUMENTOS -> NOMBRE_T
    TIPO_CON_ARGUMENTOS -> (NOMBRE_T VARIABLES)
    DEFINICIONES -> definiciones de las funciones asociadas (no es necesario el perfil), y se definen como funciones normales.
```

A continuación veremos algunos ejemplos.


```
class Igualdad a where
    iguales :: a -> a -> Bool
    iguales a b = not (distintos a b)
    distintos :: a -> a -> Bool
    distintos a b = not (iguales a b)
```


Un tipo que define una tupla homogénea. No escribimos `deriving (Show, Eq, Igualdad)`, por que vamos a instanciar esas clases a continuación.

```
data Tupla a = Tupla {primero::a, segundo::a}
```


Instanciación de Igualdad para tuplas genéricas (`Tupla a`).
Como en Igualdad las funciones `iguales` y `distintos` están definidas una en base a la otra, solo es necesario definir una de ellas para el tipo actual.

En este caso, es necesario que los elementos dentro de una tupla puedan ser comparados, por esto agregamos la restricción `Eq a`.

```
instance (Eq a) => Igualdad (Tupla a) where
    iguales (Tupla a b) (Tupla x y) = (a == x) && (b == y)
```


Al igual que la clase Igualdad, la clase Eq no requiere que definamos ambas funciones `==` y `/=`, solo con una alcanza.

Nuevamente, es necesario agregar la restricción `Eq a` para comparar los elementos dentro de la tupla.

```
instance (Eq a) => Eq (Tupla a) where
    (Tupla a b) == (Tupla x y) = (a == x) && (b == y)
```


En el caso de la clase Show, solo necesitamos definir la función `show`, la cual tiene el perfil `show :: a -> String`.

La restricción `Show a` es necesaria para poder mostrar los elementos dentro de la tupla.

```
instance (Show a) => Show (Tupla a) where
    show (Tupla x y) = "{" ++ (show x) ++ ", " ++ (show y) ++ "}"
```


Un tipo que define a los naturales, todo valor va a ser un cero o el sucesor de un natural.

```
data Nat = Zero | Succ Nat
```


Si utilizaramos `deriving Show` en la definición de Nat, el natural 8 lo veríamos como `Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ Zero)))))))` lo cual no es muy legible.
Nos gustaría una mejor visualización, por ejemplo `Nat 8`.

```
instance Show Nat where
    show n = "Nat " ++ (show (natToInt n))
           where natToInt Zero = 0
                 natToInt (Succ n) = 1 + (natToInt n)
```


Como ejercicio instancie la clase Eq para el tipo Nat, sin transformar a enteros.

