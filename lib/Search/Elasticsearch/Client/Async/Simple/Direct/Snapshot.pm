package Search::Elasticsearch::Client::Async::Simple::Direct::Snapshot;

use Moo;

extends 'Search::Elasticsearch::Client::Direct::Snapshot';
with    'Search::Elasticsearch::Role::API';
with    'Search::Elasticsearch::Role::Client::Async::Simple::Direct';


__PACKAGE__->_install_api('snapshot');


1;
