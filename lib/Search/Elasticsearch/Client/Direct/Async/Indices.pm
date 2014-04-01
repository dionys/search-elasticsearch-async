package Search::Elasticsearch::Client::Direct::Async::Indices;

use Moo;

with 'Search::Elasticsearch::Role::API';
with 'Search::Elasticsearch::Role::Client::Direct::Async';


__PACKAGE__->_install_api('indices');


1;
