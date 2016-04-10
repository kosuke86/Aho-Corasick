//TABLE_READER1.v
//メモリテーブルを用いて文字列探索を行う
module TABLE_READER1(CLK, RST, EN, STRING, NOW_STATE_IN, NOW_STATE_OUT, EN_MATCH);
input CLK;
input RST;
input EN;
input [7:0] STRING;
input [7:0] NOW_STATE_IN;
output [7:0] NOW_STATE_OUT;
output EN_MATCH;
integer i,j;

reg [7:0] ADDR [0:31];
reg [7:0] NOW_STATE_OUT;
reg EN_MATCH;
reg [7:0] RAM_CURRENT_STATE_G[0:31];
reg [3:0] RAM_CHARA[0:31];
reg [7:0] RAM_NEXT_STATE[0:31];
reg [7:0] RAM_FAILURE_STATE[0:31];
initial $readmemh("current_state_goto.txt", RAM_CURRENT_STATE_G);
initial $readmemh("chara_goto.txt", RAM_CHARA);
initial $readmemh("next_state_goto.txt", RAM_NEXT_STATE);
initial $readmemh("failure_state_failure.txt", RAM_FAILURE_STATE);

//aho-corasick algorithm
function PROCESS_STRING1;
  input EN;
  input CHARA_EN;
  begin
    if(EN == 1) begin // TABLE_READER.vから信号受け取ってる
      j = 0;
      for(i=0; i<11; i=i+1) begin
        if(RAM_CURRENT_STATE_G[i] == NOW_STATE_IN) begin
          ADDR[j] = i;
          j = j + 1;
          CHARA_EN = 1; //flug on
        end
      end
    end
    if(CHARA_EN == 1) begin
      if(RAM_CHARA[ADDR[0]] == STRING) begin
        NOW_STATE_OUT = RAM_NEXT_STATE[ADDR[0]];
        EN_MATCH = 1;
      end else if (RAM_FAILURE_STATE[NOW_STATE_IN - 1] == 0) begin
        NOW_STATE_OUT = 0;
      end else 
        NOW_STATE_OUT = RAM_FAILURE_STATE[NOW_STATE_IN - 1];
    end
  end
endfunction

assign SEARCH_OUT1 = PROCESS_STRING1(EN, CHARA_EN);
endmodule
