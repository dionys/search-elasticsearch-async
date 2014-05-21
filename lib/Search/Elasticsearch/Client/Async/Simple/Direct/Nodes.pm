package Search::Elasticsearch::Client::Async::Simple::Direct::Nodes;

use Moo;

extends 'Search::Elasticsearch::Client::Direct::Nodes';
with    'Search::Elasticsearch::Role::API';
with    'Search::Elasticsearch::Role::Client::Async::Simple::Direct';


__PACKAGE__->_install_api('nodes');


1;
