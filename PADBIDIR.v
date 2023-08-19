module PADBIDIR (
    inout PAD,
    input IE,
    input OE,
    input A,
    output Y
);

    assign PAD = (OE) ? A : 1'bz;
    assign A   = (IE) ? Y : 1'bz;

endmodule

