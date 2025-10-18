interface alu_if(input logic clk);
    logic [7:0] a, b;
    logic [1:0] op;
    logic [7:0] result;
endinterface
