use strict;
use warnings;
use utf8;

use LWP::Simple;
use Coro;
use Coro::LWP;
use Data::Printer;
use Data::Dumper;
use JSON qw/encode_json decode_json/;

my $lalah_psycommu = 'http://192.168.1.25:5000';

my @psycommus = (
    'pyscommu1',
    'pyscommu2',
);
my $server_max = @psycommus;
sub server_address {
    my $i = 0;
    return sub {
        if($i >= $server_max){
            $i = 0;
        }
        $i++;
    }
}
my $server = server_address();

my @urllist = (
    'http://www.google.co.jp/',
    'http://www.yahoo.co.jp/',
);

my @coro;
for my $url (@urllist){
    push @coro, async {
        my $ua = LWP::UserAgent->new;
        my $res = $ua->get(@psycommus[$server->()].'?url='.$url.'&pass=amuro');
        if($res->is_success){
            my $decode_json = decode_json($res->content);
            print Dumper($decode_json);
        }
    };
}

$_->join for @coro;

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
