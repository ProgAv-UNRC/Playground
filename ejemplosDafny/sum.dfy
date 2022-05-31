// Ejemplo que suma todos los elementos de un arreglo.

/*
* Suma hasta la posicion j-1 del arreglo a.
* Esta es una función auxiliar solo utilizada
* en la especificación (invariante y postcondición) de sumArray.
* 
* Como sum es una función recursiva, se debe dar un variante
* para determinar o especificar la terminación de la función.
*/
function sum(a:array<int>,j:nat):int
    decreases j
    reads a
    requires 0 <= j <= a.Length
{
    if j == 0  then 0
    else a[j-1] + sum(a,j-1) 
}

// El metodo sumArray:
//  a: es un arreglo de enteros
//  r: retorna la suma de los elementos de a
method sumArray(a:array<int>) returns (r:int)
    //requires a != null, esto indica que el arreglo a no puede ser null, sin embargo esto solo puede pasar si el tipo fuera array?<int>.
    ensures r == sum(a,a.Length)
{
    r := 0;
    var i := 0;
    while i < a.Length
        invariant 0 <= i <= a.Length
        invariant r == sum(a,i)
        decreases a.Length-i
    { 
        r := r + a[i];
        i := i+1;
    }
}
