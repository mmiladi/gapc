// Demonstrates a simple recursion in the grammar. The empty
// input string is also accepted


signature test (alphabet, answer) {
	answer nil (void);
	answer right (answer, alphabet);
	answer left (alphabet, answer);
	answer pair (alphabet, answer, alphabet);
	choice [answer] h ([answer]);
}


algebra testAlg1 implements test (alphabet = char, answer = string) {
	string nil (void) {
		string str;
		return str;
	}
	string right (string str, char c) {
		string res;
		string dummy;
		dummy = str;
		append (res, dummy);
		append (res, '.'); 
		return res;
	}
	string left (char c, string str) {
		string res;
		append (res, c); 
		append (res, str);
		return res;
	}
	string pair (char c1, string str, char c2) {
		string res;
		append (res, '('); 
		append (res, str);
		append (res, ')'); 
		return res;
	}
	choice [string] h ([string]l) {
		return l;
	}
}


algebra cntAlg auto count;
algebra enumAlg auto enum;


grammar test uses test (axiom = sequence) {
	sequence =	nil (EMPTY)		|
				non_nil_seq		# h;
	non_nil_seq = 	right (sequence, CHAR)			|
					left (CHAR, sequence)			|
					pair (CHAR, sequence, CHAR)	with char_basepairing	# h;
}


instance testInst = test (testAlg1);
instance countInst = test (cntAlg);
