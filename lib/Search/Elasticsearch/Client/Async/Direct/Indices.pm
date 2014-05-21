package Search::Elasticsearch::Client::Async::Direct::Indices;

use Moo;

extends 'Search::Elasticsearch::Client::Direct::Indices';
with    'Search::Elasticsearch::Role::API';
with    'Search::Elasticsearch::Role::Async::Client::Direct';


__PACKAGE__->_install_api('indices');


1;
