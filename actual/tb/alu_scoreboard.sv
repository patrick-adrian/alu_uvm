class alu_scoreboard extends uvm_component;
    `uvm_component_utils(alu_scoreboard)
    uvm_analysis_imp #(alu_transaction, alu_scoreboard) sb_imp;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        sb_imp = new("sb_imp", this);
    endfunction

    function void write(alu_transaction tr);
        bit [7:0] expected;
        case (tr.op)
            0: expected = tr.a + tr.b;
            1: expected = tr.a - tr.b;
            2: expected = tr.a & tr.b;
            3: expected = tr.a | tr.b;
        endcase
        if (tr.result !== expected)
            `uvm_error("ALU_MISMATCH", $sformatf("Got %0d, expected %0d", tr.result, expected))
        else
            `uvm_info("ALU_PASS", tr.convert2string(), UVM_LOW)
    endfunction
endclass
