#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;


BEGIN {
	use_ok 'Search::Elasticsearch::Role::Client::Async::Simple';
}

BEGIN {
	package Local::Client;

	use Moo;

	with 'Search::Elasticsearch::Role::Client::Async::Simple';

	sub parse_request { return $_[1] if $_[1]; return; }
}

BEGIN {
	package Local::Transport;

	use Moo;
	use Test::More;

	sub perform_request {
		ok 3 == @_;
		is ref($_[2]), 'CODE';

		$_[2]->('bar');
	}
}


ok !!Local::Client->does('Search::Elasticsearch::Role::Client::Async::Simple');
ok !!Local::Client->does('Search::Elasticsearch::Role::Client');

ok !!Local::Client->can('perform_request');

my $obj = Local::Client->new(logger => undef, transport => Local::Transport->new);
my $val;

$obj->perform_request(1, sub { $val = $_[0] // 'foo'; });
is $val, 'bar';

$obj->perform_request(sub { $val = $_[0] // 'foo'; });
is $val, 'foo';


done_testing;
