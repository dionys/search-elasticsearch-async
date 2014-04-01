package Search::Elasticsearch::Client::Direct::Async;

use Moo;

use Search::Elasticsearch::Util qw(load_plugin);

with    'Search::Elasticsearch::Role::API',
        'Search::Elasticsearch::Role::Client::Direct::Async',
        'Search::Elasticsearch::Role::Is_Async';
extends 'Search::Elasticsearch::Client::Direct';


__PACKAGE__->_install_api('');


sub _build_namespace {
	my ($self, $ns) = @_;

	my $cls = load_plugin(__PACKAGE__, [$ns]);

	return $cls->new({
		transport => $self->transport,
		logger    => $self->logger,
	});
}


1;
