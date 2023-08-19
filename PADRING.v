module PADRING #(parameter gpio_width = 15,
                data_width = 15) (
    inout [gpio_width-1 : 0]gpio,
    inout gpio_ctrl,
    input   [data_width-1 : 0]padring_IN,
    output  [data_width-1 : 0]padring_OUT
);

    // Control Pad
    wire Y;
    PADBIDIR dut1 (.PAD(gpio_ctrl), .IE(1'b1), .OE(1'b0), .Y(Y), .A(1'b0));
    
    // Pads instantiated
    genvar i;
    generate 
        for (i = 0; i < gpio_width; i++)
        begin : dut_pad
            PADBIDIR dut (.PAD(gpio[i], .IE(~Y), .OE(Y), .Y(padring_OUT[i]), .A(padring_IN[i]));
        end
    endgenerate

endmodule
