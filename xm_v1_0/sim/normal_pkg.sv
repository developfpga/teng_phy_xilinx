

package normal_pkg;

  typedef logic [7:0] q_pkt_t[$];
  typedef int q_int_t[$];


	function q_pkt_t string2bq;
		input string string_in;
		automatic q_pkt_t q = {};
		automatic integer len = 0;
		automatic integer i = 0;
		begin
			len = string_in.len();
			if(string_in.len() % 2 != 0) begin
				$display("error : function string2bq input string is not even , len is %d", string_in.len() );
				return q;
			end
			while(i < len/2) begin
				q.push_back(string_in.substr(i*2,i*2+1).atohex());
				i = i + 1;
			end
			return q;
		end
	endfunction

  function int ramdom_int();
    begin
      ramdom_int = {$random};
    end
  endfunction

  function logic [7:0] ramdom_bytes();
    begin
      ramdom_bytes = {$random} % 256;
    end
  endfunction

  function int random_between(int min, int max);
    begin
      random_between = min+{$random}%(max-min+1);
    end
  endfunction

  function integer clog2(
      input integer data_i
    );
    begin
      for (clog2 = 0; data_i > 0; clog2 = clog2 + 1)
        data_i = data_i >> 1;
    end
  endfunction

endpackage
