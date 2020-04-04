gnu-make-framework-zen
==========================

自前で makefile を書くのって大変ではありませんか？make は文法も難しいしデバッグは大変だし、ディレクトリ構成を考えるのもめんどくさいし、とにかくめんどくさいですよね。
この gnu-make-framework-zen はそんなあなたを手助けいたします！

# 特徴

この gnu-make-framework-zen は下記の特徴を持っています。

+ ディレクトリごとにライブラリ化
+ ヘッダファイルの依存関係の自動生成
+ ソースコードツリーとオブジェクトツリーの分離（出力ディレクトリを指定可能）
+ 複数のターゲット（実行可能ファイル）を作成可能
+ マルチプラットフォームです、GNU/Linux, Mac OS X, MSYS2（Windows）で動作可能

This is a GNU makefile framework which helps your development in environment without support of IDE.

# サンプルプログラムのビルド方法

サンプルプログラムを同梱しています。ビルドの方法は下記の通り。

最初に出力ディレクトリを作成し、そこでmakeを実行します。出力ディレクトリ以下にオブジェクトファイルやライブラリ、実行可能ファイルが作成されます。
つまり元のソースコードディレクトリにファイルを生成しませんので、元のディレクトリは綺麗に保たれます。

```sh
mkdir outputs

cd outputs

make -f ../GNUmakefile

./sample_programs
```

# ファイル構成


## ファイルツリー

```
├── GNUmakefile        --- トップレベルのMakfile
├── LICENSE.txt        --- ライセンスファイル
├── README.md          --- このドキュメント
├── build
│   ├── clean_all.mk            --- ビルドしたオブジェクトを全削除するmakefile
│   ├── clear_local_variable.mk --- 各モジュールの変数を設定するためのmakefile
│   ├── create_executable.mk    --- 実行可能ファイルをビルドするためのmakefile
│   ├── create_library.mk       --- モジュールをライブラリ化するためのmakefile
│   ├── define_macro.mk         --- Makeのマクロを定義するmakefile
│   ├── define_pattern_rule.mk  --- Makeのパターンルールを定義するmakefile
│   ├── define_suffix_rule.mk   --- サフィックスルールを設定するmakefile
│   └── set_toolchain.mk        --- コンパイラなどの設定をするmakefile
└── src
    ├── modules
    │   ├── embunit
    │   │   ├── module.mk       --- ライブラリ名や対象ソースファイル名を設定するmakefile
    │   │   ├── *.c
    │   │   └── *.h
    │   └── spinner_progressbar
    │       ├── module.mk
    │       ├── *.c
    │       └── *.h
    └── targets
        ├── sample_embunit
        │   ├── target.mk       --- 実行可能ファイル名やライブラリなどを設定するmakefile
        │   ├── *.c
        │   └── *.h
        └── sample_spinner
            ├── target.mk
            └── *.c
```

## 各ディレクトリの概要

| ディレクトリ名 | 概要                             |
| ------------- | -------------------------------- |
| build/        | ビルドに必要なサブメイクファイル群 |
| src/modules/  | モジュールのソースコード          |
| src/targets/  | ターゲット依存のソースコード      |


# ライセンス

## このプロジェクト全体ののライセンス（Overall license）

MIT License

Copyright (c) [2017] [NAGAYASU Shinya]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


## 他のプロジェクトから派生したファイルのライセンス（Files derived from other sources）

### src/modules/embunit/*

Embedded Unit は、MIT/X Consortium License に従うものとします．

http://embunit.sourceforge.net/embunit/

# 参考文献

https://www.oreilly.co.jp/library/4873112699/
