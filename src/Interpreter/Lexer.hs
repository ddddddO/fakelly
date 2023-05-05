-- 字句解析: ソースからトークン列へ変換する。字句解析器

module Lexer
  ( lexer
  ) where

data TokenType =
  ILLEGAL
  |EOF
  |IDENT -- 識別子. let x の xとか
  |INT -- 1234
  |ASSIGN -- =
  |PLUS -- +
  |COMMA -- ,
  |SEMICOLON -- ;
  |LPAREN -- (
  |RPAREN -- )
  |LBRACE -- {
  |RBRACE -- }
  |FUNCTION
  |LET -- let
  deriving (Show)

-- TODO: ここは型引数とってliteralの型に指定できれば扱いやすくならない？
data Token = Token
  { tokenType :: TokenType
  , literal   :: String
  } deriving (Show)

lexer :: [Char] -> [Maybe Token] -> [Maybe Token]
lexer [] ts = ts
lexer src ts =
  let (t, remaining) = token src
  in lexer remaining $ ts ++ [t]


-- 戻り値の[Char]は、残りの文字列
token :: [Char] -> (Maybe Token, [Char])
token [] = (Just (Token EOF []), [])
token (x:xs)
  | isSpace x = (Nothing, xs)
  | isDigit x = (Just (Token INT (fst spaned)), snd spaned)
  | x == '=' = (Just (Token ASSIGN [x]), xs)
  | x == ';' = (Just (Token SEMICOLON [x]), xs)
  | x == '(' = (Just (Token LPAREN [x]), xs)
  | x == ')' = (Just (Token RPAREN [x]), xs)
  | x == ',' = (Just (Token COMMA [x]), xs)
  | x == ';' = (Just (Token SEMICOLON [x]), xs)
  | x == '{' = (Just (Token LBRACE [x]), xs)
  | x == '}' = (Just (Token RBRACE [x]), xs)
  | otherwise = (Nothing, xs)
  where
    spaned = span isDigit (x:xs)

isSpace :: Char -> Bool
isSpace x =
  x == ' '

isDigit :: Char -> Bool
isDigit x =
  x `elem` ['0'..'9']
