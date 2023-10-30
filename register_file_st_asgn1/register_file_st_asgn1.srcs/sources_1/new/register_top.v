module register_top (
        input clk,
        input [4:0] rd_adr_1,
        input [4:0] rd_adr_2,
        input       rd_enb_1,
        input       rd_enb_2,
        input [4:0] wr_adr_1,
        input [4:0] wr_adr_2,
        input       wr_enb_1,
        input       wr_enb_2,
        input [31:0] data_write_2,
        input [15:0] data_write_1,
        output reg [31:0] data_read_2,
        output reg [15:0] data_read_1
        );
        
        // Declaring two memories 
        // 1. Size 4-bytes and depth 16
        // 2. Size 2-bytes and depth 16
        reg [15:0] mem1 [15:0];
        reg [31:0] mem2 [31:16];
        
        // Write at posedge of clk and read at negedge of clk
        // write for mem1
        wire wr_enb_1_int = wr_enb_1 & !(wr_adr_1 == 5'b01111) | (!wr_adr_1[4]);
        wire rd_enb_1_int = rd_enb_1 & (!rd_adr_1[4]);
        // write
        always @ (posedge clk)
        begin
            if (wr_enb_1_int)
                mem1 [wr_adr_1] <= data_write_1;
            else
                mem1 [wr_adr_1] <= mem1 [wr_adr_1];
        end
        // read
        always @ (negedge clk)
        begin
            if (rd_enb_1_int)
                data_read_1 <= mem1 [rd_adr_1];
            else
                data_read_1 <= 16'bz;
        end
        
        // Write at posedge of clk and read at negedge of clk
        // write for mem1
        wire wr_enb_2_int = wr_enb_2 & !(wr_adr_2 == 5'b11111) & (wr_adr_2[4]);
        wire rd_enb_2_int = rd_enb_2 & (rd_adr_2[4]);
        // write
        always @ (posedge clk)
        begin
            if (wr_enb_2_int)
                mem2 [wr_adr_2] <= data_write_2;
            else
                mem2 [wr_adr_2] <= mem2 [wr_adr_2];
        end
        // read
        always @ (negedge clk)
        begin
            if (rd_enb_2_int)
                data_read_2 <= mem2 [rd_adr_2];
            else
                data_read_2 <= 32'bz;
        end
        
        always @ (posedge clk)
        begin
            mem1 [15] <= mem1 [2] ^ mem1[1];
            mem2 [31] <= 32'b0010_0000_0000_0010_0000_0111_0011_0000;
        end

endmodule