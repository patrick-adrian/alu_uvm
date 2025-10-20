`include "uvm_macros.svh"
import uvm_pkg::*;

module tb_top;
    logic clk = 0;
    always #5 clk = ~clk;

    alu_if alu_if_inst(clk);
    alu dut (.a(alu_if_inst.a), .b(alu_if_inst.b), .op(alu_if_inst.op), .result(alu_if_inst.result));

    initial begin
        run_test("alu_test");
    end
endmodule
