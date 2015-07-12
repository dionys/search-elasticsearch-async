package Search::Elasticsearch::Client::Async::Simple::1_0::Direct::Snapshot;

use Moo;

use namespace::clean;

extends 'Search::Elasticsearch::Client::1_0::Direct::Snapshot';
with    'Search::Elasticsearch::Role::API::1_0';
with    'Search::Elasticsearch::Role::Client::Async::Simple::Direct';


__PACKAGE__->_install_api('snapshot');


1;


__END__

=head1 NAME

Search::Elasticsearch::Client::Async::Simple::Direct::Snapshot - An asynchronous client for managing snapshot

=head1 DESCRIPTION

See L<Search::Elasticsearch::Client::Direct::Snapshot> for the main documentation.

=head1 AUTHOR

Denis Ibaev C<dionys@cpan.org>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut
