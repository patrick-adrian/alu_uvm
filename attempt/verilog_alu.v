module alu (
    input [7:0] a,b,
    input [2:0] op,
    output reg [7:0] result
); 

always @(*) begin
    case (op)
        3'b000: result = a + b;
        3'b001: result = a - b;
        3'b010: result = a & b;
        3'b011: result = a | b;
        3'b100: result = a ^ b;
        default: result = 8'd0; 
    endcase 
end 

endmodule

// testbench
module tb_alu;
    reg [7:0] a, b;
    reg [2:0] op;
    wire [7:0] result;

    alu dut (.a(a), .b(b), .op(op), .result(result));

    initial begin
        $monitor(...)
        a = 8'd10; b = 8'd3;

        op = 3'b000; #10;

    end 

endmodule
