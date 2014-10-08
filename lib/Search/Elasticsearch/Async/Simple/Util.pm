package Search::Elasticsearch::Async::Simple::Util;

use strictures;

use Search::Elasticsearch::Util qw(parse_params throw);

use namespace::clean;

use Sub::Exporter -setup => {
	exports => [qw(
		parse_params_with_cb
	)]
};


sub parse_params_with_cb {
	my $self = shift();
	my $cb;
	my $pars;

	if (@_ == 1) {
		$cb = pop() if ref($_[0]) eq 'CODE';
		(undef, $pars) = parse_params($self, @_);
	}
	elsif (@_ % 2 || @_ == 2 && ref($_[0]) eq 'HASH') {
		$cb = pop();
		(undef, $pars) = parse_params($self, @_);
	}
	else {
		(undef, $pars) = parse_params($self, @_);
	}
	if (exists($pars->{cb})) {
		$cb = $pars->{cb} unless $cb;
		delete($pars->{cb});
	}

	throw('Param', 'Expecting a CODE ref for callback', {cb => $cb})
		if $cb && ref($cb) ne 'CODE';

	return ($self, $pars, $cb);
}


1;
