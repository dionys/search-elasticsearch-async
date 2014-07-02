package
	Search::Elasticsearch::Role::Is_Async::Loader; # Hidden.

# Loads fake Search::Elasticsearch::Role::Is_Async module if distro
# Search::Elasticsearch::Async not installed.

use strictures;

use Module::Runtime qw(module_notional_filename require_module);

use namespace::clean;


BEGIN {
	eval {
		require_module('Search::Elasticsearch::Role::Is_Async');
	};
	if ($@) {
		require_module('Search::Elasticsearch::Role::Is_Async::Fake');

		my $file = module_notional_filename('Search::Elasticsearch::Role::Is_Async');

		$INC{$file} = $INC{module_notional_filename('Search::Elasticsearch::Role::Is_Async::Fake')}
			unless $INC{$file};
	}
}


1;
