# repl:
# 	$ ghci
# 	ghci> :l app/Main.hs src/Lib.hs
# 	ghci> ls' "."

format:
	stylish-haskell app/Main.hs

test:
	stack test

build:
	stack build

# 実行ファイルを~/.local/bin配下にコピーしてくれる。パスを通せば、そのまま呼び出せる
install:
	 stack install

fakelly:
	stack exec fakelly ls .

# 使いたいライブラリがあれば、package.yamlの library.dependenciesに追記して、stack build すればいいっぽい。
# System.Directory が使えるようになった
