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
  |MINUS -- -
  |BANG -- !
  |ASTERISK -- *
  |SLASH -- /
  |LT_ -- <
  |GT_ -- >
  |EQ_ -- ==
  |NOT_EQ -- !=
  |COMMA -- ,
  |SEMICOLON -- ;
  |LPAREN -- (
  |RPAREN -- )
  |LBRACE -- {
  |RBRACE -- }
  |FUNCTION
  |LET -- let
  |TRUE -- true
  |FALSE -- false
  |IF -- if
  |ELSE -- else
  |RETURN -- return
  deriving (Show)

-- TODO: ここは型引数とってliteralの型に指定できれば扱いやすくならない？
data Token = Token
  { tokenType :: TokenType
  , literal   :: String
  } deriving (Show)

-- lexerを実行し結果からNothingを除き意味あるものだけ返す
lexer' :: [Char] -> [Token]
lexer' src =
  let onlyJust = filter (\t -> case t of Just a -> True; Nothing -> False) $ lexer src []
  in map (\(Just t) -> t) onlyJust

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
  | isLetter x = (keyword (fst spanedLetter), snd spanedLetter)
  | isDigit x = (Just (Token INT (fst spanedDigit)), snd spanedDigit)
  | x == '=' = assignOrEqual $ [x] ++ xs
  | x == '+' = (Just (Token PLUS [x]), xs)
  | x == '-' = (Just (Token MINUS [x]), xs)
  | x == '!' = bangOrNotEqual $ [x] ++ xs
  | x == '/' = (Just (Token SLASH [x]), xs)
  | x == '*' = (Just (Token ASTERISK [x]), xs)
  | x == '<' = (Just (Token LT_ [x]), xs)
  | x == '>' = (Just (Token GT_ [x]), xs)
  | x == ';' = (Just (Token SEMICOLON [x]), xs)
  | x == '(' = (Just (Token LPAREN [x]), xs)
  | x == ')' = (Just (Token RPAREN [x]), xs)
  | x == ',' = (Just (Token COMMA [x]), xs)
  | x == '{' = (Just (Token LBRACE [x]), xs)
  | x == '}' = (Just (Token RBRACE [x]), xs)
  | otherwise = (Nothing, xs)
  where
    spanedDigit = span isDigit (x:xs)
    spanedLetter = span isLetter (x:xs)

isSpace :: Char -> Bool
isSpace x =
  x == ' '

isDigit :: Char -> Bool
isDigit x =
  x `elem` ['0'..'9']

isLetter :: Char -> Bool
isLetter x =
  x `elem` (['a'..'z'] ++ ['A'..'Z'])

keyword :: [Char] -> Maybe Token
keyword x =
  case x of
    "let" -> Just (Token LET x)
    "true" -> Just (Token TRUE x)
    "false" -> Just (Token FALSE x)
    "if" -> Just (Token IF x)
    "else" -> Just (Token ELSE x)
    "return" -> Just (Token RETURN x)
    otherwise -> Just (Token IDENT x)

assignOrEqual :: [Char] -> (Maybe Token, [Char])
assignOrEqual [] = (Nothing, [])
assignOrEqual (x:[]) =
  case x of
    '=' -> (Just (Token ASSIGN [x]), [])
assignOrEqual (x:xs) =
  let (x':xs') = xs
      target = [x] ++ [x']
  in case target of
    "==" -> (Just (Token EQ_ target), xs')
    otherwise -> (Just (Token ASSIGN [x]), xs)

bangOrNotEqual :: [Char] -> (Maybe Token, [Char])
bangOrNotEqual [] = (Nothing, [])
bangOrNotEqual (x:[]) =
  case x of
    '!' -> (Just (Token BANG [x]), [])
bangOrNotEqual (x:xs) =
  let (x':xs') = xs
      target = [x] ++ [x']
  in case target of
    "!=" -> (Just (Token NOT_EQ target), xs')
    otherwise -> (Just (Token BANG [x]), xs)