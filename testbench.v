//testbench.v
module testbench;

reg CLK;
reg RST;
reg EN;
reg EN_A;
reg [7:0] STRING;

reg [7:0] STRING_DATA[0:31];
initial $readmemh("input_string.txt", STRING_DATA);

TOP TOP(CLK, RST, EN, EN_A, STRING);

parameter STEP = 10;

always #(STEP / 2) CLK = ~CLK;

initial begin
  $dumpfile("wave.vcd");
  $dumpvars(0, TOP);
  $dumplimit(100000);
  CLK = 0;
  RST = 0;
  EN = 0;
  EN_A = 0;
  #10
  RST = 1;
  #10
  EN = 1;
  STRING = STRING_DATA[0];
  #10
  EN_A = 1;
  STRING = STRING_DATA[1];
  #140
  $finish;
end

endmodule
