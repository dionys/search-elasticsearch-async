package Search::Elasticsearch::Client::Direct::Async::Indices;

use Moo;

extends 'Search::Elasticsearch::Client::Direct::Indices';
with    'Search::Elasticsearch::Role::API';
with    'Search::Elasticsearch::Role::Client::Direct::Async';


__PACKAGE__->_install_api('indices');


1;
