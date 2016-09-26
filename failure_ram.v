//FAILURE_RAM.v
//レジスタ配列に格納(memory)
module FAILURE_RAM(CLK, RST, ADDR_F);
input CLK;
input RST;
input [11:0] ADDR_F;
//8bit(=2文字分)レジスタ配列32行分
reg [7:0] RAM_CURRENT_STATE_F[0:31];
reg [7:0] RAM_FAILURE_STATE[0:31];
reg [7:0] CURRENT_STATE_F;
reg [7:0] FAILURE_STATE;
initial $readmemh("current_state_failure.txt", RAM_CURRENT_STATE_F);
initial $readmemh("failure_state_failure.txt", RAM_FAILURE_STATE);


always @(posedge CLK)
  begin
    /*
    if (~RST)
      FAILURE_DATA <= 11'h0;
    else
      FAILURE_DATA <= ROM[ADDR];
      CURRENT_STATE_F <= FAILURE_DATA[15:8];
      FAILURE_STATE <= FAILURE_DATA[7:0];
      */
    if (RST)
      CURRENT_STATE_F <= RAM_CURRENT_STATE_F[ADDR_F];
      FAILURE_STATE <= RAM_FAILURE_STATE[ADDR_F];

  end

endmodule
