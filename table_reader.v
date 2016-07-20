//////////////////////////////////////////////////////////////////////////////////
// Company: west lab
// Engineer: Kosuke Nishimura
// 
// Create Date: 2016/7/20 14:28:18
// Design Name: 
// Module Name: table_reader
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module TABLE_READER(CLK, RST, EN, STRING, NOW_STATE_IN, NOW_STATE_OUT, EN_MATCH, INITIALIZE);
input CLK;
input RST;
input EN;
input INITIALIZE;
input [3:0] STRING;
input [7:0] NOW_STATE_IN;
output [7:0] NOW_STATE_OUT;
output EN_MATCH;
integer i,j,k,l;
integer m,n,o,p;

reg FLUG;
reg CHARA_EN;
reg CHARA_EN1;
reg EN_MATCH;
reg [7:0] ADDR [0:31];
reg [7:0] NOW_STATE_OUT;
reg [7:0] NOW_STATE_OUT_TMP;
reg [7:0] RAM_CURRENT_STATE_G[0:31];
reg [3:0] RAM_CHARA[0:31];
reg [7:0] RAM_NEXT_STATE[0:31];
reg [7:0] RAM_FAILURE_STATE[0:31];
initial $readmemh("current_state_goto.txt", RAM_CURRENT_STATE_G);
initial $readmemh("chara_goto.txt", RAM_CHARA);
initial $readmemh("next_state_goto.txt", RAM_NEXT_STATE);
initial $readmemh("failure_state_failure.txt", RAM_FAILURE_STATE);

wire SEARCH_OUT;
wire INITIALIZE1;

//aho-corasick algorithm
function PROCESS_STRING;
  input EN;
  input FAILURE_FLUG;
  input FLUG1;
  begin
    if(EN == 1) begin
      FLUG = 0;
      NOW_STATE_OUT_TMP = 0; //INITIALIZE
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
      end
      if (FLUG == 0) begin
        if (RAM_FAILURE_STATE[NOW_STATE_IN - 1] == 0) begin
          NOW_STATE_OUT_TMP = 0;
          FAILURE_FLUG = 1;
        end else
          NOW_STATE_OUT_TMP = RAM_FAILURE_STATE[NOW_STATE_IN - 1];
          FAILURE_FLUG = 1;
        end
    //Process of after failure transition 
    if (FAILURE_FLUG == 1) begin
      FLUG1 = 0;
      n=0;
      for(m=0; m<11; m=m+1) begin
        if(RAM_CURRENT_STATE_G[m] == NOW_STATE_OUT_TMP) begin
          ADDR[n] = m;
          n = n + 1;
          CHARA_EN1 = 1; //flug on
        end
      end
          CHARA_EN1 = 1; //flug on
    end
    if(CHARA_EN1 == 1) begin
      for (o=0; o<n; o=o+1) begin
        if(RAM_CHARA[ADDR[o]] == STRING) begin
          FLUG1 = 1;
          p = o;
        end
      end
      if(FLUG1 == 1) begin
        NOW_STATE_OUT = RAM_NEXT_STATE[ADDR[p]];
        EN_MATCH = 1;
      end
      if(FLUG1 == 0) begin
        NOW_STATE_OUT = 0;
        p=7;
      end
    end
  end
  if (FAILURE_FLUG == 0) begin
    NOW_STATE_OUT = NOW_STATE_OUT_TMP;
  end
end
endfunction

function INITIALIZE_FUN;
  input INITIALIZE;
  reg CHARA_EN;
  reg FLUG;
  reg FAILURE_FLUG;
  reg CHARA_EN1;
  reg FLUG1;
  reg EN_MATCH;
  reg EN;
  begin
    //Initialize
    if (INITIALIZE == 1) begin
    CHARA_EN = 0;
    FLUG = 0;
    FAILURE_FLUG = 0;
    CHARA_EN1 = 0;
    FLUG1 = 0;
    EN_MATCH = 0;
    EN = 0;
    i=0;
    j=0;
    k=0;
    l=0;
    m=0;
    n=0;
    o=0;
    p=0;
  end
end
endfunction
assign SEARCH_OUT = PROCESS_STRING(EN, FAILURE_FLUG, FLUG1);
assign INITIALIZE1 = INITIALIZE_FUN(INITIALIZE);
endmodule
