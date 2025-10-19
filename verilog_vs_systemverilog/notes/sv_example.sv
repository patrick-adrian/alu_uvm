// | Feature                                      | What it does                                                                |
// | -------------------------------------------- | --------------------------------------------------------------------------- |
// | **Classes / OOP**                            | Enables reusable, modular testbenches                                       |
// | **Randomization**                            | Randomly generate inputs for stress testing                                 |
// | **Constraints**                              | Limit randomization to legal values                                         |
// | **Functional Coverage**                      | Track which scenarios have been tested                                      |
// | **Mailboxes / Semaphores / Events**          | For testbench synchronization                                               |
// | **UVM (Universal Verification Methodology)** | A framework built on SystemVerilog OOP features for large-scale testbenches |

class Packet;
  rand bit [7:0] addr;
  rand bit [15:0] data;
  constraint valid_addr { addr < 200; }
endclass

Packet p = new();
if (p.randomize()) $display("Addr=%0d, Data=%0h", p.addr, p.data);

// Random yet legal input data for testbench automatically

// | Feature       | Verilog                                | SystemVerilog                              |
// | ------------- | -------------------------------------- | ------------------------------------------ |
// | Data types    | `wire`, `reg`                          | `logic`, `bit`, `byte`, `int`, `enum`      |
// | Always blocks | `always @(*)`, `always @(posedge clk)` | `always_comb`, `always_ff`, `always_latch` |
// | FSM states    | Numeric params                         | `enum` types                               |
// | Structures    | No                                     | `struct`, `union`, `typedef`               |
// | Interfaces    | No                                     | Yes                                        |
// | Assertions    | No                                     | Yes (SVA)                                  |
// | Verification  | Manual                                 | OOP, Randomization, Coverage, UVM          |