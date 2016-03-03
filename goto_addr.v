//GOTO_ADDR.v
//レジスタ配列のアドレス生成
module GOTO_ADDR(CLK, RST, ADDR_G);
input CLK;
input RST;
output [11:0]ADDR_G;
reg [11:0]ADDR_G;
always @(posedge CLK)
  begin
if (~RST)
      ADDR_G <= 11'd0;
    else if (ADDR_G == 11'd15)
      ADDR_G <= 11'd0;
    else
      ADDR_G <= ADDR_G + 1'b1;
  end
endmodule
