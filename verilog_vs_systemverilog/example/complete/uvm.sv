//====================
// Level 3: UVM (Universal Verification Methodology)
//====================

// ALU DUT reused from before

//--------------------
// UVM Transaction
//--------------------
class alu_seq_item extends uvm_sequence_item;
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

    `uvm_object_utils(alu_seq_item)
endclass

//--------------------
// UVM Driver
//--------------------
class alu_driver extends uvm_driver #(alu_seq_item);
    virtual interface alu_if vif;

    function new(string name="alu_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        alu_seq_item tr;
        forever begin
            seq_item_port.get_next_item(tr);
            vif.a <= tr.a;
            vif.b <= tr.b;
            vif.op <= tr.op;
            #1;
            seq_item_port.item_done();
        end
    endtask
endclass

//--------------------
// UVM Environment (env + scoreboard omitted for brevity)
//--------------------
class alu_env extends uvm_env;
    // would instantiate driver, monitor, scoreboard here
    `uvm_component_utils(alu_env)
endclass

//--------------------
// UVM Test
//--------------------
class alu_test extends uvm_test;
    alu_env env;
    `uvm_component_utils(alu_test)

    function new(string name="alu_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        env = alu_env::type_id::create("env", this);
    endfunction
endclass

//--------------------
// Interface & Top Module
//--------------------
interface alu_if(input logic clk);
    logic [7:0] a, b;
    logic [2:0] op;
endinterface

module tb_top;
    logic clk = 0;
    always #5 clk = ~clk;

    alu_if alu_vif(clk);
    alu dut (.a(alu_vif.a), .b(alu_vif.b), .op(alu_vif.op), .result());

    initial begin
        run_test("alu_test");
    end
endmodule

/*
🟢 UVM adds:
✅ Complete modular verification structure (driver, monitor, scoreboard)
✅ Transaction-level communication (sequence items)
✅ Reusable testbench code across multiple projects
✅ Built-in factory pattern, reporting, and phases (build, connect, run)
✅ Professional-grade verification methodology used in industry

🔴 Complexity: Verbose and requires understanding of OOP & UVM macros
*/

//| Level | Language      | Key Additions                         | Why It Matters                              |
//| ----- | ------------- | ------------------------------------- | ------------------------------------------- |
//| 1️⃣   | Verilog       | RTL + manual testbench                | Simple, but not scalable                    |
//| 2️⃣   | SystemVerilog | OOP, assertions, randomization        | Modern verification-friendly syntax         |
//| 3️⃣   | UVM           | Full environment, reusable components | Industry-standard for ASIC/SoC verification |
