package Search::Elasticsearch::Client::Direct::Async::Cluster;

use Moo;

extends 'Search::Elasticsearch::Client::Direct::Cluster';
with    'Search::Elasticsearch::Role::API';
with    'Search::Elasticsearch::Role::Client::Direct::Async';


__PACKAGE__->_install_api('cluster');


1;
