package Search::Elasticsearch::Client::Async::Direct::Nodes;

use Moo;

extends 'Search::Elasticsearch::Client::Direct::Nodes';
with    'Search::Elasticsearch::Role::API';
with    'Search::Elasticsearch::Role::Async::Client::Direct';


__PACKAGE__->_install_api('nodes');


1;
