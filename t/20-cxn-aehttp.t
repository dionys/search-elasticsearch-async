#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;


BEGIN {
	use_ok 'Search::Elasticsearch::Cxn::Async::Simple::AEHTTP';
}


ok !!Search::Elasticsearch::Cxn::Async::Simple::AEHTTP->does('Search::Elasticsearch::Role::Cxn::Async::Simple');
ok !!Search::Elasticsearch::Cxn::Async::Simple::AEHTTP->does('Search::Elasticsearch::Role::Cxn::HTTP');
ok !!Search::Elasticsearch::Cxn::Async::Simple::AEHTTP->does('Search::Elasticsearch::Role::Is_Async');


done_testing;
