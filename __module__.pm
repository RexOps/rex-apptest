package Apptest;


use common::sense;
use Rex -base;
use Apptest::Test;

task "test", group => "servers", sub {
  my $param = shift;

  $param->{test_object} ||= "Apptest::Test";

  my $test = $param->{test_object}->new();

  $test->test($param);
};

1;
