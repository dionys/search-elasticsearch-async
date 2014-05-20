#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;


BEGIN {
	use_ok 'Search::Elasticsearch::Client::Direct::Async::Indices';
}


done_testing;
