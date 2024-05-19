
:- module( tools, [mybagof0/3, mygroup_by0/4, between0/3, dict_key_value/3]).

:- use_module(library(solution_sequences)).

:- meta_predicate between0( +, +, ?).

between0( START, END, VALUE) :- END2 is END - 1, between( START, END2, VALUE).

:- meta_predicate mybagof0( +, ^, -).

mybagof0( A, B, C) :- bagof( A, B, C) *-> true ; C=[].

:- meta_predicate( mygroup_by0( +, +, ^, -)).

mygroup_by0( A, B, C, D) :- group_by( A, B, C, D) *-> true; D = [].

dict_key_value( D, K, V) :- D.K = V.

