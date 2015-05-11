package Apptest::UserAgent;

use common::sense;
use Moose;
use Mojo::Message::Response;
use Rex::Commands::Run;

sub get {
  my ($self, $url) = @_;

  my $out = run "curl -s -D- '$url'";

  my $resp = Mojo::Message::Response->new();
  $resp->parse($out);

  return $resp;
}
   
1;
