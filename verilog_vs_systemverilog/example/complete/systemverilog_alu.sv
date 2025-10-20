//====================
// Level 2: SystemVerilog — Adds OOP, Randomization, Assertions
//====================

// Same DUT (Verilog-compatible)
module alu (
    input  logic [7:0] a, b,
    input  logic [2:0] op,
    output logic [7:0] result
);
    always_comb begin
        case (op)
            3'b000: result = a + b;
            3'b001: result = a - b;
            3'b010: result = a & b;
            3'b011: result = a | b;
            3'b100: result = a ^ b;
            default: result = '0;
        endcase
    end
endmodule

//--------------------
// SystemVerilog Testbench
//--------------------
class ALU_Transaction;
    rand bit [7:0] a, b;
    rand bit [2:0] op;
    bit [7:0] expected;

    function void calc_expected();
        case (op)
            3'b000: expected = a + b;
            3'b001: expected = a - b;
            3'b010: expected = a & b;
            3'b011: expected = a | b;
            3'b100: expected = a ^ b;
        endcase
    endfunction
endclass

module tb_alu_sv;
    logic [7:0] a, b;
    logic [2:0] op;
    logic [7:0] result;

    alu dut (.a(a), .b(b), .op(op), .result(result));

    ALU_Transaction tr;

    initial begin
        tr = new();
        repeat (5) begin
            assert(tr.randomize());
            tr.calc_expected();

            a = tr.a; b = tr.b; op = tr.op;
            #1;
            assert(result == tr.expected)
                else $error("Mismatch: a=%0d b=%0d op=%b result=%0d expected=%0d", a,b,op,result,tr.expected);
        end
        $display("All tests passed.");
        $finish;
    end
endmodule

/*
🟢 SystemVerilog adds:
✅ `logic` type → no need to decide between wire/reg
✅ `always_comb` → automatically detects sensitivity list
✅ Classes & randomization (object-oriented testbench)
✅ Assertions (`assert`) and functional coverage support
✅ Reusable testbench structure — step toward UVM
*/
