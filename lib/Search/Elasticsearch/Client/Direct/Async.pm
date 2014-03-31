package Search::Elasticsearch::Client::Direct::Async;

use Moo;

with    'Search::Elasticsearch::Role::API',
        'Search::Elasticsearch::Role::Client::Direct::Async',
        'Search::Elasticsearch::Role::Is_Async';
extends 'Search::Elasticsearch::Client::Direct';


__PACKAGE__->_install_api('');


1;
