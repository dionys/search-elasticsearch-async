#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;


BEGIN {
	use_ok 'Search::Elasticsearch::Async::Simple::Util', qw(parse_params_with_cb);
}


my ($self, $pars, $cb);
my @res;

$self = 'foo';

@res = parse_params_with_cb($self);
is $res[0], $self;
is ref($res[1]), 'HASH';
ok !keys(%{$res[1]});
ok !$res[2];

@res = parse_params_with_cb($self, bar => 'qux');
is $res[0], $self;
is ref($res[1]), 'HASH';
ok keys(%{$res[1]}) == 1;
is $res[1]{bar}, 'qux';
ok !$res[2];

@res = parse_params_with_cb($self, {bar => 'qux'});
is $res[0], $self;
is ref($res[1]), 'HASH';
ok keys(%{$res[1]}) == 1;
is $res[1]{bar}, 'qux';
ok !$res[2];

@res = parse_params_with_cb($self, sub {});
is $res[0], $self;
is ref($res[1]), 'HASH';
ok !keys(%{$res[1]});
is ref($res[2]), 'CODE';

@res = parse_params_with_cb($self, {bar => 'qux'}, sub {});
is $res[0], $self;
is ref($res[1]), 'HASH';
ok keys(%{$res[1]}) == 1;
is $res[1]{bar}, 'qux';
is ref($res[2]), 'CODE';

@res = parse_params_with_cb($self, {bar => 'qux', cb => sub {}});
is $res[0], $self;
is ref($res[1]), 'HASH';
ok keys(%{$res[1]}) == 1;
is $res[1]{bar}, 'qux';
is ref($res[2]), 'CODE';


eval { parse_params_with_cb($self, {bar => 'qux'}, {}); };
ok $@;

eval { parse_params_with_cb($self, {bar => 'qux', cb => {}}); };
ok $@;


done_testing;
