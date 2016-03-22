//MATCH.v
//マッチング判定
module MATCH(CLK, RST, EN, STATE_DATA, MATCH);
input CLK;
input RST;
input EN;
input [7:0] STATE_DATA;
output MATCH;
integer a;

reg MATCH;
reg [7:0] RAM_OUTPUT_STATE[0:31];

initial $readmemh("state_output.txt", RAM_OUTPUT_STATE);

//matching function
function MATCHING;
  input EN;
  begin
    if(EN == 1) begin
      for(a=0; a<10; a=a+1) begin
        if(RAM_OUTPUT_STATE[a] == STATE_DATA) begin
          MATCH = 1;
          EN = 0;// 処理を終わらせるため
        end else
          MATCH = 0;
      end
    end
  end
endfunction

assign MATCH_JUDGE = MATCHING(EN);
endmodule
