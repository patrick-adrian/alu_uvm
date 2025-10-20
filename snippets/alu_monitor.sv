// Monitor observes DUT and sends transaction to scoreboard
alu_transaction tr;
tr.a = vif.a; tr.b = vif.b; tr.op = vif.op; tr.result = vif.result;
mon_ap.write(tr);

// Scoreboard compares DUT output
expected = (tr.op==0)? tr.a+tr.b : (tr.op==1)? tr.a-tr.b : (tr.op==2)? tr.a&tr.b : tr.a|tr.b;
if(tr.result !== expected) $display("ERROR: got %0d expected %0d", tr.result, expected);
else $display("PASS: %s", tr.convert2string());

/*
Key Points:
Monitor is read-only, sends to scoreboard via analysis_port.
Scoreboard implements functional correctness check.
*/