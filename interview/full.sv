class alu_transaction extends uvm_sequence_item
	uvm_object_utils(alu_transaction)

	rand bit [7:0] a, b;
	rand bit [2:0] op;
	bit [7:0] result;

	function new(string name="alu_transaction");
		super.new(name);
	endfunction

	constraint op_valid {op inside {[0:3];}}
	constraint diff_inputs {a !=b; }
	constraint precedence {solve op before a;}
	constraint weights { op dist {0: 50, [1:4] : 10;}}
endclass

interface alu_if;
	logic [7:0] a,b;
	logic [2:0] op;
	logic [7:0] result;
endinterface 

class alu_sequence extends uvm_sequence #(alu_transaction)
	uvm_object_utils(alu_sequence)

	virtual task body();
		alu_transaction tr;
		assert(tr.randomize());
		start_item(tr);
		finish_item(tr);

	endtask
endclass

class alu_driver extends uvm_driver #(alu_transaction);
	virtual alu_if vf;

	task run_phase(uvm_phase phase);
		alu_transaction tr;
		forever begin;
			seq_item_port.get_next_item(tr);
			vif.a = tr.a; vif.b =tr.b; vif.op = tr.op;
			tr.result =vif.result;
			seq_item_port.item_done();
		end
	endtask
endclass

class alu_monitor extends uvm_monitor;
	uvm_component_utils(alu_monitor);
	virtual alu_if vif;

	uvm_analysis_port #(alu_transation) mon_ap;

	function new(string name, uvm_component parent);
		super.new(name, parent);
		mon_ap = new("mon_ap", this);
	endfunction

	task run_phase(uvm_phase phase);
		alu_transaction tr;
		forever begin
			tr.a = vif.a; tr.b = vif.b; tr.op = vif.op; tr.result = vif.result;
			mon_ap.write(tr);
		end
	endtask
endclass
	
class alu_scoreboard extends uvm_component;
	uvm_component_utils(alu_scoreboard)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void write(alu_transaction tr);
        bit [7:0] expected;
        case (tr.op)
            0: expected = tr.a + tr.b;
            1: expected = tr.a - tr.b;
        endcase
        if (tr.result !== expected)
            'uvm_error("ALU MISMATCH")
        else
            'uvm_info("ALU PASS")
        endfunction
endclass

class alu_test extends uvm_test;
	'uvm_component_utils(alu_test);
	alu_env env;
	alu_sequence seq;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
    endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	endtask
endclass

class alu_env extends uvm_env;
	'uvm_component_utils(alu_env);
	alu_agent agent;
	alu_scoreboard sb;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase();
    endfunction
	
endclass