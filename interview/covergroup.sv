class alu_monitor extends uvm_monitor;
    virtual alu_if vif;
    covergroup alu_cov;
        coverpoint vif.op;
        coverpoint vif.result;
        cross vif.op, vif.result;
    endgroup

    function new(string name = "alu_monitor", uvm_component parent);
        super.new(name, parent);
        alu_cov = new();
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.clk);
            alu_cov.sample();
        end
    endtask
endclass

/*weighted
coverpoint op {
    bins add = {0};
    bins sub = {1};
    bins logic_ops[] = {2, 3} / 2; // weight 2
}
*/