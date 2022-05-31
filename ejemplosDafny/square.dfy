/* 
* Un ejemplo simple de verificacion con Dafny
* square: calcula la aproximación entera a la raiz cuadrada de un numero dado
*/

method square(x:nat) returns (r:nat)
    requires x >= 0
    ensures r*r <= x < (r+1)*(r+1) // debe devolver un r tal que su cuadrado es menor o igual que el numero
                                   // pero si sumo uno se pasa
{
    r:=0;
    while (r+1)*(r+1) <= x
        invariant r*r <= x
        //decreases x - (r+1)*(r+1) //El variante está comentado por que Dafny es capaz de generarlo solo, no siempre puede hacerlo.
    {
        r:=r+1;
    }
}

