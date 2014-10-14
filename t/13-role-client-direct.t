#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use B ();


BEGIN {
	use_ok 'Search::Elasticsearch::Role::Client::Async::Simple::Direct';
}

BEGIN {
	package Local::Client;

	use Moo;

	with 'Search::Elasticsearch::Role::Client::Async::Simple::Direct';
}

BEGIN {
	package Local::Logger;

	use Moo;

	with 'Search::Elasticsearch::Role::Logger';

	sub error {}
}


ok !!Local::Client->does('Search::Elasticsearch::Role::Client::Async::Simple::Direct');
ok !!Local::Client->does('Search::Elasticsearch::Role::Client::Async::Simple');
ok !!Local::Client->does('Search::Elasticsearch::Role::Client::Direct');

ok !!Local::Client->can('_install_api');
is exporter('Local::Client::_install_api'), 'Search::Elasticsearch::Role::Client::Async::Simple::Direct';

ok !!Local::Client->can('perform_request');
is exporter('Local::Client::perform_request'), 'Search::Elasticsearch::Role::Client::Async::Simple';

my $obj = Local::Client->new(logger => Local::Logger->new(serializer => undef), transport => undef);
my $req = $obj->parse_request({doc => 'bar'});

ok !$req;
ok $@;
ok $@->isa('Search::Elasticsearch::Error');


done_testing;


sub exporter {
	no strict 'refs';
	return B::svref_2object(\&{$_[0]})->GV->STASH->NAME;
}
