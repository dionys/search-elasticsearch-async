package Search::Elasticsearch::Role::Cxn::Async;

use Moo::Role;

use Scalar::Util qw(blessed);

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
}


1;
