input_match([],[]).

input_match([H|T],[H|T2]):-
	input_match(T,T2).

input_match([star([])|T],Input):-
	input_match(T,Input).

input_match([star([H|TStar])|T],[H|T2]):-
	input_match([star(TStar)|T],T2).

input_match([syntax(Syncat,Match)|T],Input):-
	PredCall =.. [Syncat,Input,Rest],
	call(PredCall),
	append(Match,Rest,Input),
	input_match(T,Rest).

input_match([syntax(Syncat,Match,Features)|T],Input):-
	append([Syncat|Features],[Input,Rest],PredCallList),
	PredCall =.. PredCallList,
	call(PredCall),
	append(Match,Rest,Input),
	input_match(T,Rest).