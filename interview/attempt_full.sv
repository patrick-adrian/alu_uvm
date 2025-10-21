module alu (
	input logic clk,
	input logic [7:0] a,b,
	input logic [2:0] op,
	output logic [7:0] result
)

	always_ff @(posedge clk) begin
		case(op)
			3'b000: result = a+b;
			3'b001: result = a-b;
			default: result = 8'd0;
		endcase
	end

endmodule

class alu_transaction extends uvm_sequence_item;
	
	'uvm_object_utils(alu_transaction)

	rand bit [7:0] a,b;
	rand bit [2:0] op;
	bit [7:0] expected;

	function new(string name="alu_transaction);
		super.new(name);
	endfunction
	
	constraint valid_ops {op inside {[0:4]};}
	
endclass

interface alu_if;
	logic [7:0] a,b,result;
	logic [2:0] op;
endinterface 

class alu_sequence extends uvm_sequence #(alu_transaction);
	'uvm_object_utils(alu_sequence)

	virtual task body();
		alu_transaction tr;
		assert(tr.randomize());
		start_item(tr);
		finish_item(tr);
	endtask		

endclass

class alu_driver extends uvm_driver #(alu_transaction);
	task run_phase(uvm_phase phase);
endclass

class alu_monitor extends uvm_monitor;
	task run_phase(uvm_phase phase);
endclass
	
class alu_scoreboard extends uvm_scoreboard;
	function void write(alu_transaction tr);

	endfunction
endclass
