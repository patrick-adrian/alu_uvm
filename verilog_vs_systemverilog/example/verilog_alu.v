// Verilog: Basic RTL + Procedural Testbench

//---------------- DUT: alu.v ----------------
// Simple 8-bit ALU with 2 operations
module alu (
  input  [7:0] a, b,
  input  [2:0] op,
  output reg [7:0] result
);
  // Traditional always block
  always @(*) begin
    case (op)
      3'b000: result = a + b; // ADD
      3'b001: result = a - b; // SUB
      default: result = 8'h00;
    endcase
  end
endmodule


//---------------- TESTBENCH: tb_alu.v ----------------
module tb_alu;
  reg  [7:0] a, b;      // test inputs
  reg  [2:0] op;
  wire [7:0] result;

  alu uut (.a(a), .b(b), .op(op), .result(result)); // connect DUT

  initial begin
    // Hardcoded tests: sequential, static
    a=5; b=3; op=3'b000; #10;
    $display("ADD result=%0d", result);

    a=9; b=2; op=3'b001; #10;
    $display("SUB result=%0d", result);

    $finish;
  end
endmodule
