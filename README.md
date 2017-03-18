gnu-make-framework-zen
==========================

これは GNU makefile のフレームワークです。
下記の特徴を持ちます。

+ ディレクトリごとにライブラリ化
+ ヘッダファイルの依存関係の自動生成
+ ソースコードツリーとオブジェクトツーリーの分離（出力ディレクトリを指定可能）
+ 複数のターゲット（実行可能ファイル）を作成可能
+ GNU/Linux, Mac OS X, MSYS2（Windows）で動作



This is GNU makefile framework. It may help you to develop when an environment does not support IDE.


# usesage

mkdir outputs

cd outputs

make -f ../GNUmakefile

./sample_programs


