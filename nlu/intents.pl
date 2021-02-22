:- use_module(library(random),[random/3]).

intent([
    utterance([star(_),syntax(greet,_),star(_)]),
    name_intent("Salutation"),
    slots([]),
    answer([random([
        ["Bonjour, vous allez bien?"],
        ["Salut, tu vas bien?"]])])
    ]).

intent([
    utterance([star(_),syntax(hobbies,A),star(_)]),
    name_intent("Hobbies"),
    slots([hobbies,A]),
    answer([random([
        ["Oh, moi aussi!"],
        ["J'aime aussi la", A]])])
    ]).

% intent si on ne reconnait pas la phrase (doit toujours être en bas de la liste)
intent([
    utterance([star(_)]),
    name_intent("None"),
    slots([]),
	answer(["Je ne suis pas en mesure de répondre à votre question."])
]).