package Search::Elasticsearch::Client::Async::Simple::1_0::Direct;

use Moo;

use Search::Elasticsearch::Role::Is_Async::Loader ();
use Search::Elasticsearch::Util qw(load_plugin parse_params);

use namespace::clean;

with    'Search::Elasticsearch::Role::API::1_0',
        'Search::Elasticsearch::Role::Client::Async::Simple::Direct',
        'Search::Elasticsearch::Role::Is_Async';
extends 'Search::Elasticsearch::Client::1_0::Direct';


__PACKAGE__->_install_api('');


sub create {
	my $cb = pop();
	my ($self, $pars) = parse_params(@_);

	$pars->{op_type} = 'create';

	$self->_index('create', $pars, $cb);

	return;

}

sub index {
	my $cb = pop();
	my ($self, $pars) = parse_params(@_);

	$self->_index('index', $pars, $cb);

	return;
}

sub _index {
	my ($self, $name, $pars, $cb) = @_;

	my $defn = $self->api->{index};

	unless (defined($pars->{id}) and length($pars->{id})) {
		$defn = {%$defn, method => 'POST'};
	}

	$self->perform_request({%$defn, name => $name}, $pars, $cb);

	return;
}

sub _build_namespace {
	my ($self, $ns) = @_;

	my $cls = load_plugin(__PACKAGE__, [$ns]);

	return $cls->new({
		transport => $self->transport,
		logger    => $self->logger,
	});
}


1;


__END__

=head1 NAME

Search::Elasticsearch::Client::Async::Simple::Direct - Thin asynchronous client with full support for Elasticsearch APIs

=head1 DESCRIPTION

See L<Search::Elasticsearch::Client::Direct> for the main documentation.

=head1 AUTHOR

Denis Ibaev C<dionys@cpan.org>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut
