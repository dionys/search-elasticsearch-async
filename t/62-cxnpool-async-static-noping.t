#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;


BEGIN {
	use_ok 'Search::Elasticsearch::CxnPool::Async::Static::NoPing';
}


done_testing;
