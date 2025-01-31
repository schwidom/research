A CNF ( Conjunctive normal form ) enumeration.

% different options:  
  
$ swipl -s tests.pl % sets the config variables to all possible variations ans runs the tests  
  
$ swipl -s cnf_enumeration_A380518.pl % sets the config variables for you  
  
$ swipl -s cnf_enumeration_A380610.pl % sets the config variables for you  
  
$ swipl -s main.pl % you may first set the config variable cnf_config_has_false_rules to true or false  
  
% nb_setval( cnf_config_has_false_rules, false).  
% or  
% nb_setval( cnf_config_has_false_rules, true).  
  
% These are all structurally differrent CNFs with 3 rules and 3 literals which have exactly 6 solutions:  
  
?- cnf_config_pp_utf8.  
true.  
  
(ins)?- cnf_solutioncount( 3, 3, CNF, SAT, COUNT), COUNT=6, cnf_pretty_printer_string( CNF, STRING), writeln( STRING), false.  
(¬A ∨ B ∨ C) ∧ (A ∨ B ∨ C) ∧ (B ∨ C)  
(¬A ∨ ¬B ∨ C) ∧ (¬A ∨ B ∨ C) ∧ (¬A ∨ C)  
(¬A ∨ ¬B ∨ ¬C) ∧ (¬A ∨ ¬B ∨ C) ∧ (¬A ∨ ¬B)  
false.  

(ins)?- cnf_config_pp_github.    
true.    
    
(ins)?- cnf_solutioncount( 3, 3, CNF, SAT, COUNT), COUNT=6, cnf_pretty_printer_string( CNF, STRING), writeln( STRING), false.  
```math
(\neg A \lor B \lor C) \land (A \lor B \lor C) \land (B \lor C)
```
```math
(\neg A \lor \neg B \lor C) \land (\neg A \lor B \lor C) \land (\neg A \lor C)
```
```math
(\neg A \lor \neg B \lor \neg C) \land (\neg A \lor \neg B \lor C) \land (\neg A \lor \neg B)
```
false.  


