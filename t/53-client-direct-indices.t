#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;


BEGIN {
	use_ok 'Search::Elasticsearch::Client::Async::Simple::1_0::Direct::Indices';
}


done_testing;
