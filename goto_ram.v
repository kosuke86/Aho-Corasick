//GOTO_RAM.v
//レジスタ配列に格納(memory)
module GOTO_RAM(CLK, RST, ADDR_G);
input CLK;
input RST;
input [11:0] ADDR_G;
//32bit(=8文字分)レジスタ配列32行分
reg [7:0]RAM_CURRENT_STATE_G[0:31];
reg [3:0]RAM_CHARA[0:31];
reg [7:0]RAM_NEXT_STATE[0:31];
reg [7:0] CURRENT_STATE_G;
reg [3:0] CHARA;
reg [7:0] NEXT_STATE;
initial $readmemh("current_state_goto.txt", RAM_CURRENT_STATE_G);
initial $readmemh("chara_goto.txt", RAM_CHARA);
initial $readmemh("next_state_goto.txt", RAM_NEXT_STATE);


always @(posedge CLK)
  begin
    /*
    if (~RST)
      GOTO_DATA <= 11'h0;
    else
      GOTO_DATA <= ROM[ADDR];
      CURRENT_STATE_G <= GOTO_DATA[19:12];
      CHARA <= GOTO_DATA[11:8];
      NEXT_STATE <= GOTO_DATA[7:0];
      */
     if (RST)
      CURRENT_STATE_G <= RAM_CURRENT_STATE_G[ADDR_G];
      CHARA <= RAM_CHARA[ADDR_G];
      NEXT_STATE <= RAM_NEXT_STATE[ADDR_G];
  end
  endmodule
