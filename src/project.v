/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_disp1 (
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



    //only for TT
    wire in1 = ui_in[0];
    wire in2 = ui_in[1];

    wire ine1 = ui_in[2];
    wire ine2 = ui_in[3];
    wire ine3 = ui_in[4];
    wire ine4 = ui_in[5];
    wire ine5 = ui_in[6];
    wire ine6 = ui_in[7];


wire [7:0] p = {2'b00, ine1, ine2, ine3, ine4, ine5, ine6};

    reg [5:0] counter = 6'h0;
    reg [7:0] seq = 7'h0;
    reg [4:0] data;

 wire[31:0] le0d = 32'b01101011011010110110100101001000;
 wire[31:0] le1d = 32'b01001110010110000101100001101001;
 wire[31:0] le2d = 32'b01011000010000110100001100100000;
 wire[31:0] le3d = 32'b01000011010010110101100101010111;
 wire[31:0] le4d = 32'b01001011010001000101111001101111;
 wire[31:0] le5d = 32'b01000100010001000100001101110010;
 wire[31:0] le6d = 32'b01000101010010110100101101101100;
 wire[31:0] le7d = 32'b00001010000010100100010001100100;
 wire[31:0] le8d = 32'b00001010000010100100010100100001;

 
wire [7:0] le0 = le0d[{in2, in1, 3'b000}+:8] ^ p;
 wire [7:0] le1 = le1d[{in2, in1, 3'b000}+:8] ^ p;
 wire [7:0] le2 = le2d[{in2, in1, 3'b000}+:8] ^ p;
 wire [7:0] le3 = le3d[{in2, in1, 3'b000}+:8] ^ p;
 wire [7:0] le4 = le4d[{in2, in1, 3'b000}+:8] ^ p;
 wire [7:0] le5 = le5d[{in2, in1, 3'b000}+:8] ^ p;
 wire [7:0] le6 = le6d[{in2, in1, 3'b000}+:8] ^ p;
 wire [7:0] le7 = le7d[{in2, in1, 3'b000}+:8] ^ p;
 wire [7:0] le8 = le8d[{in2, in1, 3'b000}+:8] ^ p;

    always @(posedge clk) begin
        if (!rst_n) begin
          //
            counter <= 0;
            seq <= 0;
            data <= 0;
            E <= 1'b1;
        end
        else begin
        counter <= counter + 1'b1;
        if (counter == 6'b0) begin
            E <= 1'b1;
            seq <= seq + 1'b1;
            case(seq)
                8'd0 : data <= 5'b00011;
                8'd1 : data <= 5'b00010;
                8'd2 : data <= 5'b00000;
                8'd3 : data <= 5'b01110;

8'd4 : data <= {1'b1 , le0[7:4]};                 8'd5 : data <= {1'b1 , le0[3:0]}; //5'b10100;
8'd6 : data <= {1'b1 , le1[7:4]};                 8'd7 : data <= {1'b1 , le1[3:0]}; //5'b10100;
8'd8 : data <= {1'b1 , le2[7:4]};                 8'd9 : data <= {1'b1 , le2[3:0]}; //5'b10100;
8'd10 : data <= {1'b1 , le3[7:4]};                 8'd11 : data <= {1'b1 , le3[3:0]}; //5'b10100;
8'd12 : data <= {1'b1 , le4[7:4]};                 8'd13 : data <= {1'b1 , le4[3:0]}; //5'b10100;
8'd14 : data <= {1'b1 , le5[7:4]};                 8'd15 : data <= {1'b1 , le5[3:0]}; //5'b10100;
8'd16 : data <= {1'b1 , le6[7:4]};                 8'd17 : data <= {1'b1 , le6[3:0]}; //5'b10100;
8'd18 : data <= {1'b1 , le7[7:4]};                 8'd19 : data <= {1'b1 , le7[3:0]}; //5'b10100;
8'd20 : data <= {1'b1 , le8[7:4]};                 8'd21 : data <= {1'b1 , le8[3:0]}; //5'b10100;
           
                // Write 1
                //8'd6 : data <= {1'b1 , le2[7:4]}; //
                //8'd7 : data <= {1'b1 , le2[3:0]}; //5'b10100;

                // Some dummy data
                8'd22 : data <= 5'b10000;

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
