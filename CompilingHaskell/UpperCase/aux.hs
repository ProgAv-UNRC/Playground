-- | Un modulo simple que provee algunas funciones para la manipulacion de strings en Haskell
--   La idea es utilizarlo en el modulo main, para compilar luego todos los modulos juntos
module Aux where

import Data.Char

-- Transforma una palabra a mayusculas
mayuscs :: String -> String
mayuscs = map toUpper

-- Da vuelta todas las palabras en un string
reverseWords :: String -> String  
reverseWords = unwords . map reverse . words 


