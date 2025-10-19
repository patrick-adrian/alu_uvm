// SystemVerilog: Object-Oriented + Randomized Testbench

//---------------- DUT (same) ----------------
// Note: using always_comb instead of always @(*)
module alu (
  input  [7:0] a, b,
  input  [2:0] op,
  output reg [7:0] result
);
  always_comb begin // ✅ clearer intent (combinational)
    case (op)
      3'b000: result = a + b;
      3'b001: result = a - b;
      default: result = 8'h00;
    endcase
  end
endmodule


//---------------- INTERFACE ----------------
// ✅ NEW FEATURE: Interfaces group related signals
// Makes connecting DUT and testbench much cleaner
interface alu_if(input logic clk);
  logic [7:0] a, b;
  logic [2:0] op;
  logic [7:0] result;
endinterface


//---------------- TRANSACTION CLASS ----------------
// ✅ NEW FEATURE: Class + randomization
// Defines one operation (a, b, op, result) as an object
class alu_transaction;
  rand bit [7:0] a, b;      // randomizable operands
  rand bit [2:0] op;        // randomizable opcode
  bit [7:0] result;         // result observed

  // ✅ Constraints ensure valid random values
  constraint op_valid { op inside {3'b000, 3'b001}; }

  function void display();
    $display("a=%0d b=%0d op=%b => result=%0d", a, b, op, result);
  endfunction
endclass


//---------------- TESTBENCH ----------------
module tb_alu_sv;
  logic clk = 0;
  always #5 clk = ~clk; // simple clock

  // ✅ Interface simplifies DUT hookup
  alu_if alu_if1(clk);
  alu dut (.a(alu_if1.a), .b(alu_if1.b), .op(alu_if1.op), .result(alu_if1.result));

  alu_transaction tr;

  initial begin
    tr = new();

    // ✅ Randomized testing: run multiple automatic trials
    repeat (5) begin
      assert(tr.randomize());           // Random inputs generated
      alu_if1.a = tr.a; alu_if1.b = tr.b; alu_if1.op = tr.op;
      #10;
      tr.result = alu_if1.result;
      tr.display();                     // Self-print results
    end

    $finish;
  end
endmodule

// | **Feature**              | **Explanation**                                | **Benefit**                         |
// | ------------------------ | ---------------------------------------------- | ----------------------------------- |
// | `logic`                  | Unified signal type replacing `reg` and `wire` | No confusion about declaration type |
// | `always_comb`            | Safer replacement for `always @(*)`            | Detects missing signals             |
// | `interface`              | Groups DUT ports and reduces wiring            | Reusable connection wrapper         |
// | `class`                  | Encapsulates data & behavior (transaction)     | Object-oriented structure           |
// | `rand` + `constraint`    | Randomized stimulus                            | Automatic coverage of corner cases  |
// | `assert(tr.randomize())` | Built-in randomization engine                  | Easier to generate valid patterns   |
// | `function display()`     | Encapsulated printing for clarity              | Reuse across testbenches            |
// | `repeat()`               | Looping test automation                        | More data in fewer lines            |

// | Concept              | Verilog      | SystemVerilog                   |
//  -------------------- | ------------ | ------------------------------- |
// | **Test style**       | Manual       | Randomized & object-based       |
// | **Signal handling**  | reg/wire     | logic & interfaces              |
// | **Design block**     | always @(*)  | always_comb                     |
// | **Reusability**      | None         | Partial (classes/interfaces)    |
// | **Stimulus control** | Hand-coded   | Randomized with constraints     |
// | **Self-checking**    | Manual print | Can add functions/assertions    |
// | **Scalability**      | Poor         | Moderate                        |
// | **Use case**         | Small RTLs   | Medium designs or pre-UVM setup |
