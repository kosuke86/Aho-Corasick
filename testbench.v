//testbench.v
module testbench;

reg CLK;
reg RST;
reg EN;
reg EN_A;


TOP TOP(CLK, RST, EN, EN_A);
parameter STEP = 10;
always #(STEP / 2) CLK = ~CLK;

initial begin
  $dumpfile("wave.vcd");
  $dumpvars(0, TOP);
  $dumplimit(100000)
  CLK = 0;
  RST = 0;
  EN = 0;
  EN_A = 0;
  #10
  RST = 1;
  #100
  EN = 1;
  #10
  EN_A = 1;
  #100
  $finish;
end

endmodule
