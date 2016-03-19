//TABLE_READER1.v
module TABLE_READER1(CLK, RST, EN, NOW_STATE_IN, NOW_STATE_OUT);
input CLK;
input RST;
input EN;
input NOW_STATE_IN;
output [7:0] NOW_STATE_OUT;
integer i;

reg [7:0] NOW_STATE_OUT;
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
  input CHARA_EN;
  input NOW_STATE_IN;
  begin
if(CHARA_EN == 1) begin
  if(RAM_CHARA[NOW_STATE_IN] == 10) begin // テキストデータを入れる予定
    NOW_STATE_OUT = RAM_NEXT_STATE[NOW_STATE_IN];
  end else if (RAM_FAILURE_STATE[NOW_STATE_IN] == 0) begin
      NOW_STATE_OUT = 0;
      end else 
        NOW_STATE_OUT = RAM_FAILURE_STATE[NOW_STATE_IN];
    end
  end
endfunction

assign SEARCH_OUT = PROCESS_STRING1(CHARA_EN, NOW_STATE_IN);
endmodule
