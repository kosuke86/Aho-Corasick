//TABLE_READER.v
module TABLE_READER(CLK, RST, EN, READER, READER1, RESULT);
input CLK;
input RST;
input EN;

output [7:0] READER;
output [7:0] READER1;
output [7:0] RESULT;
integer i;

reg [7:0] READER;
reg [7:0] READER1;
reg [7:0] RAM_CURRENT_STATE_G[0:31];
reg [3:0] RAM_CHARA[0:31];
reg [7:0] RAM_NEXT_STATE[0:31];
reg [7:0] RAM_FAILURE_STATE[0:31];
initial $readmemh("current_state_goto.txt", RAM_CURRENT_STATE_G);
initial $readmemh("chara_goto.txt", RAM_CHARA);
initial $readmemh("next_state_goto.txt", RAM_NEXT_STATE);
initial $readmemh("failure_state_failure.txt", RAM_FAILURE_STATE);

//aho-corasick algorithm
/*
always @(posedge CLK) begin
  if(EN)
    READER <= 0;
  for(i=0; i<10; i=i+1) begin
      if(RAM_CURRENT_STATE_G[i] == 0)

       if(RAM_CHARA[READER] == )//chara
         READER <= RAM_NEXT_STATE[READER];
       else if(RAM_FAILURE_STATE[READER] == 0)
         READER <= 0;
       else
         READER <= RAM_FAILURE_STATE[READER];
 end
 
 endmodule
*/
function SEARCH_0;
  input EN;
  begin
    if(EN == 1) begin
    READER = 0;
  for(i=0; i<10; i=i+1) begin
    if(RAM_CURRENT_STATE_G[i] == 0)begin
      READER = i;
      end else
      EN = 0;
  end
end
end
endfunction


function CHARA_CHECK;
  input SEARCH_OUT;
  begin
  if(EN)
  if(RAM_CHARA[SEARCH_OUT] == 11) begin
    READER1 = RAM_NEXT_STATE[SEARCH_OUT];
  end else if (RAM_FAILURE_STATE[SEARCH_OUT] == 0) begin
      READER1 = 0;
      end else 
        READER1 = RAM_FAILURE_STATE[SEARCH_OUT];
    end
endfunction


assign SEARCH_OUT = SEARCH_0(EN);
assign RESULT = CHARA_CHECK(SEARCH_OUT);
endmodule
