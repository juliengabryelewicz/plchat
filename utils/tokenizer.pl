tokenize([],[]):-
	!.

tokenize(Input,Input):-
	!.

tokenize([star(A)|T],[star(A)|Tokenized]):-
	!,
	tokenize(T,Tokenized).

tokenize([syntax(A,B)|T],[syntax(A,B)|Tokenized]):-
	!,
	tokenize(T,Tokenized).

tokenize([Atom|T],Tokens):-
	atomic(Atom),
	!,
	tokenize_atom(Atom,AtomTokens),
	tokenize(T,TTokens),
	append(AtomTokens,TTokens,Tokens).

tokenize_atom(Atom,List):-
	name(Atom,String),
	tokenize_string(String,List).

tokenize_string([],Atomics):-
	complete_string([],nil,end,Atomics).

tokenize_string([C|Tail],Atomics):-
	char_type(C,Type,Char),
	complete_string(Tail,Char,Type,Atomics).

complete_string(_,_,end,[]) :- !.

complete_string(B,_,blank,Atomics) :-
   !,
   tokenize_string(B,Atomics).

complete_string(B,FirstC,special,[A|Atomics]) :-
   !,
   name(A,[FirstC]),
   tokenize_string(B,Atomics).

complete_string(B,FirstC,alpha,[A|Atomics]) :-
   complete_string_word(B,BOut,FirstC,alpha,Word,NextC,NextT),
   name(A,Word),
   complete_string(BOut,NextC,NextT,Atomics).

complete_string_word([],[],FirstC,alpha,[FirstC|List],FollC,FollT) :-
   !,
   complete_string_word([],[],nil,end,List,FollC,FollT).

complete_string_word([C|BTail],BOut,FirstC,alpha,[FirstC|List],FollC,FollT) :-
   !,
   char_type(C,NextT,NextC),
   complete_string_word(BTail,BOut,NextC,NextT,List,FollC,FollT).

complete_string_word(B,B,FirstC,FirstT,[],FirstC,FirstT).