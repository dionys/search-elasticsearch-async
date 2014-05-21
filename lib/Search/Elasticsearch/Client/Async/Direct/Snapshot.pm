package Search::Elasticsearch::Client::Async::Direct::Snapshot;

use Moo;

extends 'Search::Elasticsearch::Client::Direct::Snapshot';
with    'Search::Elasticsearch::Role::API';
with    'Search::Elasticsearch::Role::Async::Client::Direct';


__PACKAGE__->_install_api('snapshot');


1;
