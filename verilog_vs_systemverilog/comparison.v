// 1. Stronger Data Types
// Verilog: wire, reg, integer, real
// logic: replaces wire/reg
// -used for both combinational/sequential signals
// bit: pure 2-state type
// -faster sim than including X/Z values

// 2. New Procedural Blocks
//always_comb, always_ff, always_latch

// Normal unclean way .v
always @(posedge clk)

// SystemVerilog .sv
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        count <= 0;
    else 
        count <= count + 1;
end

// 3. enum and typedef
typedef enum logic [1:0] {
  IDLE  = 2'b00,
  READ  = 2'b01,
  WRITE = 2'b10
} state_t;

state_t current_state, next_state;

// Improves readability, debugging
// waveform viewers will show names (IDLE, READ, WRITE)

// 4. Packed vs. Unpacked arrays

// Packed array = continuous bits (used for buses)
logic [7:0] byte_data; // packed, like an 8-bit bus

// Unpacked array = array of elements
logic [7:0] memory [0:15]; // 16 elements of 8-bit each

// makes SV more expressive for memory and signal modelling

// 5. Interfaces
interface bus_if(input logic clk);
  logic [7:0] addr, data;
  logic we;
endinterface

module cpu (bus_if bus);
  always_ff @(posedge bus.clk)
    if (bus.we) bus.data <= bus.addr;
endmodule

// simplifies wiring, avoids mistakes, supports verification

// 6. Assertions
assert property (@(posedge clk) req |-> ##1 gnt);

//“Whenever req happens, gnt must follow 1 cycle later.”