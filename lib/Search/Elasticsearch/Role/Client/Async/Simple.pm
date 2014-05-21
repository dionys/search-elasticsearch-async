package Search::Elasticsearch::Role::Client::Async::Simple;

use Moo::Role;

with 'Search::Elasticsearch::Role::Client';


sub perform_request {
	my $self = shift();
	my $cb   = pop();

	my $req = $self->parse_request(@_);

	$self->transport->perform_request($req, $cb);

	return;
}


1;
