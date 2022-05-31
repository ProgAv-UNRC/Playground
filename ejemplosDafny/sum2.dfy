/*
* Otra versión de la suma, con un cuantificador que permite sumar intervalos.
* Para esta versión se necesitan introducir lemmas.
*/

/*
* Suma hasta la posicion j-1 del arreglo a.
* Necesaria para expresar el invariante.
*/
function sum(a:array<int>,i:nat,j:nat):int
    decreases j-i
    reads a
    requires 0 <= i <= j 
    requires 0 <= j <= a.Length
{
    if j == 0 || i>=j  then 0
    else  a[i] + sum(a,i+1,j) 
}

// Metodo para sumar un arreglos de enteros
method sumArray(a:array<int>) returns (r:int)
    requires a != null
    ensures r == sum(a,0,a.Length)
{
    r := 0;
    var i := 0;
    while i < a.Length
        invariant 0 <= i <= a.Length
        invariant r == sum(a,0,i)
        decreases a.Length-i
    { 
        sumLemma2(a,i); // Indicamos a Dafny que puede usar el sumLemma
        r := r + a[i];
        i := i+1;
    }
}

// Lemas accesorios para demostrar la corrección del programa
// La suma i hasta i (sin incluir i) es igual a 0
lemma sumLemma(a:array<int>,i:nat)
    requires 0 <= i < a.Length 
    ensures sum(a,i,i) == 0
{
}

// La suma de i hasta i+1 solo suma el elemento en la posicion i
lemma sumLemma0(a:array<int>,i:nat)
    requires 0 <= i < a.Length 
    ensures sum(a,i,i+1) == a[i]
{
}

// Este lemma dice que una sumatoria se puede partir en dos
lemma sumLemma1(a:array<int>,i:nat, k:nat, j:nat)
    decreases k-i
    requires 0 <= i <= k < j <= a.Length 
    ensures sum(a,i,j) == sum(a,i,k) + sum(a,k,j)
{
    if (k == i)
    {
        sumLemma(a,i); // le decimos a Dafny que use este lemma para probar el caso base
        assert sum(a,i,j) == sum(a,k,j);
    }
    else{
        sumLemma1(a,i,k-1,j); // en el caso inductivo solo aplica la hipotesis inductiva
    }
}

// Este lemma permite partir una sumatoria en el ultimo elemento y el resto
lemma sumLemma2(a:array<int>,i:nat)
    requires 0 <= i < a.Length
    ensures sum(a,0,i+1) == sum(a,0,i) + a[i]
{
    sumLemma1(a,0,i,i+1);
}