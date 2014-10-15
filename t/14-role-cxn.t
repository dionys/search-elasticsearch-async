#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;


BEGIN {
	use_ok 'Search::Elasticsearch::Role::Cxn::Async::Simple';
}

BEGIN {
	package Local::Cxn;

	use Moo;

	with 'Search::Elasticsearch::Role::Cxn::Async::Simple';

	sub protocol {}
	sub perform_request {}
	sub error_from_text {}
}


ok !!Local::Cxn->does('Search::Elasticsearch::Role::Cxn::Async::Simple');
ok !!Local::Cxn->does('Search::Elasticsearch::Role::Cxn');


done_testing;
