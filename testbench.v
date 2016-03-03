//testbench.v
module testbench;

reg CLK;
reg RST;
reg EN;

TOP TOP(CLK, RST, EN);

parameter STEP = 10;

always #(STEP / 2) CLK = ~CLK;

initial begin
  $dumpfile("wave.vcd");
  $dumpvars(0, TOP);
  $dumplimit(100000);
 // $monitor ("ADDR_G =%d, CURRENT_STATE_G = %h, CHARA = %h, NEXT_STATE = %h, ADDR_F =%d, CURRENT_STATE_F = %h, FAILURE_STATE = %h, READER = %h,", ADDR_G, CURRENT_STATE_G, CHARA, NEXT_STATE, ADDR_F, CURRENT_STATE_F, FAILURE_STATE, READER);
  CLK = 0;
  RST = 0;
  EN = 0;
  #10
  RST = 1;
  #100
  EN = 1;
  #10
  EN = 0;
  $finish;
end

endmodule
