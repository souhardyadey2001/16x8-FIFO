module tb_fifo();
reg clk,rst,we,re;
wire empty,full;
reg [7:0] data_in;
wire [7:0] data_out;

fifo_16_8 DUT (clk,rst,we,re,data_in,empty,full,data_out);

task initialize();
begin
clk = 1'b0;
rst = 1'b0;
we = 1'b0;
re = 1'b0;
end
endtask

always #10 clk = ~clk;

task rst_dut();
begin 
@(negedge clk)
rst = 1'b1;
@(negedge clk)
rst = 1'b0;
end
endtask

task write_fifo (input [7:0] data);
begin
@(negedge clk)
we = 1'b1;
data_in = data; 
end
endtask

task read_fifo();
begin
@(negedge clk)
re = 1'b1;
end
endtask

initial
begin
initialize;
rst_dut;
repeat(17)
write_fifo({$random}%8);
we = 1'b0;
repeat(17)
read_fifo();
re = 1'b0;
end
endmodule

