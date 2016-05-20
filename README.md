# Aho-Corasick法をVerilogで実現
1.master_aho.ccからAho-Corasick法で必要な情報(goto関数、failure関数、output関数)を抽出する

2.goto_ram.vとfailure_goto.vに投げてレジスタ配列に格納しメモリテーブルを作成する。

3.table_reader.vとtable_reader1.vとtable_reader2.vにtext dataを入力しメモリテーブルを参照しながら文字列探索処理を行う。

4.処理を行いながらregister.vに状態遷移の情報を格納する。

↑どのように遷移したか確認できる。

5.text dataから入力した文字とパターンがマッチしてるとmatch.vがhighになる。

↑照合判定
