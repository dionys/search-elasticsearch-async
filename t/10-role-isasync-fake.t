#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use Module::Runtime qw(module_notional_filename);
use Role::Tiny ();


BEGIN {
	use_ok 'Search::Elasticsearch::Role::Is_Async::Fake';
}

ok !!Role::Tiny->is_role('Search::Elasticsearch::Role::Is_Async');


done_testing;
