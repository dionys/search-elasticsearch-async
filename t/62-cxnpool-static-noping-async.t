#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;


BEGIN {
	use_ok 'Search::Elasticsearch::CxnPool::Static::NoPing::Async';
}


done_testing;
