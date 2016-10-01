//MATCH.v
//マッチング判定
module MATCH(CLK, INITIALIZE, EN, STATE_DATA, MATCH);
input CLK;
input INITIALIZE;
input EN;
input [7:0] STATE_DATA;
output MATCH;
integer a;

reg MATCH;
reg [7:0] RAM_OUTPUT_STATE[0:31];

wire MATCH_JUDGE;

initial $readmemh("state_output.txt", RAM_OUTPUT_STATE);


always @ CLK begin
  if (INITIALIZE == 1) begin
    MATCH = 0;
    a = 0;
  end
  if(EN == 1) begin
    for(a=0; a<10; a=a+1) begin
      if(RAM_OUTPUT_STATE[a] == STATE_DATA) begin
        MATCH = 1;
      end
    end
  end
end

/*
//matching function
function MATCHING;
  input EN;
  begin
    if(EN == 1) begin
      for(a=0; a<10; a=a+1) begin
        if(RAM_OUTPUT_STATE[a] != STATE_DATA) begin
          MATCH = 1;
        end
      end
    end
    EN = 0;
    a = 0;
end
endfunction

assign MATCH_JUDGE = MATCHING(EN);
*/
endmodule
