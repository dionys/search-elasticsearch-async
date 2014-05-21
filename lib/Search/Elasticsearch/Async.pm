package Search::Elasticsearch::Async;

use Moo;

use Search::Elasticsearch 1.00;
use Search::Elasticsearch::Util qw(parse_params);

extends 'Search::Elasticsearch';


our $VERSION = '0.01';


sub new {
	my ($class, $pars) = parse_params(@_);

	return $class->SUPER::new({
		client              => 'Async::Direct',
		transport           => 'Async',
		cxn_pool            => 'Async::Static',
		cxn                 => 'AEHTTP',
		%$pars,
	});
}


1;