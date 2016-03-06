# Aho-Corasick法をVerilogで実現
1.master_aho.ccからAho-Corasick法で必要な情報(goto関数、failure関数、output関数)を抽出する

2.table_reader.vとgoto_ram.vとfailure_goto.vに投げてレジスタ配列に格納する。
