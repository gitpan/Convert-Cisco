#=============================================================

package Convert::Cisco;

use warnings;
use strict;

use FileHandle;
use File::Basename;
use Log::Log4perl qw(get_logger);
use YAML::Syck qw(Dump Load);
use DateTime;
use XML::Writer;
use Math::Round qw(nhimult);

=head1 NAME

Convert::Cisco - Module for converting Cisco billing records

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Module used to convert Cisco billing records into XML

    use Convert::Cisco;

    my $obj = Convert::Cisco->new();
    $obj->to_xml("test.bin", "test.xml");

=head1 FUNCTIONS

#-------------------------------------------------------------

=head2 new

=cut

sub new {
   my $class = shift;
   my $self = bless {}, $class;

   $self->{config} = Load(join("\n", <Convert::Cisco::DATA>));

   return $self;
}

#-------------------------------------------------------------

=head2 cdbTags

=cut

sub cdbTags {
   my ($self) = @_;
   get_logger->warn("CDBs not configured") unless exists $self->{config}{"CDB Records"};
   return keys %{$self->{config}{"CDB Records"}};
}

#-------------------------------------------------------------

=head2 cdbName

=cut

sub cdbName {
   my ($self, $key) = @_;
   get_logger->warn("CDB not configured: ", $key) unless exists $self->{config}{"CDB Records"}{$key};
   return $self->{config}{"CDB Records"}{$key}{name};
}

#-------------------------------------------------------------

=head2 cdbElements

=cut

sub cdbElements {
   my ($self, $key) = @_;
   get_logger->warn("CDB not configured: ", $key) unless exists $self->{config}{"CDB Records"}{$key};
   return sort @{$self->{config}{"CDB Records"}{$key}{elements}};
}

#-------------------------------------------------------------

=head2 cdeName

=cut

sub cdeName {
   my ($self, $key) = @_;
   get_logger->warn("CDE not configured: ", $key) unless exists $self->{config}{"CDE Records"}{$key};
   return $self->{config}{"CDE Records"}{$key}{name};
}

#-------------------------------------------------------------

=head2 cdeValue

=cut

sub cdeValue {
   my ($self, $key, $value) = @_;
   my $log = get_logger;
   get_logger->warn("CDE not configured: ", $key) unless exists $self->{config}{"CDE Records"}{$key};

   if (ref($self->{config}{"CDE Records"}{$key}{spec})) {
      return join("-", unpack(join(" ", @{$self->{config}{"CDE Records"}{$key}{spec}}), $value));
   }
   else {
      return unpack($self->{config}{"CDE Records"}{$key}{spec}, $value)
   }
}

#-------------------------------------------------------------

=head2 to_xml

=cut

sub to_xml {
   my ($self, $filename, $filename_output) = @_;
   my $log = get_logger;

   ### Print the name of the file processed
   $log->debug("Processing: ", $filename);

   ### Input file
   my $infile = new FileHandle($filename, "r") or $log->logcroak("Cannot open $filename - $!");
   binmode $infile;

   ### Output file
   my $file = new FileHandle($filename_output, "w") or $log->logcroak("Cannot open $filename_output - $!");

   ### XML Writer object
   my $writer = XML::Writer->new(OUTPUT => $file, DATA_MODE=>1, DATA_INDENT=>2);

   $writer->xmlDecl("UTF-8");
   $writer->pi('xml-stylesheet', 'href="cdrs.xsl" type="text/xsl"');
   $writer->startTag("cdrs");

   ### Convert the file into CSV format
   my $bin;
   my $i = 0;
   my $recordCount = 0;

   while ($infile->read($bin, 4)) {
      $i++;

      ### Read the Call Data Block
      my ($tag, $length) = unpack("n2", $bin);
      $infile->read($bin, $length);

      ### Decode the Call Data Elements
      # TLV format : Tag, Length, Value
      my %cde  = unpack("(n n/a*)*", $bin);

      ### Dump the CDB record
      $log->debug("CDB Record:\n", { filter => \&Dump, value  => [$tag, \%cde] });

      ### Decode the record
      if (defined $self->cdbName($tag)) {
	 my @values;

	 ### 4001 holds the record epoch value
	 my $timepoint = $self->cdeValue(4001, $cde{4001});

	 ### Insert the name of the CDB and the timestamp
	 $writer->startTag("cdb",
		 tag => $tag,
		 name => $self->cdbName($tag),
		 timestamp => DateTime->from_epoch(epoch => $timepoint)->datetime,
		 timestamp_10mins => DateTime->from_epoch(epoch => nhimult(600, $timepoint))->datetime,
	 );

	 foreach my $element ( $self->cdbElements($tag) ) {
	    $writer->emptyTag($self->cdeName($element), tag=>$element, value=>$self->cdeValue($element, $cde{$element}));
	 }

	 ### Read number of records from Footer record
	 if ($tag == 1100) {
	    $recordCount = $self->cdeValue(6003, $cde{6003});
	 }

         ### End tag
	 $writer->endTag("cdb");
      }
      else {
         $log->logcroak("Unknown CDB record: ", $tag);
      }
   }

   ### Audit check
   if ($i != $recordCount) {
      $log->logcroak("Footer does not match number of records");
   }

   ### Cleanup
   $infile->close;
   $writer->endTag("cdrs");
   $file->print("\n");
   $file->close;
}

#-------------------------------------------------------------

=head1 AUTHOR

Mark O'Connor, C<< <marko@cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-convert-cisco at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Convert-Cisco>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Convert::Cisco

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Convert-Cisco>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Convert-Cisco>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Convert-Cisco>

=item * Search CPAN

L<http://search.cpan.org/dist/Convert-Cisco>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2007 Mark O'Connor, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Convert::Cisco

__DATA__
#===========================================================================
#
# The Cisco billing record is documented on the cisco website:
#
# http://www.cisco.com/univercd/cc/td/doc/product/access/sc/rel9/billinf/r9chap1.htm
#
#===========================================================================

#
# Each CDB record consists of a sequence of CDE elements
#
CDB Records:
  1090:
    name: Header
    elements:
      - 4001
      - 6000
      - 6004
  1100:
    name: Footer
    elements:
      - 4001
      - 6000
      - 6004
      - 6003
  1010: 
    name: Answer
    elements:
      - 3000
      - 3001
      - 3003
      - 3005
      - 3007
      - 3008
      - 3009
      - 3011
      - 4000
      - 4001
      - 4002
      - 4008
      - 4009
      - 4010
      - 4011
      - 4012
      - 4014
      - 4015
      - 4016
      - 4019
      - 4028
      - 4029
      - 4034
      - 4035
      - 4036
      - 4037
      - 4038
      - 4046
      - 4047
      - 4052
      - 4066
      - 4067
      - 4068
      - 4069
      - 4070
      - 4071
      - 4072
      - 4073
      - 4081
      - 4084
      - 4087
      - 4088
      - 4090
      - 4091
      - 4095
      - 4096
      - 4098
      - 4100
      - 4101
      - 4102
      - 4103
      - 4106
      - 4107
      - 4108
      - 4109
      - 5000
  1030:
    name: Abort
    elements:
      - 3000
      - 3001
      - 3003
      - 3005
      - 3007
      - 3008
      - 3009
      - 3011
      - 4000
      - 4001
      - 4002
      - 4008
      - 4009
      - 4010
      - 4011
      - 4012
      - 4014
      - 4015
      - 4016
      - 4019
      - 4028
      - 4029
      - 4034
      - 4035
      - 4036
      - 4037
      - 4038
      - 4046
      - 4047
      - 4052
      - 4066
      - 4067
      - 4068
      - 4069
      - 4070
      - 4071
      - 4072
      - 4073
      - 4081
      - 4084
      - 4087
      - 4088
      - 4090
      - 4091
      - 4095
      - 4096
      - 4098
      - 4100
      - 4101
      - 4102
      - 4103
      - 4106
      - 4107
      - 4108
      - 4109
      - 5000
  1040:
    name: Release
    elements:
      - 3008
      - 4000
      - 4001
      - 4002
      - 4019
      - 4028
      - 4030
      - 4046
      - 4047
      - 4081
      - 4087
      - 4088
      - 4090
      - 4091
      - 4098
      - 4106
      - 4107
      - 4108
      - 4109
      - 4213
      - 4214
      - 5000
      - 6005
  1060:
    name: Continue
    elements:
      - 3008
      - 4000
      - 4001
      - 4002
      - 4019
      - 4028
      - 4030
      - 4046
      - 4047
      - 4081
      - 4087
      - 4088
      - 4090
      - 4091
      - 4098
      - 4106
      - 4107
      - 4108
      - 4109
      - 4213
      - 4214
      - 5000
      - 6005
  1110:
    name: EndOfCall
    elements:
      - 3000
      - 3001
      - 3003
      - 3005
      - 3007
      - 3008
      - 3018
      - 4000
      - 4001
      - 4002
      - 4008
      - 4009
      - 4010
      - 4011
      - 4012
      - 4014
      - 4028
      - 4034
      - 4035
      - 4068
      - 4081
      - 4084
      - 4090
      - 4091
      - 4100
      - 4106
      - 4108
      - 4217
      - 5000

#
# Each CDE element has a different record format specfication
#
# C  - 1 Octet BE format
# n  - 2 Octet BE format
# N  - 4 Octet BE format
# H* - HEX string
# Z* - Character string (null padded)
#
CDE Records:
  3000:
    name: calling_party_category
    spec: H*
  3001:
    name: user_service_info
    spec: H*
  3003:
    name: calling_number_nature_of_address
    spec: H*
  3005:
    name: dialled_number_nature_of_address
    spec: H*
  3007:
    name: called_number_nature_of_address
    spec: H*
  3008:
    name: reason_code
    spec: H*
  3009:
    name: forward_call_indicators_received
    spec: H*
  3010:
    name: forward_call_indicators_sent
    spec: H*
  3011:
    name: nature_of_connection_indicators_received
    spec: H*
  3012:
    name: nature_of_connection_indicators_sent
    spec: H*
  3018:
    name: egress_calling_number_nature_of_address
    spec: C
  4000:
    name: version
    spec: C
  4001:
    name: timepoint
    spec: N
  4002:
    name: call_reference_id
    spec: H*
  4008:
    name: originating_trunk_group
    spec: n
  4009:
    name: originating_member
    spec: n
  4010:
    name: calling_number
    spec: Z*
  4011:
    name: charged_number
    spec: Z*
  4012:
    name: dialled_number
    spec: Z*
  4014:
    name: called_number
    spec: Z*
  4015:
    name: terminating_trunk_group
    spec: n
  4016:
    name: terminating_member
    spec: n
  4019:
    name: glare_encountered
    spec: C
  4028:
    name: first_release_source
    spec: C
  4029:
    name: lnp_dip
    spec: C
  4030:
    name: total_meter_pulses
    spec: n
  4034:
    name: ingress_originating_point_code
    spec: N
  4035:
    name: ingress_destination_code
    spec: N
  4036:
    name: egress_originating_point_code
    spec: N
  4037:
    name: egress_destination_code
    spec: N
  4038:
    name: ingress_media_gateway_id
    spec: n
  4039:
    name: egress_media_gateway_id
    spec: n
  4046:
    name: ingress_packet_info
    spec: 
      - N
      - N
      - N
      - N
      - N
      - N
      - N
      - N
  4047:
    name: egress_packet_info
    spec: 
      - N
      - N
      - N
      - N
      - N
      - N
      - N
      - N
  4048:
    name: directional_flag
    spec: C
  4052:
    name: originating_gateway_primary_select
    spec: C
  4053:
    name: terminating_gateway_primary_select
    spec: C
  4066:
    name: ingress_sigpath_id
    spec: H*
  4067:
    name: ingress_span_id
    spec: H*
  4068:
    name: ingress_bearchan_id
    spec: H*
  4069:
    name: ingress_protocol_id
    spec: C
  4070:
    name: egress_sigpath_id
    spec: H*
  4071:
    name: egress_span_id
    spec: H*
  4072:
    name: egress_bearchan_id
    spec: H*
  4073:
    name: egress_protocol_id
    spec: C
  4081:
    name: fax_call
    spec: C
  4084:
    name: outgoing_calling_party_number
    spec: Z*
  4087:
    name: ingress_mgcp_dlcx_return_code
    spec: C
  4088:
    name: egress_mgcp_dlcx_return_code
    spec: C
  4089:
    name: network_translated_address_indicator
    spec: C
  4090:
    name: reservation_request_accepted
    spec: C
  4091:
    name: reservation_request_error_count
    spec: C
  4095:
    name: route_list_name
    spec: Z*
  4096:
    name: route_name
    spec: Z*
  4098:
    name: originating_leg_dsp_stats
    spec: Z*
  4099:
    name: terminating_leg_dsp_stats
    spec: Z*
  4100:
    name: iam_timepoint_received
    spec: 
       - N
       - n
  4101:
    name: iam_timepoint_sent
    spec: 
       - N
       - n
  4102:
    name: acm_timepoint_received
    spec: 
       - N
       - n
  4103:
    name: acm_timepoint_sent
    spec: 
       - N
       - n
  4106:
    name: first_rel_timepoint_ms
    spec: 
       - N
       - n
  4107:
    name: second_rel_timepoint_ms
    spec: 
       - N
       - n
  4108:
    name: rlc_timepoint_received
    spec: 
       - N
       - n
  4109:
    name: rlc_timepoint_sent
    spec: 
       - N
       - n
  4213:
    name: meter_pulse_received
    spec: N
  4214:
    name: meter_pulse_sent
    spec: N
  4217:
    name: short_call_indicator
    spec: C
  5000:
    name: unique_call_correlator_id
    spec: H*
  6000:
    name: source
    spec: Z*
  6003:
    name: record_count
    spec: N
  6004:
    name: version
    spec: Z*
  6005:
    name: interim_cdb
    spec: C
