class alu_sequence extends uvm_sequence #(alu_transaction);
    `uvm_object_utils(alu_sequence)

    virtual task body();
        alu_transaction tr = alu_transaction::type_id::create("tr");
        assert(tr.randomize());       // Randomize inputs
        start_item(tr);               // Handshake with driver
        finish_item(tr);              // Transaction complete
    endtask
endclass
/*
Key Points:
Controls stimulus generation.
Can loop for multiple transactions (repeat(10)).
Explains start_item / finish_item handshake with driver.
*/