:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(random),[random/3]).

:- consult("utils/input_match.pl").
:- consult("utils/tokenizer.pl").

:- consult("nlu/intents.pl").

:- consult("vocabulary/syntaxes.pl").

% URL handlers.
:- http_handler('/answer', get_answer, [method(post)]).


% get_answer(+Request)
% Handler which gives an answer and its details
get_answer(Request) :-
    http_read_json_dict(Request, Query),
    find_answer(Query, Solution),
    reply_json_dict(Solution).

% find_answer(+Message,-Json)
% Send an JSON with answer and details
find_answer(_{message:Message}, _{message:Message, answer:Answer, intent:Showintent, slots:Showslots}) :-
    split_string(Message, " ", "", MessageAtom),
    find_utterance_and_answer(MessageAtom,_,Newcontext,Intent,Slots),
    Answer=Newcontext,
	Showslots=Slots,
    Showintent=Intent.

% find_utterance_and_answer(+Input,-Context,-Newcontext,-NI,-S)
% Find a rule that matches the input and give the response or a random response
find_utterance_and_answer(Input,Context,Newcontext,NI,S):-
    intent(I),
    member(utterance(U),I),
	tokenize(U,UTokenized),
	input_match(UTokenized,Input),
	member(answer(A),I),
    member(name_intent(NI),I),
	member(slots(S),I),
	create_response(A,Context,Newcontext).

% create_response(+Template,+Context,-Response)
% get the response depending on the Context
create_response([],_,[]).

% get response randomly from a list
create_response([random(Randomlist)|T],Context,Finalresponse):-
	!,
	length(Randomlist,Length),
	random(0,Length,Random),
	nth0(Random,Randomlist,Chosenlist),
	create_response(Chosenlist,Context,Listresponse),
	create_response(T,Context,Tresponse),
	append(Listresponse,Tresponse,Finalresponse).

% get the default response
create_response([H|T],Context,Finalresponse):-
	H = [_|_],
	!,
	create_response(H,Context,Hresponse),
	create_response(T,Context,Tresponse),
	append(Hresponse,Tresponse,Finalresponse).

create_response([H|T],Context,[H|Tresponse]):-
	create_response(T,Context,Tresponse).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).

:- initialization(server(8000)).
