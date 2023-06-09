-- | Un ejemplo simple para entrada y salida en donde se le pide al usuario la entrada, y se la tranforma en 
-- mayusculas

import Aux

main = do
	putStrLn("Escriba el texto:")
	l <- getLine
	putStrLn(mayuscs l)
	main
