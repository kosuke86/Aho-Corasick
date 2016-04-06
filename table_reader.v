//TABLE_READER.v
module TABLE_READER(CLK, RST, EN, STRING, NOW_STATE);
input CLK;
input RST;
input EN;
input [7:0] STRING;

output [7:0] NOW_STATE;
output EN_NEXT;
integer i,j;

reg EN_NEXT;
reg [7:0] ADDR [0:31];
reg [7:0] NOW_STATE;
reg [7:0] RAM_CURRENT_STATE_G[0:31];
reg [3:0] RAM_CHARA[0:31];
reg [7:0] RAM_NEXT_STATE[0:31];
reg [7:0] RAM_FAILURE_STATE[0:31];
initial $readmemh("current_state_goto.txt", RAM_CURRENT_STATE_G);
initial $readmemh("chara_goto.txt", RAM_CHARA);
initial $readmemh("next_state_goto.txt", RAM_NEXT_STATE);
initial $readmemh("failure_state_failure.txt", RAM_FAILURE_STATE);

//aho-corasick algorithm
function PROCESS_STRING;
  input EN;
  input CHARA_EN;
  begin
    if(EN == 1) begin
      j = 0;
      for(i=0; i<11; i=i+1) begin
        if(RAM_CURRENT_STATE_G[i] == 0)begin
          ADDR[j] = i; //ADDRの値
          j = j + 1;
          CHARA_EN = 1; //flug on
        end else
          EN = 0;
      end

    end
    //この回路は初期状態のみを処理する場合
    if(CHARA_EN == 1) begin
      if(RAM_CHARA[ADDR[1]] == STRING) begin
        NOW_STATE = RAM_NEXT_STATE[ADDR[1]];
        //EN_NEXT = 1;// TABLE_READER1.vの処理フラグON
      end else
        NOW_STATE = 0;
    end
  end


//今後拡張する場合に置いておく
/*
if(CHARA_EN == 1) begin
  if(RAM_CHARA[ADDR] == 12) begin // テキストデータを入れる予定
    NOW_STATE_OUT = RAM_NEXT_STATE[ADDR];
  end else if (RAM_FAILURE_STATE[NOW_STATE_IN + 1] == 0) begin
      NOW_STATE_OUT = 0;
      end else 
        NOW_STATE_OUT = RAM_FAILURE_STATE[NOW_STATE_IN + 1];
    end
  end
end
*/
endfunction

assign SEARCH_OUT = PROCESS_STRING(EN, CHARA_EN);
endmodule
