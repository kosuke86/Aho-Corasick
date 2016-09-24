# Aho-Corasick algorithm for FPGA
## Description
1.master_aho.ccからAho-Corasick法で必要な情報を抽出する
- goto function
- failure function
- output function

2.goto_ram.vとfailure_goto.vに投げてレジスタ配列に格納しメモリテーブルを作成する。

3.table_reader.vにtext dataを入力しメモリテーブルを参照しながら文字列探索処理を行う。

4.処理を行いながらregister.vに状態遷移の情報を格納する。

5.3と4を繰り返す

6.text dataから入力した文字とパターンがマッチしてるとmatch.vがhighになる。

## Requirement
- C++
- Verilog

## Author
@ko_suke86

## License
Copyright © 2016 Kosuke Nishimura from West lab. All Rights Reserved.
