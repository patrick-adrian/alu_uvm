class alu_monitor extends uvm_monitor;
    `uvm_component_utils(alu_monitor)
    virtual alu_if vif;
    uvm_analysis_port #(alu_transaction) mon_ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        mon_ap = new("mon_ap", this);
    endfunction

    task run_phase(uvm_phase phase);
        alu_transaction tr;
        forever begin
            tr = alu_transaction::type_id::create("tr");
            tr.a = vif.a;
            tr.b = vif.b;
            tr.op = vif.op;
            tr.result = vif.result;
            mon_ap.write(tr);
            #5;
        end
    endtask
endclass
