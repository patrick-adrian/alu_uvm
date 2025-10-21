class alu_driver extends uvm_driver #(alu_transaction);
    virtual alu_if vif;

    task run_phase(uvm_phase phase);
        alu_transaction tr;
        forever begin
            seq_item_port.get_next_item(tr);
            vif.a = tr.a; vif.b=tr.b; vif.op=tr.op;
            tr.result = vif.result;
            seq_item_port.item_done()
        end
    endtask 
endclass 