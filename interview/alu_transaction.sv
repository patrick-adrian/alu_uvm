class alu_transaction extends uvm_sequence_item
    'uvm_object_utils(alu_transaction)

    rand bit [7:0] a,b;
    rand bit [2:0] op;
    bit [7:0] result;

    function new(string name="alu_transaction");
        super.new(name);
    endfunction

    constraint op_valid {op inside {0,1,2,3};}
    constraint valid_ops { op inside {[0:4]}; }
    constraint diff_inputs { a != b; }
    constraint weighted_ops { op dist {0 := 50, [1:4] := 10}; }
    constraint precedence { solve op before a; }


    function string convert();
    return $sformatf
    endfunction 


endclass