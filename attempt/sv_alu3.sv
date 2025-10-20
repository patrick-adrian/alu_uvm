module alu (
    input logic [7:0] a.b;
    input logic [2:0] op;
    output logic [7:0] result;
)

    always_comb begin
        case (op)
            3'b000: result = a+b;
            3'b001: result = a-b;
            default: result = 8'd0
        endcase 
    end

endmodule

class ALU_Transaction;
    rand bit [7:0] a, b;
    rand bit [2:0] op;
    bit [7:0] expected;

    function void calc_expected();
        case (op)
            3'b000: expected = a+b
        endcase

    endfunction

endclass

module alu_tb;
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
            a = tr.a; b =tr.b; op=tr.op;
            #1;
            assert(result == tr.expected)
                else $error("Misatch: a=%0d b=%0d", a,b);
        end 
        $display("All tests passed");
        $finish;
    end 
endmodule