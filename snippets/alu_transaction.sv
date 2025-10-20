class alu_transaction extends uvm_sequence_item;
    `uvm_object_utils(alu_transaction)

    rand bit [7:0] a, b;
    rand bit [1:0] op;
    bit [7:0] result;

    constraint op_valid { op inside {0,1,2,3}; }

    function new(string name="tr");
        super.new(name);
    endfunction
endclass

/*
Randomizable inputs (rand) → driver uses them to drive DUT.
Constraints limit valid operations (0-3).
result is captured from DUT.
Can explain why uvm_sequence_item is used (UVM standard for transactions).
*/