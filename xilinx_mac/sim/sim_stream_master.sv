////////////////////////////////////////////////////////////////////////////////
// CONFIDENTIAL and PROPRIETARY software of Magewell Electronics Co., Ltd.
// Copyright (c) 2011-2016 Magewell Electronics Co., Ltd. (Nanjing)
// All rights reserved.
// This copyright notice MUST be reproduced on all authorized copies.
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module sim_stream_master(
	clk_i,
	rst_i,

  // stream master
  m_axis_valid_o,
  m_axis_data_o,
  m_axis_keep_o,
  m_axis_vldb_o,
  m_axis_sop_o,
  m_axis_eop_o,
  m_axis_err_o,
  m_axis_ready_i
);
  ///////////////////////////////////////////////////////////////////////////////
  // Include
function integer clog2(
		input integer data_i
	);
	begin
		for (clog2 = 0; data_i > 0; clog2 = clog2 + 1)
			data_i = data_i >> 1;
	end
endfunction
`define _bit_width(a)			clog2(a)
  // Parameters
	// parameter               WHOLE_PACKET_MODE           = 1;//设置为1时，输出一包过程中valid不会拉低；否则valid会在任意时刻拉低
	parameter							    DATA_W						= 64;
	localparam							  DATA_BE_W					= DATA_W/8;
  localparam							  DATA_BE_BIT				= `_bit_width(DATA_BE_W - 1);

	// Ports
	input				clk_i;
	input				rst_i;

	// stream master
	output	reg 							      m_axis_valid_o;
	output	reg [DATA_W-1:0]				m_axis_data_o;
	output	reg [DATA_BE_W-1:0]			m_axis_keep_o;
	output	    [DATA_BE_BIT-1:0]	  m_axis_vldb_o;
	output	reg 							      m_axis_sop_o;
	output	reg 							      m_axis_eop_o;
	output	reg 							      m_axis_err_o;
	input									          m_axis_ready_i;

	// Tasks
	typedef logic [7:0] q_pkt_t[$];
	logic 	[DATA_W-1:0]  		buf_data;
	logic 	[DATA_BE_W-1:0]  	buf_keep;
	q_pkt_t stream;

	enum integer { IDLE, SEND_DATA, DONE } send_state;
	task write(q_pkt_t stream_in);
		// int packet_size = stream_in.size();
		begin
			while(send_state != IDLE) begin
				@(posedge clk_i);
			end
			stream = stream_in;
			@(posedge clk_i);
			@(posedge clk_i);
		end
	endtask


	always @(posedge clk_i or posedge rst_i) begin
		if(rst_i) begin
			send_state      <= IDLE;
			m_axis_valid_o	<= 1'b0;
			m_axis_data_o	  <= {DATA_W{1'b0}};
			m_axis_keep_o	  <= {DATA_BE_W{1'b0}};
			m_axis_sop_o	  <= 1'b0;
			m_axis_eop_o	  <= 1'b0;
			m_axis_err_o    	<= 1'b0;
		end else begin
			case(send_state)
				IDLE : begin
					if(stream.size() > 0) begin
						send_state	<= SEND_DATA;
						m_axis_valid_o	<= 1'b1;
			      m_axis_sop_o	  <= 1'b1;
			m_axis_err_o    	<= 1'b0;
						if(stream.size() > DATA_BE_W) begin

							buf_data	= {DATA_W{1'b0}};
							for(int i = 0; i < DATA_BE_W ; i = i + 1) begin
								buf_data[i*8 +: 8] = stream[i];
							end
							m_axis_data_o	<= buf_data;
							m_axis_keep_o	<= {DATA_BE_W{1'b1}};
							m_axis_eop_o	<= 1'b0;
						end else begin
							m_axis_eop_o	<= 1'b1;
							buf_keep 	= {DATA_BE_W{1'b0}};
							for(int i = 0; i < stream.size() ; i = i + 1) begin
								buf_keep[i] = 1'b1;
							end
							m_axis_keep_o	<= buf_keep;
							buf_data	= 64'h0;
							foreach(stream[i]) begin
								buf_data[i*8 +: 8] = stream[i];
							end
							m_axis_data_o	<= buf_data;
						end
					end else begin
						m_axis_valid_o	<= 1'b0;
						m_axis_data_o	  <= 64'b0;
						m_axis_keep_o	  <= 8'b0;
			      m_axis_sop_o	  <= 1'b0;
						m_axis_eop_o	  <= 1'b0;
					end
				end
				SEND_DATA : begin
					// m_axis_valid_o	<= ({$random} % 2) > 0;
					m_axis_err_o	<= ({$random} % 3) > 1;
					if(m_axis_ready_i & m_axis_valid_o) begin
					  m_axis_sop_o	  <= 1'b0;
						if(stream.size() > DATA_BE_W) begin
							repeat(DATA_BE_W) begin
								stream.pop_front();
							end
						end else begin
							stream.delete();
						end
						if(stream.size() > DATA_BE_W) begin
							buf_data	= {DATA_W{1'b0}};
							for(int i = 0; i < DATA_BE_W ; i = i + 1) begin
								buf_data[i*8 +: 8] = stream[i];
							end
							m_axis_data_o	<= buf_data;
							m_axis_keep_o	<= {DATA_BE_W{1'b1}};
							m_axis_eop_o	<= 1'b0;
						end else if(stream.size() == 0) begin
							m_axis_valid_o	<= 1'b0;
							m_axis_data_o	<= {DATA_W{1'b0}};
							m_axis_keep_o	<= {DATA_BE_W{1'b0}};
							m_axis_eop_o	<= 1'b0;
							send_state		<= DONE;
						end else begin
							m_axis_eop_o	<= 1'b1;
							// m_axis_err_o    <= 1'b1;
							buf_keep 	= {DATA_BE_W{1'b0}};
							for(int i = 0; i < stream.size() ; i = i + 1) begin
								buf_keep[i] = 1'b1;
							end
							m_axis_keep_o	<= buf_keep;
							buf_data	= {DATA_W{1'b0}};
							foreach(stream[i]) begin
								buf_data[i*8 +: 8] = stream[i];
							end
							m_axis_data_o	<= buf_data;
						end
					end
				end

				DONE : begin
					send_state <= IDLE;
					m_axis_valid_o	<= 1'b0;
					m_axis_data_o	  <= {DATA_W{1'b0}};
					m_axis_keep_o	  <= {DATA_BE_W{1'b0}};
					m_axis_sop_o	  <= 1'b0;
					m_axis_eop_o	  <= 1'b0;

				end
			endcase
		end
	end

	function logic [DATA_BE_BIT-1 : 0] keep2vldb;
		input [DATA_BE_W-1 : 0] keep;
		logic [DATA_BE_W-1 : 0] r_keep;
		integer count;
		begin
			r_keep = keep;
			count = 0;
			while(r_keep[0] == 1'b1) begin
				count += 1;
				r_keep = {1'b0, r_keep[DATA_BE_W-1 : 1]};
			end
			count -= 1;
			return count[DATA_BE_BIT-1 : 0];
		end
	endfunction
	assign  m_axis_vldb_o = keep2vldb(m_axis_keep_o);

endmodule

