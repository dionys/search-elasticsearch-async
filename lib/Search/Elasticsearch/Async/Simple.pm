package Search::Elasticsearch::Async::Simple;

use Moo;

use Search::Elasticsearch 1.10;
use Search::Elasticsearch::Util qw(parse_params);

extends 'Search::Elasticsearch';


our $VERSION = '0.01';


sub new {
	my ($class, $pars) = parse_params(@_);

	return $class->SUPER::new({
		client              => 'Async::Simple::Direct',
		transport           => 'Async::Simple',
		cxn_pool            => 'Async::Simple::Static',
		cxn                 => 'Async::Simple::AEHTTP',
		%$pars,
	});
}


1;
