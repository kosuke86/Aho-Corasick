//REGISTER.v
module REGISTER(CLK, RST, EN, NOW_STATE, STATE, MATCHING_START);
input CLK;
input RST;
input EN;
input [7:0] NOW_STATE;
output [7:0] STATE;
reg [7:0] STATE;
output MATCHING_START;
reg MATCHING_START;


always@ (posedge CLK) begin
  if(EN == 1)begin
    STATE <= NOW_STATE;
    MATCHING_START = 1;
  end else
    STATE = 0;
    MATCHING_START = 1;
end

endmodule
