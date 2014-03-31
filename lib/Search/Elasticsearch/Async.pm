package Search::Elasticsearch::Async;

use Moo;

use Search::Elasticsearch 1.00;
use Search::Elasticsearch::Util qw(parse_params);

extends 'Search::Elasticsearch';


our $VERSION = '0.01';


sub new {
	my ($class, $params) = parse_params(@_);

	return $class->SUPER::new({
		client              => 'Direct::Async',
		transport           => 'Async',
		cxn_pool            => 'Static::Async',
		cxn                 => 'AEHTTP',
		%$params,
	});
}


1;
