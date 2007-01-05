#===========================================================================

=head1 t::Convert::CiscoTest 

=head1 Methods

=cut

package t::Convert::CiscoTest;
use base qw(t::TestCase);

use strict;
use Convert::Cisco;

#----------------------------------------

=head2 test_nofile

=cut

sub test_nofile {
   my $self = shift;

   ### Test
   eval {
      my $obj = Convert::Cisco->new();
      $obj->to_xml("test.bin", "test.xml");
   };

   ### Assertions
   $self->assert_not_null($@, "Expected error to be thrown");
   $self->assert_log("FATAL> Cannot open test.bin - No such file or directory at t/Convert/CiscoTest.pm line 27\n");
}

#----------------------------------------

=head2 test_to_xml

=cut

sub test_to_xml {
   my $self = shift;
   $self->register_file("test.xml");

   ### Test
   my $obj = Convert::Cisco->new();
   $obj->to_xml("t/data/cdr_20061026133657_105573.bin", "test.xml");

   ### Assertions
   $self->assert_file_contents_is("test.xml", <<END);
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet href="cdrs.xsl" type="text/xsl"?>

<cdrs>
  <cdb tag="1090" name="Header" timestamp="2006-10-26T11:36:57" timestamp_10mins="2006-10-26T11:40:00">
    <timepoint tag="4001" value="1161862617" />
    <source tag="6000" value="TestLab" />
    <version tag="6004" value="9.6(1)" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T11:53:43" timestamp_10mins="2006-10-26T12:00:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="8090a3" />
    <calling_number_nature_of_address tag="3003" value="02" />
    <dialled_number_nature_of_address tag="3005" value="02" />
    <called_number_nature_of_address tag="3007" value="02" />
    <reason_code tag="3008" value="809f" />
    <egress_calling_number_nature_of_address tag="3018" value="2" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161863623" />
    <call_reference_id tag="4002" value="4540a1c7000001df" />
    <originating_trunk_group tag="4008" value="5004" />
    <originating_member tag="4009" value="1" />
    <calling_number tag="4010" value="25" />
    <charged_number tag="4011" value="25" />
    <dialled_number tag="4012" value="796441781" />
    <called_number tag="4014" value="796441781" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="0" />
    <ingress_destination_code tag="4035" value="0" />
    <ingress_bearchan_id tag="4068" value="00000001" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="25" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161863623-454" />
    <first_rel_timepoint_ms tag="4106" value="1161863623-469" />
    <rlc_timepoint_received tag="4108" value="1161863623-680" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="cb73d89165b111db81df0003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T11:54:23" timestamp_10mins="2006-10-26T12:00:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="8090a3" />
    <calling_number_nature_of_address tag="3003" value="02" />
    <dialled_number_nature_of_address tag="3005" value="02" />
    <called_number_nature_of_address tag="3007" value="02" />
    <reason_code tag="3008" value="8092" />
    <egress_calling_number_nature_of_address tag="3018" value="2" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161863663" />
    <call_reference_id tag="4002" value="4540a1e7000001e3" />
    <originating_trunk_group tag="4008" value="5004" />
    <originating_member tag="4009" value="1" />
    <calling_number tag="4010" value="32" />
    <charged_number tag="4011" value="32" />
    <dialled_number tag="4012" value="796441781" />
    <called_number tag="4014" value="796441781" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="0" />
    <ingress_destination_code tag="4035" value="0" />
    <ingress_bearchan_id tag="4068" value="00000001" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="32" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161863655-214" />
    <first_rel_timepoint_ms tag="4106" value="1161863655-216" />
    <rlc_timepoint_received tag="4108" value="1161863663-200" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="de620cc265b111db81e30003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T11:58:15" timestamp_10mins="2006-10-26T12:00:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="8090a3" />
    <calling_number_nature_of_address tag="3003" value="02" />
    <dialled_number_nature_of_address tag="3005" value="02" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8092" />
    <egress_calling_number_nature_of_address tag="3018" value="3" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161863895" />
    <call_reference_id tag="4002" value="4540a2ce000001fb" />
    <originating_trunk_group tag="4008" value="5004" />
    <originating_member tag="4009" value="1" />
    <calling_number tag="4010" value="32" />
    <charged_number tag="4011" value="445346061" />
    <dialled_number tag="4012" value="0796441781" />
    <called_number tag="4014" value="796441781" />
    <first_release_source tag="4028" value="0" />
    <ingress_originating_point_code tag="4034" value="0" />
    <ingress_destination_code tag="4035" value="0" />
    <ingress_bearchan_id tag="4068" value="00000001" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="445346061" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161863886-934" />
    <first_rel_timepoint_ms tag="4106" value="1161863894-941" />
    <rlc_timepoint_received tag="4108" value="1161863895-210" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="687fbb1b65b211db81fb0003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T11:58:35" timestamp_10mins="2006-10-26T12:00:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="8090a3" />
    <calling_number_nature_of_address tag="3003" value="02" />
    <dialled_number_nature_of_address tag="3005" value="02" />
    <called_number_nature_of_address tag="3007" value="02" />
    <reason_code tag="3008" value="8081" />
    <egress_calling_number_nature_of_address tag="3018" value="2" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161863915" />
    <call_reference_id tag="4002" value="4540a2eb000001ff" />
    <originating_trunk_group tag="4008" value="5004" />
    <originating_member tag="4009" value="1" />
    <calling_number tag="4010" value="32" />
    <charged_number tag="4011" value="32" />
    <dialled_number tag="4012" value="796441781" />
    <called_number tag="4014" value="796441781" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="0" />
    <ingress_destination_code tag="4035" value="0" />
    <ingress_bearchan_id tag="4068" value="00000001" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="32" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161863915-594" />
    <first_rel_timepoint_ms tag="4106" value="1161863915-596" />
    <rlc_timepoint_received tag="4108" value="1161863915-720" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="7994e96b65b211db81ff0003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:04:44" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864284" />
    <call_reference_id tag="4002" value="4540a45b00000225" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="27" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="0000001b" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864283-765" />
    <first_rel_timepoint_ms tag="4106" value="1161864283-773" />
    <rlc_timepoint_received tag="4108" value="1161864284-20" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="5507431565b311db82250003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:04:45" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864285" />
    <call_reference_id tag="4002" value="4540a45d00000226" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="29" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="0000001d" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864285-55" />
    <first_rel_timepoint_ms tag="4106" value="1161864285-57" />
    <rlc_timepoint_received tag="4108" value="1161864285-310" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="55cc193065b311db82260003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:04:46" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864286" />
    <call_reference_id tag="4002" value="4540a45e00000227" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="31" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="0000001f" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864286-345" />
    <first_rel_timepoint_ms tag="4106" value="1161864286-347" />
    <rlc_timepoint_received tag="4108" value="1161864286-590" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="5690f30765b311db82270003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:05:03" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864303" />
    <call_reference_id tag="4002" value="4540a46f0000022a" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="1" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="00000001" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864303-534" />
    <first_rel_timepoint_ms tag="4106" value="1161864303-537" />
    <rlc_timepoint_received tag="4108" value="1161864303-800" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="60cfeb3065b311db822a0003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:05:05" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864305" />
    <call_reference_id tag="4002" value="4540a4700000022b" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="3" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="00000003" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864304-825" />
    <first_rel_timepoint_ms tag="4106" value="1161864304-827" />
    <rlc_timepoint_received tag="4108" value="1161864305-80" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="6194c64d65b311db822b0003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:05:06" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864306" />
    <call_reference_id tag="4002" value="4540a4720000022c" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="5" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="00000005" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864306-75" />
    <first_rel_timepoint_ms tag="4106" value="1161864306-77" />
    <rlc_timepoint_received tag="4108" value="1161864306-330" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="6253802f65b311db822c0003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:05:43" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864343" />
    <call_reference_id tag="4002" value="4540a49700000231" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="7" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="00000007" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864343-445" />
    <first_rel_timepoint_ms tag="4106" value="1161864343-447" />
    <rlc_timepoint_received tag="4108" value="1161864343-701" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="7899b79d65b311db82310003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:05:45" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864345" />
    <call_reference_id tag="4002" value="4540a49800000232" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="9" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="00000009" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864344-755" />
    <first_rel_timepoint_ms tag="4106" value="1161864344-757" />
    <rlc_timepoint_received tag="4108" value="1161864345-12" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="79619af765b311db82320003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:05:46" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864346" />
    <call_reference_id tag="4002" value="4540a49900000233" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="11" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="0000000b" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864345-935" />
    <first_rel_timepoint_ms tag="4106" value="1161864345-937" />
    <rlc_timepoint_received tag="4108" value="1161864346-190" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="7a15ab7365b311db82330003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:05:48" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864348" />
    <call_reference_id tag="4002" value="4540a49b00000234" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="13" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="0000000d" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864347-905" />
    <first_rel_timepoint_ms tag="4106" value="1161864347-907" />
    <rlc_timepoint_received tag="4108" value="1161864348-170" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="7b423f8165b311db82340003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:05:49" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864349" />
    <call_reference_id tag="4002" value="4540a49d00000235" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="15" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="0000000f" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864349-194" />
    <first_rel_timepoint_ms tag="4106" value="1161864349-197" />
    <rlc_timepoint_received tag="4108" value="1161864349-510" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="7c0711f265b311db82350003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:05:50" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864350" />
    <call_reference_id tag="4002" value="4540a49e00000237" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="21" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="00000015" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864350-505" />
    <first_rel_timepoint_ms tag="4106" value="1161864350-507" />
    <rlc_timepoint_received tag="4108" value="1161864350-780" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="7ccf05ea65b311db82370003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:05:52" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864352" />
    <call_reference_id tag="4002" value="4540a4a000000238" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="19" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="00000013" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864352-555" />
    <first_rel_timepoint_ms tag="4106" value="1161864352-557" />
    <rlc_timepoint_received tag="4108" value="1161864352-800" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="7e07d07c65b311db82380003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:05:54" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864354" />
    <call_reference_id tag="4002" value="4540a4a100000239" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="17" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="00000011" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864353-844" />
    <first_rel_timepoint_ms tag="4106" value="1161864353-847" />
    <rlc_timepoint_received tag="4108" value="1161864354-100" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="7ecc9e3365b311db82390003ba683767" />
  </cdb>
  <cdb tag="1110" name="EndOfCall" timestamp="2006-10-26T12:05:55" timestamp_10mins="2006-10-26T12:10:00">
    <calling_party_category tag="3000" value="0a" />
    <user_service_info tag="3001" value="9090a3" />
    <calling_number_nature_of_address tag="3003" value="04" />
    <dialled_number_nature_of_address tag="3005" value="03" />
    <called_number_nature_of_address tag="3007" value="03" />
    <reason_code tag="3008" value="8aa6" />
    <egress_calling_number_nature_of_address tag="3018" value="4" />
    <version tag="4000" value="1" />
    <timepoint tag="4001" value="1161864355" />
    <call_reference_id tag="4002" value="4540a4a30000023a" />
    <originating_trunk_group tag="4008" value="3011" />
    <originating_member tag="4009" value="25" />
    <calling_number tag="4010" value="8645182910307" />
    <charged_number tag="4011" value="8645182910307" />
    <dialled_number tag="4012" value="445346096" />
    <called_number tag="4014" value="445346096" />
    <first_release_source tag="4028" value="2" />
    <ingress_originating_point_code tag="4034" value="11" />
    <ingress_destination_code tag="4035" value="4001" />
    <ingress_bearchan_id tag="4068" value="00000019" />
    <fax_call tag="4081" value="0" />
    <outgoing_calling_party_number tag="4084" value="8645182910307" />
    <reservation_request_accepted tag="4090" value="0" />
    <reservation_request_error_count tag="4091" value="0" />
    <iam_timepoint_received tag="4100" value="1161864355-44" />
    <first_rel_timepoint_ms tag="4106" value="1161864355-47" />
    <rlc_timepoint_received tag="4108" value="1161864355-300" />
    <short_call_indicator tag="4217" value="1" />
    <unique_call_correlator_id tag="5000" value="7f83b46e65b311db823a0003ba683767" />
  </cdb>
  <cdb tag="1100" name="Footer" timestamp="2006-10-26T12:36:57" timestamp_10mins="2006-10-26T12:40:00">
    <timepoint tag="4001" value="1161866217" />
    <source tag="6000" value="Lab_PGW" />
    <record_count tag="6003" value="21" />
    <version tag="6004" value="9.6(1)" />
  </cdb>
</cdrs>
END
}

1;
