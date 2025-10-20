class alu_driver extends uvm_driver #(alu_transaction);
    virtual alu_if vif;

    task run_phase(uvm_phase phase);
        alu_transaction tr;
        forever begin
            seq_item_port.get_next_item(tr); // Receive transaction from sequence
            vif.a = tr.a; vif.b = tr.b; vif.op = tr.op; // Drive DUT
            #1;
            tr.result = vif.result;           // Capture DUT output
            seq_item_port.item_done();
        end
    endtask
endclass

/*
Key Points:
Applies transaction to DUT.
virtual interface lets driver talk to DUT signals.
Use #1 or @(posedge clk) depending on DUT.
*/