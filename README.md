# Plchat

Plchat is a backend server for chatbot. It allows to check a sentence and find useful informations (answer, intent, slots...).

The main objective is to find an alternative to Machine Learning and create a chatbot the Prolog way.

Created for SWI Prolog version 8.

## How to use it?

Launch SWI Prolog then call the server.pl

```
?- [server].
% Started server at http://localhost:8000/
true.
```

In another Terminal, launch a curl command to test the application : 

```
curl --header 'Content-Type: application/json' \
     --request POST \
     --data '{"message": "parlons de musique"}' \
     'http://localhost:8000/answer'
```

## Roadmap

- [ ] Add a way to call Prolog predicate from specific intents
- [ ] Add NLP functions to improve chatbot (Levenshtein, NER...)
- [ ] Create a multilingual chatbot
- [ ] Allow to use facts from specific intents
- [ ] Add waterfall intents
- [ ] Production deployment