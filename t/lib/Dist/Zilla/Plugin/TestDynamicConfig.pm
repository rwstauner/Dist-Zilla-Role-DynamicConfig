package Dist::Zilla::Plugin::TestDynamicConfig;
# ABSTRACT: Test Dist::Zilla::Role::DynamicConfig

use strict;
use warnings;
use Moose;
with qw(
	Dist::Zilla::Role::DynamicConfig
	Dist::Zilla::Role::Plugin
);

has 'extra' => (
	is      => 'ro',
	isa     => 'Str',
	default => '',
);

sub separate_local_config {
	my ($self, $config) = @_;
	my %other = (extra => delete $config->{extra} || '');
	return \%other;
}

no Moose;
1;
