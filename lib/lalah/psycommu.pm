package lalah::psycommu;
use strict;
use warnings;
use utf8;
use parent qw/lalah Amon2::Web/;
use File::Spec;

use Encode;
use Unicode::UTF8;
use LWP::UserAgent;
#use LWP::UserAgent::WithCache;

#my %cache_opt = (
#    'namespace' => 'lalah',
#    'cache_root' => File::Spec->catfile(File::HomeDir->my_home, '.cache'),
#    'default_expires_in' => 3600,
#);

sub dispatch {
    my ($c) = @_;

    my $req_url = $c->req->param('url');
    my $req_method = $c->req->param('method') || 'GET';
    my $req_pass = $c->req->param('pass');
    my $req_charset = $c->req->param('charset') || 'utf8';

    my $req_agent = $c->req->param('agent') || 'lalah';
    my $req_local_address = $c->req->param('local_address');

    if($req_url && $req_pass && $req_pass eq $c->config->{pass} ){
        #my $ua = LWP::UserAgent::WithCache->new(\%cache_opt);
        my %options = (
        );
        $options{agent} = $req_agent if($req_agent);
        $options{local_address} = $req_local_address if($req_local_address);

        my %request = (
            req_url => $req_url,
            req_mthod => $req_method,
            req_pass => $req_pass,
            req_charset => $req_charset,
            req_agent => $req_agent,
            req_local_address => $req_local_address,
        );

        my $ua = LWP::UserAgent->new( %options);
        $ua->timeout(10);

        my $req = HTTP::Request->new( $req_method => $req_url );
        my $res = $ua->request($req);

        use Data::Printer;

        my $content = '';
        if($res->is_success){
            warn "Success ".$req_url;

            if($req_charset eq 'utf8'){
                $content = Unicode::UTF8::encode_utf8($res->content);
            }
            else{
                warn "decode";
                $content = decode($req_charset,$res->content);
            }
        }
        else{
            $content = undef;
        }

        $c->render_json( +{ 
            request => \%request,
            result => {
                lwp => {
                    status => $res->status_line,
                },
                content => $content,
            },
        });
    }
}

__PACKAGE__->load_plugins(
    'Web::JSON',
);

__PACKAGE__->add_trigger(
    AFTER_DISPATCH => sub {
        my ( $c, $res ) = @_;
        # for your security
        $res->header( 'X-Content-Type-Options' => 'nosniff' );
        $res->header( 'X-Frame-Options' => 'DENY' );
    },
);

1;
