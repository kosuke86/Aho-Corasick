//TABLE_READER.v
module TABLE_READER(CLK, RST, EN, READER, NOW_STATE);
//module TABLE_READER(CLK, RST, EN, CHARA_EN, READER, NOW_STATE, RESULT);
input CLK;
input RST;
input EN;
//input CHARA_EN;

output [7:0] READER;
output [7:0] NOW_STATE;
integer i;

reg [7:0] READER;
reg [7:0] NOW_STATE;
//reg [7:0] RESULT;
reg [7:0] RAM_CURRENT_STATE_G[0:31];
reg [3:0] RAM_CHARA[0:31];
reg [7:0] RAM_NEXT_STATE[0:31];
reg [7:0] RAM_FAILURE_STATE[0:31];
initial $readmemh("current_state_goto.txt", RAM_CURRENT_STATE_G);
initial $readmemh("chara_goto.txt", RAM_CHARA);
initial $readmemh("next_state_goto.txt", RAM_NEXT_STATE);
initial $readmemh("failure_state_failure.txt", RAM_FAILURE_STATE);

function PROCESS_STRING;
  input EN;
  input CHARA_EN;
  begin
    if(EN == 1) begin
    READER = 0;
  for(i=0; i<11; i=i+1) begin
    if(RAM_CURRENT_STATE_G[i] == 0)begin
      READER = i;//ADDRの値
      CHARA_EN = 1;
      end else
      EN = 0;
  end
end
if(CHARA_EN == 1) begin
  if(RAM_CHARA[READER] == 13) begin
    NOW_STATE = RAM_NEXT_STATE[READER];
  end else if (RAM_FAILURE_STATE[READER] == 0) begin
      NOW_STATE = 0;
      end else 
        NOW_STATE = RAM_FAILURE_STATE[READER];
    end
  end
endfunction
/*
function CHARA_CHECK;
  //input SEARCH_OUT;
  input CHARA_EN;
  //input EN;
  begin
  if(CHARA_EN == 1)
  if(RAM_CHARA[READER] == 13) begin
    NOW_STATE = RAM_NEXT_STATE[READER];
  end else if (RAM_FAILURE_STATE[READER] == 0) begin
      NOW_STATE = 0;
      end else 
        NOW_STATE = RAM_FAILURE_STATE[READER];
    end
endfunction
*/

assign SEARCH_OUT = PROCESS_STRING(EN, CHARA_EN);

endmodule
