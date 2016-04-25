//TABLE_READER2.v
//TABLE_READER1.vからデータを引き継ぎ処理する
module TABLE_READER2(CLK, RST, EN, STRING, NOW_STATE_IN, NOW_STATE_OUT, EN_MATCH);
input CLK;
input RST;
input EN;
input [7:0] STRING;
input [7:0] NOW_STATE_IN;
output [7:0] NOW_STATE_OUT;
output EN_MATCH;
integer i,j,k,l;
integer I,J,K,L;

reg [7:0] ADDR [0:31];
reg [7:0] NOW_STATE_OUT;
reg EN_MATCH;
reg FLUG;
reg [7:0] RAM_CURRENT_STATE_G[0:31];
reg [3:0] RAM_CHARA[0:31];
reg [7:0] RAM_NEXT_STATE[0:31];
reg [7:0] RAM_FAILURE_STATE[0:31];
initial $readmemh("current_state_goto.txt", RAM_CURRENT_STATE_G);
initial $readmemh("chara_goto.txt", RAM_CHARA);
initial $readmemh("next_state_goto.txt", RAM_NEXT_STATE);
initial $readmemh("failure_state_failure.txt", RAM_FAILURE_STATE);

//aho-corasick algorithm
function PROCESS_STRING2;
  input EN;
  input CHARA_EN;
  begin
    if(EN == 1) begin // TABLE_READER1.vから信号受け取ってる
      j = 0;
      for(i=0; i<11; i=i+1) begin
        if(RAM_CURRENT_STATE_G[i] == NOW_STATE_IN) begin
          ADDR[j] = i;
          j = j + 1;
          CHARA_EN = 1; //flug on
        end
      end
          CHARA_EN = 1; //flug on
    end
    if(CHARA_EN == 1) begin
      for (k=0; k<j; k=k+1) begin
        if(RAM_CHARA[ADDR[k]] == STRING) begin
          FLUG = 1;
          l = k;
        end
      end
      if(FLUG == 1) begin
        NOW_STATE_OUT = RAM_NEXT_STATE[ADDR[l]];
        EN_MATCH = 1;
      end else if (RAM_FAILURE_STATE[NOW_STATE_IN - 1] == 0) begin
        NOW_STATE_OUT = 0;
        FAILURE_FLUG = 1;
      end else
        NOW_STATE_OUT = RAM_FAILURE_STATE[NOW_STATE_IN - 1];
        FAILURE_FLUG = 1;
    end
    //failure遷移後の処理
    if (FAILURE_FLUG == 1) begin
      for(I=0; I<11; I=I+1) begin
        if(RAM_CURRENT_STATE_G[i] == NOW_STATE_OUT) begin
          ADDR[J] = I;
          J = J + 1;
          CHARA_EN1 = 1; //flug on
        end
      end
          CHARA_EN1 = 1; //flug on
    end
    if(CHARA_EN1 == 1) begin
      for (K=0; K<J; K=K+1) begin
        if(RAM_CHARA[ADDR[K]] == STRING) begin
          FLUG1 = 1;
          L = K;
        end
      end
      if(FLUG1 == 1) begin
        NOW_STATE_OUT = RAM_NEXT_STATE[ADDR[L]];
        EN_MATCH = 1;
      end
    end
  end
endfunction
assign SEARCH_OUT2 = PROCESS_STRING2(EN, CHARA_EN);
endmodule
