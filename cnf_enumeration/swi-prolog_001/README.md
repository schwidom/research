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
  
% The same formula can also be printed with logical operators in utf8 

?- cnf_config_pp_utf8.  
true.  
  
(ins)?- cnf_solutioncount( 3, 3, CNF, SAT, COUNT), COUNT=6, cnf_pretty_printer_string( CNF, STRING), writeln( STRING), false.  
(¬A ∨ B ∨ C) ∧ (A ∨ B ∨ C) ∧ (B ∨ C)  
(¬A ∨ ¬B ∨ C) ∧ (¬A ∨ B ∨ C) ∧ (¬A ∨ C)  
(¬A ∨ ¬B ∨ ¬C) ∧ (¬A ∨ ¬B ∨ C) ∧ (¬A ∨ ¬B)  
false.  

When we have 3 literals then there exists 2^3 = 8 boolean combinations. In the previous example we chose all CNF formulae which can be satisfied with 6 combinations. That means 8-6 = 2 combinations lead to false. An assumption could be: If we invert the variables then we get all CNFs which can be satisfied with 2 combinations. This is obviously not true:  
  
(ins)?- cnf_solutioncount( 3, 3, CNF, SAT, COUNT), COUNT=2, cnf_pretty_printer_string( CNF, STRING), writeln( STRING), false.
```math
(A \lor B) \land A \land C
```
```math
(A \lor B \lor C) \land A \land B
```
```math
\neg A \land (B \lor C) \land B
```
```math
\neg A \land (A \lor B) \land (B \lor C)
```
```math
\neg A \land (A \lor B \lor C) \land B
```
```math
\neg A \land (A \lor B \lor C) \land (A \lor B)
```
```math
(\neg A \lor B) \land \neg C \land B
```
```math
(\neg A \lor B) \land \neg C \land (B \lor C)
```
```math
(\neg A \lor B) \land \neg C \land (A \lor B)
```
```math
(\neg A \lor B) \land \neg C \land (A \lor B \lor C)
```
```math
(\neg A \lor B) \land B \land C
```
```math
(\neg A \lor B) \land (B \lor C) \land A
```
```math
(\neg A \lor B) \land (B \lor \neg C) \land A
```
```math
(\neg A \lor B) \land (A \lor C) \land A
```
```math
(\neg A \lor B) \land (A \lor \neg C) \land (\neg B \lor C)
```
```math
(\neg A \lor B) \land (A \lor \neg C) \land A
```
```math
(\neg A \lor B) \land (A \lor \neg C) \land (A \lor C)
```
```math
(\neg A \lor B) \land (A \lor \neg C) \land \neg A
```
```math
(\neg A \lor B) \land (A \lor B) \land C
```
```math
(\neg A \lor B) \land (A \lor B) \land B
```
```math
(\neg A \lor B) \land (A \lor B \lor C) \land A
```
```math
(\neg A \lor B) \land (A \lor \neg B) \land C
```
```math
(\neg A \lor B) \land (A \lor \neg B) \land \neg C
```
```math
(\neg A \lor B) \land \neg A \land C
```
```math
(\neg A \lor B) \land \neg A \land \neg C
```
```math
(\neg A \lor B) \land \neg A \land (A \lor C)
```
```math
(\neg A \lor B) \land (\neg A \lor C) \land \neg B
```
```math
(\neg A \lor B \lor C) \land B \land C
```
```math
(\neg A \lor B \lor C) \land \neg B \land C
```
```math
(\neg A \lor B \lor C) \land \neg B \land (B \lor C)
```
```math
(\neg A \lor B \lor C) \land \neg B \land (A \lor C)
```
```math
(\neg A \lor B \lor C) \land \neg B \land (A \lor B \lor C)
```
```math
(\neg A \lor B \lor C) \land (\neg B \lor C) \land B
```
```math
(\neg A \lor B \lor C) \land (\neg B \lor C) \land A
```
```math
(\neg A \lor B \lor C) \land A \land B
```
```math
(\neg A \lor B \lor C) \land (A \lor \neg B) \land \neg C
```
```math
(\neg A \lor B \lor C) \land (A \lor \neg B) \land B
```
```math
(\neg A \lor B \lor C) \land (A \lor \neg B) \land \neg A
```
```math
(\neg A \lor B \lor C) \land (A \lor \neg B \lor C) \land \neg C
```
```math
(\neg A \lor B \lor C) \land \neg A \land B
```
```math
(\neg A \lor B \lor C) \land \neg A \land \neg B
```
```math
(\neg A \lor B \lor C) \land \neg A \land (A \lor B)
```
```math
(\neg A \lor B \lor C) \land (\neg A \lor B) \land \neg B
```
```math
(\neg A \lor B \lor C) \land (\neg A \lor B) \land A
```
```math
(\neg A \lor \neg B) \land \neg C \land (A \lor B)
```
```math
(\neg A \lor \neg B) \land \neg C \land (A \lor B \lor C)
```
```math
(\neg A \lor \neg B) \land (A \lor C) \land A
```
```math
(\neg A \lor \neg B) \land (A \lor \neg C) \land (B \lor C)
```
```math
(\neg A \lor \neg B) \land (A \lor \neg C) \land A
```
```math
(\neg A \lor \neg B) \land (A \lor \neg C) \land (A \lor C)
```
```math
(\neg A \lor \neg B) \land (A \lor \neg C) \land \neg A
```
```math
(\neg A \lor \neg B) \land (A \lor B) \land C
```
```math
(\neg A \lor \neg B) \land (A \lor B \lor C) \land A
```
```math
(\neg A \lor \neg B) \land (A \lor B \lor \neg C) \land C
```
```math
(\neg A \lor \neg B) \land (A \lor B \lor \neg C) \land A
```
```math
(\neg A \lor \neg B) \land \neg A \land C
```
```math
(\neg A \lor \neg B) \land \neg A \land \neg C
```
```math
(\neg A \lor \neg B) \land \neg A \land (A \lor C)
```
```math
(\neg A \lor \neg B) \land (\neg A \lor C) \land \neg C
```
```math
(\neg A \lor \neg B) \land (\neg A \lor C) \land B
```
```math
(\neg A \lor \neg B) \land (\neg A \lor \neg C) \land B
```
```math
(\neg A \lor \neg B) \land (\neg A \lor B) \land C
```
```math
(\neg A \lor \neg B) \land (\neg A \lor B) \land \neg C
```
```math
(\neg A \lor \neg B) \land (\neg A \lor B) \land (A \lor C)
```
```math
(\neg A \lor \neg B) \land (\neg A \lor B) \land (A \lor \neg C)
```
```math
(\neg A \lor \neg B) \land (\neg A \lor B) \land \neg A
```
```math
(\neg A \lor \neg B) \land (\neg A \lor B \lor C) \land \neg C
```
```math
(\neg A \lor \neg B) \land (\neg A \lor B \lor C) \land B
```
```math
(\neg A \lor \neg B \lor C) \land \neg C \land (A \lor B)
```
```math
(\neg A \lor \neg B \lor C) \land \neg C \land (A \lor B \lor C)
```
```math
(\neg A \lor \neg B \lor C) \land A \land C
```
```math
(\neg A \lor \neg B \lor C) \land (A \lor C) \land B
```
```math
(\neg A \lor \neg B \lor C) \land (A \lor \neg C) \land C
```
```math
(\neg A \lor \neg B \lor C) \land (A \lor \neg C) \land B
```
```math
(\neg A \lor \neg B \lor C) \land (A \lor \neg C) \land \neg A
```
```math
(\neg A \lor \neg B \lor C) \land \neg A \land C
```
```math
(\neg A \lor \neg B \lor C) \land \neg A \land \neg C
```
```math
(\neg A \lor \neg B \lor C) \land \neg A \land B
```
```math
(\neg A \lor \neg B \lor C) \land \neg A \land \neg B
```
```math
(\neg A \lor \neg B \lor C) \land \neg A \land (A \lor C)
```
```math
(\neg A \lor \neg B \lor C) \land \neg A \land (A \lor B)
```
```math
(\neg A \lor \neg B \lor C) \land (\neg A \lor C) \land \neg C
```
```math
(\neg A \lor \neg B \lor C) \land (\neg A \lor C) \land A
```
```math
(\neg A \lor \neg B \lor C) \land (\neg A \lor \neg C) \land C
```
```math
(\neg A \lor \neg B \lor C) \land (\neg A \lor \neg C) \land B
```
```math
(\neg A \lor \neg B \lor C) \land (\neg A \lor B) \land \neg C
```
```math
(\neg A \lor \neg B \lor C) \land (\neg A \lor B) \land \neg B
```
```math
(\neg A \lor \neg B \lor C) \land (\neg A \lor B \lor C) \land \neg C
```
```math
(\neg A \lor \neg B \lor C) \land (\neg A \lor B \lor C) \land A
```
```math
(\neg A \lor \neg B \lor C) \land (\neg A \lor B \lor \neg C) \land A
```
```math
(\neg A \lor \neg B \lor C) \land (\neg A \lor \neg B) \land A
```
```math
(\neg A \lor \neg B \lor \neg C) \land (A \lor B) \land C
```
```math
(\neg A \lor \neg B \lor \neg C) \land \neg A \land B
```
```math
(\neg A \lor \neg B \lor \neg C) \land \neg A \land \neg B
```
```math
(\neg A \lor \neg B \lor \neg C) \land \neg A \land (A \lor B)
```
```math
(\neg A \lor \neg B \lor \neg C) \land (\neg A \lor B) \land C
```
```math
(\neg A \lor \neg B \lor \neg C) \land (\neg A \lor B) \land \neg B
```
```math
(\neg A \lor \neg B \lor \neg C) \land (\neg A \lor B \lor C) \land A
```
```math
(\neg A \lor \neg B \lor \neg C) \land (\neg A \lor \neg B) \land A
```
```math
(\neg A \lor \neg B \lor \neg C) \land (\neg A \lor \neg B \lor C) \land A
```
false.  
  
How look all CNFs with 0 solutions?  
  
(cmd)?- cnf_solutioncount( 3, 3, CNF, SAT, COUNT), COUNT=0, cnf_pretty_printer_string( CNF, STRING), writeln( STRING), false.  
```math
\neg A \land (B \lor C) \land A
```
```math
\neg A \land \neg B \land A
```
```math
\neg A \land \neg B \land (A \lor B)
```
```math
\neg A \land A \land B
```
```math
\neg A \land (A \lor B) \land A
```
```math
\neg A \land (A \lor B \lor C) \land A
```
```math
(\neg A \lor B) \land \neg C \land C
```
```math
(\neg A \lor B) \land \neg B \land B
```
```math
(\neg A \lor B) \land \neg B \land A
```
```math
(\neg A \lor B) \land \neg B \land (A \lor B)
```
```math
(\neg A \lor B) \land \neg A \land A
```
```math
(\neg A \lor B \lor C) \land \neg B \land B
```
```math
(\neg A \lor B \lor C) \land \neg A \land A
```
```math
(\neg A \lor \neg B) \land \neg C \land C
```
```math
(\neg A \lor \neg B) \land A \land B
```
```math
(\neg A \lor \neg B) \land \neg A \land A
```
```math
(\neg A \lor \neg B) \land (\neg A \lor B) \land A
```
```math
(\neg A \lor \neg B \lor C) \land \neg C \land C
```
```math
(\neg A \lor \neg B \lor C) \land \neg A \land A
```
```math
(\neg A \lor \neg B \lor \neg C) \land \neg A \land A
```
false.  

And this is the amount of CNFs for a given number of solutions (SOLUTIONS - CNFs) :  
  
(ins)?- cnf_solutioncount_count_sequence( 3, 3, A, B), pairs_keys_values( P, A, B), writeln(P), false.  
[0-20,1-58,2-100,3-130,4-131,5-58,6-3]  
false.  
  
