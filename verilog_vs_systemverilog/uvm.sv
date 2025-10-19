// transaction
class alu_transaction extends uvm_sequence_item;
  rand bit [7:0] a, b;
  rand bit [2:0] op;
  bit [7:0] result;
  `uvm_object_utils(alu_transaction)
endclass

// Randomization and constraints
class alu_seq extends uvm_sequence #(alu_transaction);
  `uvm_object_utils(alu_seq)
  task body();
    alu_transaction tr = alu_transaction::type_id::create("tr");
    assert(tr.randomize() with { op inside {0,1,2,3}; });
    start_item(tr);
    finish_item(tr);
  endtask
endclass

//test many corner cases automatically