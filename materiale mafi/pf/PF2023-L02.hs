import Data.List (findIndices);
import Data.Char (isDigit, digitToInt);
nrvocale :: [String] -> Int
nrvocale [] = 0
nrvocale (x:xs) 
    | x == reverse x = length (filter (`elem` "aeiouAEIOU") x) + nrvocale xs
    | otherwise = nrvocale xs
;

adaugaDupaPar :: Int -> [Int] -> [Int]
adaugaDupaPar _ [] = []  
adaugaDupaPar n (x:xs)
    | even x = x : n : adaugaDupaPar n xs  
    | otherwise = x : adaugaDupaPar n xs   
;

nr_div :: Int -> [Int]
nr_div x = [elem | elem <- [1..x], mod x elem == 0];
        
lista_div :: [Int] -> [[Int]]
lista_div [] = []
lista_div (x:xs) = nr_div x : lista_div xs;

inInterval :: Int -> Int -> [Int] -> [Int]
inInterval a b xs = filter aceptat xs
                    where aceptat x = a < x && x < b;

inIntervalrec :: Int -> Int -> [Int] -> [Int]
inIntervalrec _ _ [] = []
inIntervalrec a b (x:xs) 
        | a < x && x < b = x : inIntervalrec a b xs
        | otherwise = inIntervalrec a b xs;

pozitive :: [Int] -> Int
pozitive [] = 0
pozitive (x:xs)
        | x > 0 = 1 + pozitive xs
        | otherwise = pozitive xs;

pozitive2 :: [Int] -> Int
pozitive2 lista = length(filter poz lista)
                  where poz x = x > 0 ;



pozitiiImpare :: [Int] -> [Int]
pozitiiImpare lista = findIndices odd lista;

pozitiiImpare2 :: [Int] -> [Int]
pozitiiImpare2 lista = [i | (i, x) <- zip [0..] lista, odd x];

multDigits :: [Char] -> Int
multDigits lista
        | length(cifre) == 0 = 1
        | otherwise = product(cifre)
        where
          cifre = map digitToInt (filter isDigit lista);

--lab4


factori :: Int -> [Int]
factori x = [div | div <- [1..x] , mod x div == 0];

prim :: Int -> Bool
prim x 
   | length(factori x) ==  2 = True
   | otherwise = False;

numerePrime :: Int -> [Int]
numerePrime x = [nrpr | nrpr <- [2..x], prim nrpr == True];


firstEl ::[(a,b)] -> [a]
firstEl perechi = map fst perechi;  --de tinut minte fst

sumList :: [[Int]] -> [Int]
sumList liste = map sum liste;

prel2 :: [Int] -> [Int]
prel2 lista = map prel lista
              where prel x
                        | even x = div x 2
                        | otherwise = x * 2;

f :: Char -> [String] -> [String]
f a lista = filter exista lista
            where 
                 exista x = elem a x ;

f2 :: [Int] -> [Int]
f2 lista =map (^2) (filter odd lista);


-- se sa returneze patratele numerelor depe pozitii impare din lista


f3 :: [Int] -> [Int]
f3 xs = map (\(pos, x) -> x^2) (filter (\(pos, x) -> odd pos) (zip [1..] xs));

f3_2 :: [Int] -> [Int]
f3_2 xs = map square (filter oddIndex (zip [1..] xs))
        where
                square (_, x) = x^2
                oddIndex (pos, _) = odd pos;

                
numaiVocale :: [String] -> [String]
numaiVocale lista = map (filter (`elem` "aeiouAEIOU")) lista;

--lab5

numereImpare :: [Int] -> Int
numereImpare lista = foldr (+) 0 (map (^2) (filter odd lista));

v_true :: [Bool] -> Bool
v_true lista = length(lista) == foldr (+) 0 (map fromEnum lista); 

allVerifies :: (Int -> Bool) -> [Int] -> Bool
allVerifies conditie lista = length(lista_conditie) == length(lista)
                where
                        lista_conditie = filter conditie lista;

anyVerifies :: (Int -> Bool) -> [Int] -> Bool
anyVerifies conditie lista = length(lista_conditie) > 0
                where
                        lista_conditie = filter conditie lista;


listToInt :: [Integer] -> Integer
listToInt lista = foldl step 0 lista
        where step acc x = acc * 10 + x;

rmChar :: Char -> String -> String
rmChar a cuvant = foldr step "" cuvant
        where step x acc
                        | x == a = acc
                        | otherwise = x:acc;

rmCharsRec :: String -> String -> String
rmCharsRec lista cuvant = foldr step "" cuvant
        where step x acc
                        | elem x lista = acc
                        | otherwise = x:acc;

myReverse :: [Int] -> [Int]
myReverse lista = foldl (flip (:)) [] lista;

myElem :: Int -> [Int] ->Bool
myElem a lista = length(filter conditie lista) == length(lista) - 1
        where conditie x = x /= a;

--lab6
{-
data Fruct = Mar String Bool
        | Portocala String Int;
-}
data Fruct = Mar String Bool
           | Portocala String Int;

listaFructe = [Mar "Ionatan" False,
                Portocala "Sanguinello" 10,
                Portocala "Valencia" 22,
                Mar "Golden Delicious" True,
                Portocala "Sanguinello" 15,
                Portocala "Moro" 12,
                Portocala "Tarocco" 3,
                Portocala "Moro" 12,
                Portocala "Valencia" 2,
                Mar "Golden Delicious" False,
                Mar "Golden" False,
                Mar "Golden" True]

ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Portocala soi _) = soi `elem` ["Tarocco", "Moro", "Sanguinello"]
ePortocalaDeSicilia _ = False  -- Pentru cazurile care nu sunt portocale


nrFeliiSicilia :: [Fruct] -> Int
nrFeliiSicilia fructe = sum [felii | Portocala soi felii <- fructe, ePortocalaDeSicilia (Portocala soi felii)]

nrMereViermi :: [Fruct] -> Int
nrMereViermi fructe = sum [fromEnum vierme | Mar soi  vierme <- fructe];

type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa
        deriving Show

vorbeste :: Animal -> String
vorbeste (Pisica _) = "Meow"
vorbeste _ = "woof"

rasa :: Animal -> Maybe String
rasa (Caine _ rasa) = Just rasa
rasa _ = Nothing;

data Linie = L [Int]
        deriving Show
data Matrice = M [Linie]
        deriving Show

verifica :: Matrice -> Int -> Bool
verifica (M linii) a = foldr (\(L l) acc -> acc && (foldr (+) 0 l == a)) True linii


doarPozN :: Matrice -> Int -> Bool
doarPozN (M linii) n = all (\(L lista) -> length lista == n && all (> 0) lista) linii





