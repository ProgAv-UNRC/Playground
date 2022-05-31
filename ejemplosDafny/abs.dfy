/*
 * Un ejemplo de verificación con Dafny
 * El método Abs toma un entero y retorna el valor absoluto del mismo.
 *
 * La postcondición indica que el resultado (x') es positivo,
 * sin embargo no establece ninguna relación con la entrada.
 */

method abs(x: int) returns (x': int)
    requires true 
    ensures x' >= 0
{
    x' := if x < 0 then -x else x;
}

/*
* El método main es opcional, solo utilizado para imprimir el resultado de
* ejecutar Abs sobre un valor particular.
* Dafny no ejecuta este método, sino que puede generar código (C#, Java, Python, etc) para que lo haga.
* La anotación {:main} indica que este método va a ser el punto de entrada del programa cuando Dafny
* haga la traducción.
*/

method {:main} main()
{
    var x := abs(-3);
    assert x >= 0;
    print x, "\n";
}
