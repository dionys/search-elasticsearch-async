package Search::Elasticsearch::Client::Direct::Async::Snapshot;

use Moo;

extends 'Search::Elasticsearch::Client::Direct::Snapshot';
with    'Search::Elasticsearch::Role::API';
with    'Search::Elasticsearch::Role::Client::Direct::Async';


__PACKAGE__->_install_api('snapshot');


1;
