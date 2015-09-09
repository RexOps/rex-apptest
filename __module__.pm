#
# (c) 2015 FILIADATA GmbH
# 
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Apptest;


use Data::Dumper;
use common::sense;
use Rex -base;
use Apptest::Test;

task "test", group => "servers", sub {
  my $param = shift;

  $param->{test_object} ||= "Apptest::Test";

  my $test = $param->{test_object}->new(project => $param->{project}, expected_code => $param->{expected_code});
  print Dumper $param->{project}->application->get_deployable_instance();
  $test->port($param->{project}->application->get_deployable_instance()->port);
  

  $test->test($param);
};

1;

__END__

=pod

=head1 NAME

Apptest - Module to test web applications.

This module can be integrated into a deployment chain to test the deployed application before it is activated in a loadbalancer.

=head1 SYNOPSIS

 use Apptest;
    
 do_task_param "Apptest:test", {
   project  => $project,
   location => "/health/alive",
 };  

It is also possible to define custom test classes. The only requirement for such a test class is the need of the I<test()> method. This method must I<die()> if the test failes.


=head1 COPYRIGHT

Copyright 2015 FILIADATA GmbH

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

