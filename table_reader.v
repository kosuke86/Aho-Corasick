//TABLE_READER.v
module TABLE_READER(CLK, RST, EN, ADDR_NUM, NOW_STATE);
input CLK;
input RST;
input EN;

output [7:0] ADDR_NUM;
output [7:0] NOW_STATE;
integer i;

reg [7:0] ADDR_NUM;
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
    ADDR_NUM = 0;
  for(i=0; i<3; i=i+1) begin
    if(RAM_CURRENT_STATE_G[i] == 0)begin
      ADDR_NUM = i; //ADDRの値
      CHARA_EN = 1; //flug on
      end else
      EN = 0;
  end
end
if(CHARA_EN == 1) begin
  if(RAM_CHARA[ADDR_NUM] == 10) begin
    NOW_STATE = RAM_NEXT_STATE[ADDR_NUM];
  end else if (RAM_FAILURE_STATE[ADDR_NUM] == 0) begin
      NOW_STATE = 0;
      end else 
        NOW_STATE = RAM_FAILURE_STATE[ADDR_NUM];
    end
  end
endfunction

assign SEARCH_OUT = PROCESS_STRING(EN, CHARA_EN);
endmodule
