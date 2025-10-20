class alu_agent extends uvm_agent;
    `uvm_component_utils(alu_agent)
    alu_driver drv;
    alu_monitor mon;
    virtual alu_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        drv = alu_driver::type_id::create("drv", this);
        mon = alu_monitor::type_id::create("mon", this);
    endfunction
endclass