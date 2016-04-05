//REGISTER.v
module REGISTER(CLK, RST, EN, EN1,  NOW_STATE, NOW_STATE1);
input CLK;
input RST;
input EN, EN1;
input [7:0] NOW_STATE;
input [7:0] NOW_STATE1;

reg [7:0] STATE;

always@ (posedge CLK) begin
  if(EN == 1)begin
    STATE <= NOW_STATE;
  end
  if(EN1 == 1) begin
    STATE <= NOW_STATE1;
  end
end
endmodule
