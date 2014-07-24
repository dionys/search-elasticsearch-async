#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;


BEGIN {
	use_ok 'Search::Elasticsearch::Client::Async::Simple::Direct';
}

BEGIN {
	package Local::Transport;

	use Moo;
	use Test::More;

	sub perform_request {
		ok 3 == @_;
		is ref($_[2]), 'CODE';

		$_[2]->();
	}
}

my $obj = Search::Elasticsearch::Client::Async::Simple::Direct->new(
	logger    => undef,
	transport => Local::Transport->new,
);
my $val;


diag 'api' unless $ENV{HARNESS_ACTIVE};

$obj->create(index => 'foo', type => 'bar', body => {}, sub { $val = 'buz' });
is $val, 'buz';
$obj->index(index => 'foo', type => 'bar', body => {}, sub { $val = 'qux' });
is $val, 'qux';


done_testing;
