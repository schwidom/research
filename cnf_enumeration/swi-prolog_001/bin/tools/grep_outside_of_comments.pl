
:- use_module(library(dcg/basics)).
:- use_module(library(yall)).
:- use_module(library(aggregate)).

parse_chars( CHARS, [H | T]) --> [H], { memberchk( H, CHARS) }, ( parse_chars( CHARS, T) ; { T = [] }).

parse_non_chars( CHARS, [H | T]) --> [H], { \+ memberchk( H, CHARS) }, ( parse_non_chars( CHARS, T), ! ; { T = [] }).

% parse_filename( FN) --> parse_non_chars( `:`, FN).
% parse_linenumber( NR) --> parse_non_chars( `:`, NR).

parse_filename( FN) --> string_without( `:`, FN).
parse_linenumber( NR) --> string_without( `:`, NR).

parse_grep_lines( GOAL) --> parse_filename( FN), `:`, parse_linenumber(NR), `:`, string(_), eol, !, { call( GOAL, FN, NR) }, ( parse_grep_lines( GOAL), ! ; eos).

:- dynamic category_file_line/3.

handle_file_line_codes_001( F, L) :- string_codes( FS, F), string_codes( LS, L), writeln( ( FS, LS)).
handle_file_line_codes_002( CATEGORY, F, L) :- string_codes( FS, F), number_codes( LS, L)
, assertz( category_file_line( CATEGORY, FS, LS))
.

phrase_from_base_file( BASE, FILE) :- true
, string_concat( BASE, "/", BASE2)
, string_concat( BASE2, FILE, FILEPATH)
, phrase_from_file( parse_grep_lines( handle_file_line_codes_002( FILE)), FILEPATH)
.

grep_filenames( GFN) :- member( GFN, [ "commentopen.txt", "commentclose.txt", "commentline.txt", "grep.txt"]).

goal_001(PATH) :- true
, ( functor( CFL, category_file_line, 3) , retractall( CFL) )
, forall( grep_filenames( GFN), phrase_from_base_file( PATH, GFN))
, aggregate_all( max( LINE), category_file_line(_, _, LINE), MAXLINE)
, writeln( maxline-MAXLINE)
.
