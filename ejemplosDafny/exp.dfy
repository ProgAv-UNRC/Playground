/*
 * Un ejemplo de verificación con Dafny
 * El método exp calcula n^m de forma iterativa 
 */

/*
* Una función auxiliar recursiva que calcula  n^m
* Por defecto las funciones solo pueden ser utilizadas
* como parte de especificaciones, son tratadas como variables
* fantasma (ghost) y no se traducen a código si se pide a Dafny
* generar código ejecutable.
*/
function pow(n:nat, m:nat) : nat
{
  if m==0 then 1 else n*pow(n,m-1)
}

/*
*  Un metodo imperativo que calcula n^m
*/
method exp(n:nat, m:nat) returns (r:nat)
    requires n >= 0 && m >= 0 
    ensures r == pow(n,m)
 {
     var i := 0;
     r := 1;
     while i<m
        invariant r == pow(n,i)
        invariant i <= m
        //decreases m-i  // El variante no es necesario ya que Dafny lo puede calcular en este ejemplo
    {
        i := i+1;
        r := r*n;
    }
 }   