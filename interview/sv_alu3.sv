module alu(
    input logic [7:0] a,b,
    input logic [2:0] op,
    output logic [7:0] result
);
    always_comb begin
        case(op)
            3'b000: result = a+b;
            3'b001: result = a-b;
            3'b010: result= a & b;
            3'b011: result = a | b;
            3'b100: result = a ^b;
            default: result = 8'd0;
        endcase
    end

endmodule 

class ALU_Transaction;
    rand bit [7:0] a,b;
    rand bit [2:0] op;
    bit [7:0] expected;

    constraint op_valid {op inside {0, 1,2,3};}
    constraint a_b_range {a<100; b<100;}


    function void calc_expected();
        case (op)
            3'b000: expected = a+b;
            3'b001: expected = a-b;
            3'b010: expected = a & b;
            3'b011: expected = a | b;
            3'b100: expected = a ^b;
        endcase
    endfunction 
endclass 

module tb_alu;
    logic [7:0] a,b;
    logic [2:0]  op;
    logic [7:0] result;

    ALU_Transaction tr;
    alu dut (.a(a), .b(b), .op(op), .result(result));

    initial begin
    tr = new();

    repeat (5) begin
        assert (tr.randomize());
        tr.calc_expected();
        a = tr.a; b=tr.b; op=tr.op;

        #1
        assert (result ==tr.expected);
        else $error("Mismatch")
    end
    $display("D")
    $finish
    end

endmodule