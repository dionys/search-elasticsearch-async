package Search::Elasticsearch::Client::Async::Direct::Cluster;

use Moo;

extends 'Search::Elasticsearch::Client::Direct::Cluster';
with    'Search::Elasticsearch::Role::API';
with    'Search::Elasticsearch::Role::Async::Client::Direct';


__PACKAGE__->_install_api('cluster');


1;
