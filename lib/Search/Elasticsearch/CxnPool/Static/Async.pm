package Search::Elasticsearch::CxnPool::Static::Async;

use Moo;

use Search::Elasticsearch::Util qw(new_error);

use namespace::clean;

with 'Search::Elasticsearch::Role::CxnPool::Static',
     'Search::Elasticsearch::Role::Is_Async';


sub next_cxn {
	my ($self, $cb) = @_;

	my $cxns = $self->cxns;
	my (%seen, @skip);

	my $sub; $sub = sub {
		my $cnt = @$cxns;
		my $fnd;

		if ($cnt > keys(%seen)) {
			while ($cnt--) {
				my $cxn = $cxns->[$self->next_cxn_num];

				next if $seen{$cxn}++;

				return $cb->($cxn) if $cxn->is_live;

				if ($cxn->next_ping <= time()) {
					$fnd = $cxn;
					last;
				}
				push(@skip, $cxn);
			}
		}

		if ($fnd //= shift(@skip)) {
			return $fnd->pings_ok(sub {
				return $cb->($fnd) if $_[0];
				$sub->();
			});
		}

		$_->force_ping() for @$cxns;

		local $@ = new_error('NoNodes', 'No nodes are available: [' . $self->cxns_str . ']');

		$cb->();
	};

	$sub->();

	return;
}


1;
