package lalah;
use strict;
use warnings;
use utf8;
use parent qw/Amon2/;
our $VERSION='0.01';
use 5.008001;

sub load_config {
    +{
        pass => 'amuro',
    }
}

1;

__END__

=head1 NAME

lalah

Parallel proxy servers
We use IP addresses and multiple, in order to request to multiple servers in parallel, to avoid the limitation API.

lalah::psycomu -  lightweight proxy server

elemeth.pl - sample perl script

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head1 SUPPORTS

=head1 AUTHOR

rosiro https://github.com/rosiro

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.
