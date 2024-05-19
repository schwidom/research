
:- initialization((
        % minimize compilation reports to the essential ones (errors and warnings)
        set_logtalk_flag(report, warnings),
        % load any necessary library files for your application; for example
        logtalk_load(basic_types(loader)),
        % load the unit test tool
        logtalk_load(lgtunit(loader)),
        % load your application files (e.g. "source.lgt") enabling support for
        % code coverage, which requires compilation in debug mode and collecting
        % source data information; if code coverage is not required, remove the
        % "debug(on)" option for faster execution
        % logtalk_load(source, [source_data(on), debug(on)]),
        use_module( 'tools.pl'),
        use_module( library( clpb)),
        logtalk_load(tower, [source_data(on), debug(on)]),
        logtalk_load(tower_movable, [source_data(on), debug(on)]),
        logtalk_load(tower_move, [source_data(on), debug(on)]),
        logtalk_load(tower_list, [source_data(on), debug(on)]),
        logtalk_load(tower_list_chain, [source_data(on), debug(on)]),
        % compile the unit tests file expanding it using "lgtunit" as the hook
        % object to preprocess the tests; if you have failing tests, add the
        % option debug(on) to debug them (see "tools/lgtunit/NOTES.md" for
        % debugging advice); tests should be loaded after the code being tested
        % is loaded to avoid warnings such as references to unknown entities
        logtalk_load(tests, [hook(lgtunit)]),
        % run all the unit tests; assuming your tests object is named "tests"
        tests::run
)).

