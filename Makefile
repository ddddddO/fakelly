# repl:
# 	$ ghci
# 	ghci> :l app/Main.hs src/Lib.hs
# 	ghci> ls' "."

build:
	stack build

# makeに良い感じに引数渡せないか
fakelly:
	stack exec fakelly ls .

# 使いたいライブラリがあれば、package.yamlの library.dependenciesに追記して、stack build すればいいっぽい。
# System.Directory が使えるようになった
