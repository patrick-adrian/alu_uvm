alu_transaction tr;

tr.a = vif.a; tr.b =vif.b; tr.op =vif.op; tr.result = vif.result

mon_ap.write(tr);


//scoreboard
expected = (tr.op==0)? tr.a+tr.b : (tr.op==1)? tr.a-tr.b;

if(tr.result !== expected) $display("ERROR");
else $display("PASS");