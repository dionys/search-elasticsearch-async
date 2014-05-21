package Search::Elasticsearch::Client::Async::Simple::Direct::Indices;

use Moo;

extends 'Search::Elasticsearch::Client::Direct::Indices';
with    'Search::Elasticsearch::Role::API';
with    'Search::Elasticsearch::Role::Client::Async::Simple::Direct';


__PACKAGE__->_install_api('indices');


1;
