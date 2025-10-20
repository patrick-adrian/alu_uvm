class alu_transaction extends uvm_sequence_item;
    rand bit [7:0] a, b;
    rand bit [1:0] op;
         bit [7:0] result;

    `uvm_object_utils(alu_transaction)

    function new(string name = "alu_transaction");
        super.new(name);
    endfunction

    constraint op_valid { op inside {0,1,2,3}; }

    function string convert2string();
        return $sformatf("a=%0d, b=%0d, op=%0d, result=%0d", a, b, op, result);
    endfunction
endclass
