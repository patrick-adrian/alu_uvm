class alu_sequence extends uvm_sequence #(alu_transaction)
    uvm_object_utils(alu_sequence)

    virtual task body();
        alu_transaction tr = alu_transaction::type_d::create("tr");
        assert(tr.randomize());
        start_item(tr);
        finish_item(tr);
    endtask 
endclass 