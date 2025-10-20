class alu_transaction extends uvm_sequence_item

    'uvn_object_utils(alu_transaction) //register with uvm factory

    rand bit [7:0] a, b;
    rand bit [2:0] op;
    bit [7:0] result;

    //Constructor
    function new (string name ="alu_transaction");
        super.new(name)l //Call parent constructor
    endfunction
    
    //constraint to limit operat to valid 0-3
    constraint op_valid {op insde {0, 1,2,3}}

    //convenience function to conver transaction
    //to string for logging
     function string convert2string();
        return $sformatf("a=%0d, b=%0d, op=%0d, result=%0d", a, b, op, result);
    endfunction

endclass