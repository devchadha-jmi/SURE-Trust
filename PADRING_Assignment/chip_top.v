module chip_top #(parameter gpio_width = 15,
                  data_width = 15)(
    inout [gpio_width-1 : 0]  gpio,
    inout                     pad_tm,
    inout                     gpio_ctrl
);

    wire [data_width-1 : 0]in_net_tmode, out_net_tmode;
    wire [data_width-1 : 0]in_net_pdr, out_net_pdr;

    PADRING dut1 (
        .gpio(gpio),
        .gpio_ctrl(gpio_ctrl),
        .pad_tm(pad_tm),
        .out_t(in_net_tmode),
        .pdr_OUT(in_net_pdr),
        .in_t(out_net_tmode),
        .pdr_IN(out_net_pdr)
    );
    
    empty dut2 (
        .IN(in_net), 
        .OUT(out_net),
        .IN_T(in_net_tmode),
        .OUT_T(out_net_tmode)
    );

endmodule
