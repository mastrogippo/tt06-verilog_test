/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = {2'b00,E,data};  // ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;
  reg E;

    
    always @(posedge clk) begin
        if (!rst_n) begin
            counter <= 0;
            seq <= 0;
            data <= 0;
            E <= 1'b1;
        end
        else begin
        counter <= counter + 1'b1;
        if (counter == 6'b0) begin
        //if (1) begin
            E <= 1'b1;
            seq <= seq + 1'b1;
            case(seq)
                // Switch to 4 bit mode
                4'd0 : data <= 5'b00011;
                4'd1 : data <= 5'b00010;

                // Display on
                4'b0010 : data <= 5'b00000;
                4'b0011 : data <= 5'b01110;

                // Write H
                4'b0100 : data <= 5'b10100;
                4'b0101 : data <= 5'b11000;

                // Write e
                4'b0110 : data <= 5'b10110;
                4'b0111 : data <= 5'b10101;

                // Write H
                4'b1000 : data <= 5'b10100;
                4'b1001 : data <= 5'b11000;

                // Some dummy data
                4'b1010 : data <= 5'b10000;

                default : begin
                    // don't send any further data
                    E   <= 1'b0;
                    seq <= seq;
                end
            endcase
        end else
        begin
            E <= 1'b0;
        end
        end
    end
endmodule
