#!/usr/bin/perl -w

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME           => 'qpsmtpd',
    VERSION_FROM   => 'lib/Qpsmtpd.pm',
    PREREQ_PM      => {
        'CDB_File'        => 0,
        'Data::Dumper'    => 0,
        'Date::Parse'     => 0,
        'File::Temp'      => 0,
        'Mail::Header'    => 0,
        'MIME::Base64'    => 0,
        'Net::DNS'        => 0.79,
        'Net::IP'         => 1.26,
        'Time::HiRes'     => 0,
        'IO::Socket::SSL' => 0,
# Dev/Test modules
        'Test::More'      => 0,
        'Test::Output'    => 0,
# modules for specific features
        'ClamAV::Client'  => 0,    # virus/clamdscan
        'File::NFSLock'   => 0,
        'File::Tail'      => 0,    # log/summarize, log/watch
        'GeoIP2'          => 2,
        'Mail::SPF'       => 1,
        'Mail::DKIM'      => 0.40,
        'Mail::DMARC'     => 0,
        'Mail::SpamAssassin' => 0,
        'Time::TAI64'     => 0,    # log2sql
        'Redis'           => 0,
#       'DBI'             => 0,    # auth_vpopmail_sql and
#       'DBD::mysql'      => 0,    # log2sql
#       'DBIx::Simple'    => 0,    # log2sql
        'Math::Complex'   => 0,    # geodesic distance in Geo::IP
    },
    ABSTRACT       => 'Flexible smtpd daemon written in Perl',
    AUTHOR         => 'Ask Bjoern Hansen <ask@develooper.com>',
    EXE_FILES      => [qw(qpsmtpd qpsmtpd-forkserver qpsmtpd-prefork)],
    clean          => { FILES => [ '*.bak', 't/tmp' ], },
);

sub MY::libscan {
    my $path = $_[1];
    return '' if $path =~ /\B\.svn\b/;
    return $path;
}

sub MY::postamble {
    qq[
testcover :
\t cover -delete && \\
    HARNESS_PERL_SWITCHES=-MDevel::Cover \$(MAKE) test && \\
    cover
]

}
