package Apptest;


use common::sense;
use Rex -base;

task "test", group => "servers", sub {
  my $param = shift;

  my $ua = Apptest::UserAgent->new;
  $param->{location} = ( ref $param->{location} eq "ARRAY" ? $param->{location} : [ $param->{location} ] );
  $param->{port}     = ( ref $param->{port} eq "CODE" ? $param->{port}->() : $param->{port} );
  $param->{host}     = ( ref $param->{host} eq "CODE" ? $param->{host}->() : $param->{host} );

  for my $loc ( @$param->{location} ) {
    my $res = $ua->get("http://$param->{host}:$param->{port}$loc");
    if($res->code != 200) {
      die "Error testing url: http://$param->{host}:$param->{port}$loc";
    }
  }

};

1;
