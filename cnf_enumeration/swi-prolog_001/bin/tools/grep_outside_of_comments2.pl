
:- use_module( library( error)). % must_be
:- use_module( library( dcg/basics)).
:- use_module( library( yall)).
:- use_module( library( aggregate)).
:- use_module( library( pcre)). % re_split
:- use_module( library( pio)). % lazy_list_location

% see lazy_list_location, lazy_list_character_count

parse_skip_string( START, END) --> START, string(_), END, !.

% (ins)?- phrase( parse_skip_string( `/*`, `*/`), `/*                                                   */a`, R).
% R = [97].

parse_skip_string( TOKEN) --> parse_skip_string( TOKEN, TOKEN).

% (cmd)?- phrase( parse_skip_string( `"`, `"`), `"def"ghi`, R).
% R = [103, 104, 105].

% lltest --> lazy_list_location( L), { writeln( l-L) } .
lltest --> []
, lazy_list_location( L1)
, string(S1)
, { length( S1, 2) }
, lazy_list_location( L2), string(S2)
, eol
, !
, string(S2)
, lazy_list_location( L3)
, { writeln( [L1, L2, L3, S1, S2]) }
.

% (ins)?- phrase_from_file( lltest, "/home/ox/db/ideen/idee_2025_02_06_15_34_15/idee.txt").
% [file(/home/ox/db/ideen/idee_2025_02_06_15_34_15/idee.txt,1,0,0),file(/home/ox/db/ideen/idee_2025_02_06_15_34_15/idee.txt,1,2,2),file(/home/ox/db/ideen/idee_2025_02_06_15_34_15/idee.txt,2,0,25),[115,97],[108,97,116,32,109,105,116,32,115,252,115,115,117,110,103,115,109,105,116,116,101,108,110]]
% false.


:- dynamic current_line/2.

/* phrase_from_file */

% TODO : quote handling in parse_skip_string

parse_file( FIXEDCODES, RESULT) --> 
parse_skip_string( `%`, `\n`) -> parse_file( FIXEDCODES, RESULT) ;
parse_skip_string( `/*`, `*/`) -> parse_file( FIXEDCODES, RESULT) ;
% parse_skip_string( `"`) -> parse_file( FIXEDCODES, RESULT) ;
% parse_skip_string( `'`) -> parse_file( FIXEDCODES, RESULT) ; % dangerous without quote handling
% parse_skip_string( ````) -> parse_file( FIXEDCODES, RESULT) ; % dangerous without quote handling
[]
, lazy_list_location( LLLCURRENT)
, { LLLCURRENT = file( _, LLLCURRENT_LINE, _, _) }
, ( FIXEDCODES -> { forall( member( C, FIXEDCODES), assertz( current_line( LLLCURRENT_LINE, C))), RESULT = [LLLCURRENT|T] }, !, (parse_file( FIXEDCODES, T) -> [] ; { T=[]}, string(_), eos, !) ;
[]
, [CHAR]
, { [CHAR] == `\n` -> true ;
    assertz( current_line( LLLCURRENT_LINE, CHAR)) }
, parse_file( FIXEDCODES, RESULT)
)
.

grepfile( FILE, FIXEDCODES, RESULT) :- true
, functor( F, current_line, 2), retractall( F)
, phrase_from_file( parse_file( FIXEDCODES, RESULT), FILE)
.

% (ins)?- grepfile( "/home/ox/db/ideen/idee_2025_02_06_15_34_15/idee.txt", `üs`, R).
% R = [file('/home/ox/db/ideen/idee_2025_02_06_15_34_15/idee.txt', 1, 11, 11)|_].

% (ins)?- grepfile( "grep_outside_of_comments2.pl", `phrase_from_file`, R).
% R = [file('grep_outside_of_comments2.pl', 56, 2, 1926)].

grepfile2_helper( LLL, LLL_LINE) :- true
, LLL=file( _, NR, _, _)
, findall( CHAR, current_line( NR, CHAR), LIST)
, string_codes( S, LIST)
, LLL_LINE = (LLL, S)
.

grepfile2( FILE, FIXEDCODES, RESULT) :- true
, grepfile( FILE, FIXEDCODES, RESULT_PRE)
, maplist( grepfile2_helper, RESULT_PRE, RESULT)
.

grepfile3( FILE, FIXEDCODES) :- true
, grepfile2( FILE, FIXEDCODES, RESULT) ->
forall( ( member( E, RESULT), E = (file( FNAME, LN, _, _), LINE)), ( true
   , write( FNAME)
   , write( ':')
   , write( LN)
   , write( ':')
   , write( LINE)
   , nl
  )) ; true
.
