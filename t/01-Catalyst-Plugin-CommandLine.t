#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;
BEGIN { use_ok('Catalyst::Plugin::CommandLine') };

can_ok('Catalyst::Plugin::CommandLine', 'commandline');
can_ok('Catalyst::Plugin::CommandLine', 'commandline_mode');

