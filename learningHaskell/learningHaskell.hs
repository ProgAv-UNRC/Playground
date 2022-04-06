{-
# Demo sobre Haskell
En este archivo se van a mostrar algunos ejemplos de los temas que se fueron viendo.
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
