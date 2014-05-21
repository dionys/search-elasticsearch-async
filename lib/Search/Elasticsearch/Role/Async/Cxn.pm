package Search::Elasticsearch::Role::Async::Cxn;

use Moo::Role;

with 'Search::Elasticsearch::Role::Cxn';


sub pings_ok {
	my ($self, $cb) = @_;

	$self->logger->infof('Pinging [%s]', $self->stringify);
	$self->perform_request(
		{
			method  => 'HEAD',
			path    => '/',
			timeout => $self->ping_timeout,
		},
		sub {
			if (@_) {
				$self->logger->infof('Marking [%s] as live', $self->stringify);
				$self->mark_live();
				$cb->(1);
			}
			else {
				$self->mark_dead();
				$cb->();
			}
		}
	);

	return;
}

sub sniff {
	my ($self, $cb) = @_;

	$self->logger->infof('Sniffing [%s]', $self->stringify);
	$self->perform_request(
		{
			method  => 'GET',
			path    => '/_nodes/' . $self->protocol,
			qs      => {timeout => 1000 * $self->sniff_timeout},
			timeout => $self->sniff_request_timeout,
		},
		sub {
			if (@_) {
				$cb->($_[1]->{nodes});
			}
			else {
				$self->logger->debug($@);
				$cb->();
			}
		}
	);

	return;
}


1;
