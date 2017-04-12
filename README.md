gnu-make-framework-zen
==========================

自前で makefile を書くのって大変ではありませんか？
make は文法も難しいしデバッグは大変だし、ディレクトリ構成を考えるのもめんどくさいし、とにかくめんどくさいですよね。
この gnu-make-framework-zen はそんなあなたを手助けいたします！

# 特徴

この gnu-make-framework-zen は下記の特徴を持っています。

+ ディレクトリごとにライブラリ化
+ ヘッダファイルの依存関係の自動生成
+ ソースコードツリーとオブジェクトツーリーの分離（出力ディレクトリを指定可能）
+ 複数のターゲット（実行可能ファイル）を作成可能
+ マルチプラットフォームです、GNU/Linux, Mac OS X, MSYS2（Windows）で動作可能




This is GNU makefile framework. It may help you to develop when an environment does not support IDE.


# usesage

mkdir outputs

cd outputs

make -f ../GNUmakefile

./sample_programs


# 参考文献

https://www.oreilly.co.jp/library/4873112699/
