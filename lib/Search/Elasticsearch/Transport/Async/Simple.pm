package Search::Elasticsearch::Transport::Async::Simple;

use Moo;

use Time::HiRes qw(time);

use Search::Elasticsearch::Util qw(upgrade_error);

with 'Search::Elasticsearch::Role::Transport',
     'Search::Elasticsearch::Role::Is_Async';


sub perform_request {
	my $self = shift();
	my $cb   = pop();

	my $pars = $self->tidy_request(@_);
	my $pool = $self->cxn_pool;
	my $log  = $self->logger;

	$pool->next_cxn(sub {
		unless (@_) {
			$log->error($@);
			$cb->();

			return;
		}

		my $cxn = $_[0];
		my $ts  = time();

		$log->trace_request($cxn, $pars);
		$cxn->perform_request($pars, sub {
			if (@_) {
				my ($code, $res) = @_;

				$pool->request_ok($cxn);
				$log->trace_response($cxn, $code, $res, time() - $ts);
				$cb->($res);
			}
			else {
				my $err = upgrade_error($@, {request => $pars});

				if ($pool->request_failed($cxn, $err)) {
					$log->debugf('[%s] %s', $cxn->stringify(), "$err");
					$log->info('Retrying request on a new cxn');

					return $self->perform_request($pars, $cb);
				}

				$log->trace_error($cxn, $err);
				delete($err->{vars}{body});
				$err->is('NoNodes')
					? $log->critical($err)
					: $log->error($err);

				$cb->();
			}
		});
	});

	return;
}


1;
