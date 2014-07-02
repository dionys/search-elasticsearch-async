#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use Module::Runtime qw(module_notional_filename require_module);


BEGIN {
	use_ok 'Search::Elasticsearch::Role::Is_Async::Loader';
}

my $file = module_notional_filename('Search::Elasticsearch::Role::Is_Async');

ok exists($INC{$file});

my $orig = eval { require_module('Search::Elasticsearch::Async'); };

diag 'Search::Elasticsearch::Async ' . ($orig ? $Search::Elasticsearch::Async::VERSION : 'not') . ' installed';

like $INC{$file}, qr/Is_Async\.pm$/ if $orig;
like $INC{$file}, qr/Fake\.pm$/ unless $orig;


done_testing;
