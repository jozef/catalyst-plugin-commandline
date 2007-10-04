package Catalyst::Plugin::CommandLine;

=head1 NAME

Catalyst::Plugin::CommandLine - Catalyst plugin to make $c available also for scripts.

=head1 SYNOPSIS

	use MyCatalystApp;

	my $c = MyCatalystApp->new('MyCatalystApp');
	$c->commandline;
	
	$c->stash->{ ...
	$c->model( ...
	$c->controller( ...
	$c->view( ...

=cut

use base qw/Class::Data::Inheritable/;

use strict;
use warnings;

use NEXT;
use UNIVERSAL qw{ can };

our $VERSION = "0.02";

=head1 FUNCTIONS

=head2 commandline

Will setup $c so that it could be used in the script.

Setups stash, request, response, sessionid.

=cut

sub commandline {
    my ( $c, $class, $action ) = @_;

	$c->stash({ CommandLine => 1 });
	$c->request(Catalyst::Request->new({ cookies => {}, base => $c->config->{'base'} }));
	$c->response(Catalyst::Response->new({ cookies => {} }));
	
	#if we have session setup sessionid
	if (can($c, 'sessionid')) {
		$c->sessionid('".$0." ".$PID."');
	}
}

1;

=head1 AUTHOR

Jozef Kutej - E<lt>jozef@kutej.netE<gt>

=cut
