//====================
// Level 1: Verilog - Classic RTL + Manual Testbench
//====================

// DUT: Basic ALU

//wire: a physical connection only assigned by continuous
//assignments, like assign
//doesn't hold value, carries what is driven to it

//reg: a storage element assigned by procedural
//assignments, like always or inital blocks
//holds value until explicitly changed
//= or <=

module alu (
    input  [7:0] a, b,
    //inputs are implicitly wire
    input  [2:0] op,
    output reg [7:0] result
);
    always @(*) begin
        case (op)
            3'b000: result = a + b;   // ADD
            3'b001: result = a - b;   // SUB
            3'b010: result = a & b;   // AND
            3'b011: result = a | b;   // OR
            3'b100: result = a ^ b;   // XOR
            default: result = 8'd0;
        endcase
    end
endmodule

//--------------------
// Simple Verilog Testbench
//--------------------
module tb_alu;

//since no ports in a testbench, no input or output here

    reg [7:0] a, b;
    reg [2:0] op;
    wire [7:0] result;

    //creating testbench instance
    alu dut (.a(a), .b(b), .op(op), .result(result));

    //procedural block
    initial begin

        //monitor is a system task that continously
        //prints values when any signals change

                //%0t prints simulation time
                        //%0d decimal format
                                    //%b binary format
        $monitor("time=%0t a=%0d b=%0d op=%b result=%0d", $time, a, b, op, result);
        a = 8'd10; b = 8'd3;

                    //#10: wait 10 time units
        op = 3'b000; #10;
        op = 3'b001; #10;
        op = 3'b010; #10;
        op = 3'b011; #10;
        op = 3'b100; #10;

        $finish;
    end
endmodule

/*
🟢 What Verilog provides:
- RTL description (registers, combinational logic)
- Manual testbench with direct stimulus
- Basic debugging ($monitor, $display)
🔴 Limitations:
- No randomization or reusable test structure
- No coverage metrics
- No object-oriented abstraction for complex designs
*/
