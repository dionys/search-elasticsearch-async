package Search::Elasticsearch::Cxn::AEHTTP;

use Moo;

with 'Search::Elasticsearch::Role::Cxn::Async',
     'Search::Elasticsearch::Role::Cxn::HTTP',
     'Search::Elasticsearch::Role::Is_Async';

use AnyEvent::HTTP qw(http_request);


sub perform_request {
	my ($self, $pars, $cb) = @_;

	my $uri  = $self->build_uri($pars);
	my $meth = $pars->{method};

	http_request(
		$meth   => $uri,
		timeout => $pars->{timeout} || $self->request_timeout,
		headers => {
			'Content-Type' => $pars->{mime_type},
			%{$self->default_headers},
		},
		body    => $pars->{data},
		sub {
			my ($code, $res);

			eval {
				($code, $res) = $self->process_response(
					$pars,
					delete($_[1]{Status}),
					delete($_[1]{Reason}),
					$_[0],
					$_[1],
				);
			};

			return $cb->($code, $res) unless $@;

			$self->logger->error($@);
			$cb->();
		}
	);

	return;
}

sub error_from_text {
	return 'Timeout' if $_[2] =~ /timed out/;
	return 'Cxn'     if $_[1] >= 590;
	return 'Request';
}


1;
