
% swilgt -s main.pl

:- set_test_options(format(log)).

:- set_prolog_flag( answer_write_options, [quoted(true), portray(true), max_depth(50), spacing(next_argument)]).

:- use_module( library(solution_sequences)). % group_by
:- use_module( library( error)).
:- use_module( library( clpb)).
% :- use_module( library( clpfd)). % is imported in the module

:- use_module( 'tools.pl').

:- logtalk_load( tower).
:- logtalk_load( tower_movable).
:- logtalk_load( tower_move).
:- logtalk_load( tower_list).
:- logtalk_load( tower_list_chain).


