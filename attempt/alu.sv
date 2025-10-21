module alu (
    input logic [7:0] a,b;
    input logic [2:0] op;
    output logic [7:0] result;
    )

    always_comb begin
        case (op)
            3'b000: result = a-b;
            3'b001: result = a+b;
            default: result = 8'd0;
        endcase 
    end 
endmodule 

class ALU_transaction;
    rand bit [7:0] a, b;
    rand bit [2:0] op;
    bit [7:0] expected;

    function void calc_expected();
        case (op)
            3'b000: expected = a+b;
        endcase 
    endfunction 

endclass 

module alu_tb();
    logic [7:0] a,b;
    logic [2:0] op;
    logic [7:0] result;

    alu dut (.a(a), .b(b), .op(op), .result(result));

    ALU_Transaction tr;

    initial begin
        tr = new();
        repeat (5) begin
            assert(tr.randomize())
            tr.calc_expected();

            a = tr.a; b = tr.b; op=tr.op;
            #1;

            assert(result == tr.expected)
                else $error("Mismatch: a=%0d, b=%0d, op=%0b, result=%0d, expected=%0d", a,b,op,result,tr.expected);
            $display("all tests passed");
            $finish;
        end 
    end 
endmodule