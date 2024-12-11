package MyApp;
use Mojo::Base 'Mojolicious', -signatures;

# This method will run once at server start
sub startup ($self) {

	# Load configuration from config file
	my $config = $self->plugin('NotYAMLConfig');

	# Configure the application
	$self->secrets($config->{secrets});

	# Router
	my $r = $self->routes;

	my $time = time;
	$self->hook(after_dispatch => sub {
		$time = time;
	});

	# Normal route to controller
	$r->get('/')->to('Example#welcome');
	$r->post('/')->to( status => 200, json => { path => '/', type => 'post', status => 1, unique => $time } );

	#
	$r->get('/go')->to(   status => 200, json => { type => 'get',  path => '/get',  text => 'get 200' } );
	$r->post('/print')->to( status => 200, json => { type => 'post', path => '/post', status => 1, unique => $time } );
	$r->put('/update')->to(   status => 200, json => { type => 'put',  path => '/put',  status => 1, aarr => [ '1', '2', '3' ] } );
}

1;
