module PADRING #(parameter gpio_width = 15,
                data_width = 15) (
    inout   [gpio_width-1 : 0]gpio,
    inout   gpio_ctrl,
    inout   pad_tm,
    input   [data_width-1 : 0]pdr_IN,
    input   [data_width-1 : 0]in_t,
    output  [data_width-1 : 0]pdr_OUT,
    output  [data_width-1 : 0]out_t
);

    // Control Pad
    wire Y_pad_ctrl;
    PADBIDIR pad_ctrl (.PAD(gpio_ctrl), .IE(1'b1), .OE(1'b0), .Y(Y_pad_ctrl), .A(1'b0));

    // TMode PADBIDIR
    wire Y_TMode; 
    PADBIDIR Tmode (.PAD(pad_tm), .IE(1'b1), .OE(1'b0), .Y(Y_TMode), .A(1'b0));
    
    // Pads instantiated
    genvar i;
    generate 
        for (i = 0; i < gpio_width; i++)
        begin : dut_pad
          PADBIDIR gpio (.PAD(gpio[i]), .IE(~Y_pad_ctrl), .OE(Y_pad_ctrl), .Y(pdr_OUT[i]), .A((pdr_IN[i] & ~Y_TMode) | (in_t[i] & Y_TMode)));
        end
    endgenerate

  assign out_t[14:0] = pdr_OUT[data_width-1 : 0] & Y_TMode;

endmodule
