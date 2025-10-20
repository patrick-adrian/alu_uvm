module alu (
    input [7:0] a, b, 
    input [2:0] op,
    output reg [7:0] result
) ;

always @(*) begin
    case (op)
        3b'000: result = a + b;
        3b'001: result = a - b;
        3b'010: result = a & b;
        3b'011: result = a | b;
        3b'100: result = a ^ b;
        default result = 8b'0;
    endcase  
end

endmodule

// testbench

module tb_alu;
