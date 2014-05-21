package Search::Elasticsearch::Role::Client::Async::Simple::Direct;

use Moo::Role;

use Package::Stash ();

with 'Search::Elasticsearch::Role::Client::Async::Simple';
with 'Search::Elasticsearch::Role::Client::Direct';


sub _install_api {
	my ($cls, $grp) = @_;

	my $defs = $cls->api;
	my $pkg  = Package::Stash->new($cls);

	my $re = $grp ? qr/$grp\./ : qr//;

	for my $act (keys(%$defs)) {
		my ($name) = $act =~ /^$re([^.]+)$/;

		next unless $name;
		next if $pkg->has_symbol('&' . $name);

		my %def = (name => $name, %{$defs->{$act}});

		$pkg->add_symbol(
			'&' . $name => sub {
				shift()->perform_request(\%def, @_);
				return;
			}
		);
	}
}


1;
