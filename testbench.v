//testbench.v
module testbench;

reg CLK;
reg RST;
reg EN;
reg INITIALIZE;
reg [3:0] STRING;

reg [3:0] STRING_DATA[0:31];
initial $readmemh("a.txt", STRING_DATA);

TOP TOP(CLK, RST, EN, INITIALIZE, STRING);

parameter STEP = 20;

always #(STEP / 2) CLK = ~CLK;

initial begin
  $dumpfile("wave.vcd");
  $dumpvars(0, TOP);
  $dumplimit(100000);
  CLK = 0;
  RST = 0;
  INITIALIZE = 0;
  #10
  INITIALIZE = 1;
  EN = 0;
  #10
  RST = 1;
  EN = 1;
  INITIALIZE = 0;
  STRING = STRING_DATA[0];
  #10
  INITIALIZE = 1;
  EN = 0;
  #10
  INITIALIZE = 0;
  EN = 1;
  STRING = STRING_DATA[1];
  #10
  INITIALIZE = 1;
  EN = 0;
  #10
  INITIALIZE = 0;
  EN = 1;
  STRING = STRING_DATA[2];
  #10
  INITIALIZE = 1;
  EN = 0;
  #10
  INITIALIZE = 0;
  EN = 1;
  STRING = STRING_DATA[3];
  #10
  INITIALIZE = 1;
  EN = 0;
  #10
  INITIALIZE = 0;
  EN = 1;
  STRING = STRING_DATA[4];
  #10
  INITIALIZE = 1;
  EN = 0;
  #10
  INITIALIZE = 0;
  EN = 1;
  STRING = STRING_DATA[5];
  #10
  INITIALIZE = 1;
  EN = 0;
  #10
  INITIALIZE = 0;
  EN = 1;
  STRING = STRING_DATA[6];
  #10
  INITIALIZE = 1;
  EN = 0;
  #10
  INITIALIZE = 0;
  EN = 1;
  STRING = STRING_DATA[7];
  #10
  #10

  $finish;
end

endmodule
