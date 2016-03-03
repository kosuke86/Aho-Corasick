//FAILURE_ADDR.v
//レジスタ配列のアドレス生成
module FAILURE_ADDR(CLK, RST, ADDR_F);
input CLK;
input RST;
output [11:0]ADDR_F;
reg [11:0]ADDR_F;
always @(posedge CLK)
  begin
    if (~RST)
      ADDR_F <= 11'd0;
    else if (ADDR_F == 11'h15)
      ADDR_F <= 11'd0;
    else
      ADDR_F <= ADDR_F + 1'b1;
  end
endmodule
