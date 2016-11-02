package Apptest::Test;

use Moose;
use Apptest::UserAgent;
use Data::Dumper;

has ua => (
  is      => 'ro',
  default => sub {
    return Apptest::UserAgent->new;
  }
);

has project => (
  is       => 'ro',
  required => 1,
);

has host => (
  is      => 'rw',
  default => sub { "127.0.0.1" },
);

has port => (
  is      => 'rw',
  default => sub { "80" },
);

has expected_code => (
  is      => 'rw',
  default => sub { 200 },
);

sub test {
  my ( $self, $param ) = @_;

  $param->{location} = (
    ref $param->{location} eq "ARRAY"
    ? $param->{location}
    : [ $param->{location} ] );

  my $host = $self->host;
  my $port = $self->port;

  for my $loc ( @{ $param->{location} } ) {
    my @failures;
    Rex::Logger::info("Testing: http://$host:$port$loc");
    my $res = $self->ua->get("http://$host:$port$loc");

    while ( $res->code != $self->expected_code ) {
      if (scalar @failures > 3) {
        Rex::Logger::info( $_, "error" ) for @failures;
        die "Test failed.";
      }
      Rex::Logger::info("Error testing. Retrying...");
      push @failures,
          "Error testing url: http://$host:$port$loc\n"
        . "Status Code: "
        . $res->code . "\n"
        . "Status Line: "
        . $res->message . "\n";
      sleep 1;
      $res = $self->ua->get("http://$host:$port$loc");
    }
    Rex::Logger::info("Done Testing.");
  }
}

1;
