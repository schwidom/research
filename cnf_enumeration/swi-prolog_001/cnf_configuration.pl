
% variables : cnf_config_has_false_rules
:- use_module( library( error)). % must_be, terms: boolean | oneof( [true,false])

cnf_configuration_set_has_false_rules( HAS_FALSE_RULES) :- true
, must_be( boolean, HAS_FALSE_RULES)
, ignore( 
   nb_current( cnf_config_has_false_rules, CURRENT_VALUE)
    -> 
     CURRENT_VALUE \== HAS_FALSE_RULES 
      -> 
       abolish_all_tables
  )
, nb_setval( cnf_config_has_false_rules, HAS_FALSE_RULES)
.
 
cnf_configuration_set_has_lesser_vars( HAS_LESSER_VARS) :- true
, must_be( boolean, HAS_LESSER_VARS)
, ignore( 
   nb_current( cnf_config_has_lesser_vars, CURRENT_VALUE)
    -> 
     CURRENT_VALUE \== HAS_LESSER_VARS 
      -> 
       abolish_all_tables
  )
, nb_setval( cnf_config_has_lesser_vars, HAS_LESSER_VARS)
.
 
