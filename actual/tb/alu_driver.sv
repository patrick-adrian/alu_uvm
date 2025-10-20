class alu_driver extends uvm_driver #(alu_transaction);
    `uvm_component_utils(alu_driver)
    virtual alu_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        alu_transaction tr;
        forever begin
            seq_item_port.get_next_item(tr);
            vif.a = tr.a;
            vif.b = tr.b;
            vif.op = tr.op;
            #1; // wait for combinational logic
            tr.result = vif.result;
            seq_item_port.item_done();
        end
    endtask
endclass
