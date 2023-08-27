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

    // Declaring Nets
    reg [gpio_width-1:0] out_t_net;
    reg [gpio_width-1:0] A_t_net;
    reg [gpio_width-1:0] pdr_OUT_net;

    // Pads instantiated
    genvar i;
    generate 
        for (i = 0; i < gpio_width; i++)
        begin : dut_pad
            if (Y_TMode)
            begin
                out_t_net[i] = pdr_OUT_net[i];
                A_t_net[i]   = in_t[i]
            end
            else
            begin
                out_t_net[i] = 1'b0;
                A_t_net[i]   = pdr_IN[i];
            end

          PADBIDIR gpio (
              .PAD(gpio[i]), 
              .IE(~Y_pad_ctrl), 
              .OE(Y_pad_ctrl), 
              .Y(pdr_OUT_net[i]),
              .A(A_t_net[i])
          );
        end
    endgenerate

    assign out_t  [gpio_width-1:0] = out_t_net  [gpio_width-1:0];
    assign pdr_OUT[gpio_width-1:0] = pdr_OUT_net[gpio_width-1:0];

endmodule
