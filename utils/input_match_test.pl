:- consult(input_match).
greet --> ["bonjour"];["salut"];["slt"].

:- begin_tests(input_match).

test(input_match_empty)  :- input_match([],[]).

test(input_match_syntax)  :- input_match([star(_),syntax(greet,_),star(_)],["bonjour"]).

test(input_match_fail, [fail])  :- input_match([star(_),syntax(greet,_),star(_)],["bonjur"]).

:- end_tests(input_match).

:- run_tests.