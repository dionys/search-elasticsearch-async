package Search::Elasticsearch::CxnPool::Async::Static::NoPing;

use Moo;

use Search::Elasticsearch::Util qw(new_error);

use namespace::clean;

with 'Search::Elasticsearch::Role::CxnPool::Static::NoPing',
     'Search::Elasticsearch::Role::Is_Async';


sub next_cxn {
	my ($self, $cb) = @_;

	my $cxns = $self->cxns;
	my $cnt  = @$cxns;
	my $dead = $self->_dead_cxns;

	while ($cnt--) {
		my $cxn = $cxns->[$self->next_cxn_num];

		return $cb->($cxn) if $cxn->is_live || $cxn->next_ping < time();

		push(@$dead, $cxn) unless grep { $_ eq $cxn } @$dead;
	}

	if (@$dead && $self->retries <= $self->max_retries) {
		$_->force_ping for @$dead;

		return $cb->(shift(@$dead));
	}

	local $@ = new_error('NoNodes', 'No nodes are available: [' . $self->cxns_str . ']');

	$cb->();

	return;
}


1;
