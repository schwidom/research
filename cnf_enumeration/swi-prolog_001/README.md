A CNF ( Conjunctive normal form ) enumeration.

% different options:  
  
$ swipl -s tests.pl % sets the config variables to all possible variations ans runs the tests  
  
$ swipl -s cnf_enumeration_A380518.pl % sets the config variables for you  
  
$ swipl -s cnf_enumeration_A380610.pl % sets the config variables for you  
  
$ swipl -s main.pl % you may first set the config variable cnf_config_has_false_rules to true or false  
  
% nb_setval( cnf_config_has_false_rules, false).  
% or  
% nb_setval( cnf_config_has_false_rules, true).  
  
% These are the CNFs with 3 rules and 3 literals which have exactly 6 solutions:  
  
  
?- nb_setval( cnf_config_has_false_rules, false).  
?- cnf_solutioncount( 3, 3, CNF, SAT, COUNT), COUNT =6, cnf_pretty_printer_string( CNF, STRING), writeln( STRING), false.  
(~a \/ b \/ c) /\ (a \/ b \/ c) /\ (b \/ c)  
(~a \/ ~b \/ c) /\ (~a \/ b \/ c) /\ (~a \/ c)  
(~a \/ ~b \/ ~c) /\ (~a \/ ~b \/ c) /\ (~a \/ ~b)  
  
