module chip_top #(parameter gpio_width = 15,
                  data_width = 15)(
    inout [gpio_width-1 : 0]  gpio,
    inout                     gpio_ctrl
);

    wire [data_width-1 : 0]in_net, out_net;
    PADRING dut1 (.gpio(gpio), .gpio_ctrl(gpio_ctrl), .padring_OUT(in_net), .padring_IN(out_net));


endmodule
