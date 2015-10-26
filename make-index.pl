#!/usr/bin/perl -- # -*- Perl -*-

use strict;
use English;

# Hack hack hack

print <<EOF1;
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>DocBook Schemas</title>
<meta charset="utf-8"/>
</head>
<body>
<h1>DocBook Schemas</h1>

<p>These are the DocBook schemas.</p>

EOF1

my @branches = dirs("branch");
if (@branches) {
    print <<EOF2;
<h2>Branches</h2>
<p>Branches are experimental. Often they hold a single specific
feature that’s under development. They are transitive in nature
and have no normative standing whatsoever.</p>

EOF2

    print "<ul>\n";
    foreach my $branch (sort { $b cmp $a } @branches) {
        print "<li>$branch\n";
        print "<ul>\n";
        my @kinds = dirs("branch/$branch");
        for my $kind (sort { $b cmp $a } @kinds) {
            print "<li>$kind\n";
            print "<ul>\n";
            my @files = files("branch/$branch/$kind", "index.html");
            for my $file (sort @files) {
                $_ = $file;
                s/^[^\/]+\/[^\/]+\/[^\/]+\///;
                s/\/index\.html$//;
                print "<li><a href='$file'>$_</a></li>\n";
            }
            print "</ul></li>\n";
        }
        print "</ul></li>\n";
    }
    print "</ul>\n";
}

# ======================================================================

@branches = ();
opendir(DIR, "dev");
while (readdir(DIR)) {
    next if /^\.\.?$/;
    push (@branches, $_);
}
closedir(DIR);

if (@branches) {
    print <<EOF3;
<h2>Release under development</h2>
<p>This is the current release under development.
It has no normative standing. It should be considered experimental.
Please do try it out and report any problems that you encounter.
</p>

EOF3

   print "<ul>\n";
    my @kinds = dirs("dev");
    for my $kind (sort { $b cmp $a } @kinds) {
        print "<li>$kind\n";
        print "<ul>\n";
        my @files = files("dev/$kind", "index.html");
        for my $file (sort @files) {
            $_ = $file;
            s/^[^\/]+\/[^\/]+\///;
            s/\/index\.html$//;
            print "<li><a href='$file'>$_</a></li>\n";
        }
        print "</ul></li>\n";
    }
    print "</ul>\n";
}

@branches = ();
opendir(DIR, "release");
while (readdir(DIR)) {
    next if /^\.\.?$/;
    push (@branches, $_);
}
closedir(DIR);

if (@branches) {
    print <<EOF4;
<h2>Releases</h2>
<p>These are the released versions of DocBook. The normative
status of these releases varies by release.

EOF4

   print "<ul>\n";
    my @kinds = dirs("release");
    for my $kind (sort { $b cmp $a } @kinds) {
        if ($kind eq 'xml') {
            print "<li>DocBook XML\n";
        } elsif ($kind eq 'sgml') {
            print "<li>DocBook SGML\n";
        } else {
            print "<li>$kind\n";
        }

        print "<ul>\n";
        my @files = files("release/$kind", "index.html");

        my @docbook = ();
        my @publishers = ();
        my @sdocbook = ();
        my @slides = ();
        my @website = ();

        foreach my $file (@files) {
            $file =~ s/^[^\/]+\/[^\/]+\///;
            if ($file =~ /^publishers\//) {
                push(@publishers, $file);
            } elsif ($file =~ /^sdocbook\//) {
                push(@sdocbook, $file);
            } elsif ($file =~ /^slides\//) {
                push(@slides, $file);
            } elsif ($file =~ /^website\//) {
                push(@website, $file);
            } else {
                $file =~ s/^[^\/]+\/[^\/]+\///;
                $file =~ s/\/index\.html$//;
                push(@docbook, $file);
            }
        }

        for my $file (sort relcompare @docbook) {
            print "<li><a href='release/xml/$file'>$file</a></li>\n";
        }

        custom("DocBook Publishers", $kind, @publishers);

        print "</ul></li>\n";
    }
    print "</ul>\n";
}


print <<EOFEOF;
<p>If you have a question or comment about these releases, please
ask the DocBook Technical Committee.</p>
</body>
</html>
EOFEOF

sub dirs {
    my $dir = shift;
    local *DIR;

    my @dirs = ();
    opendir(DIR, $dir);
    while (readdir(DIR)) {
        next if /^\.\.?$/;
        push (@dirs, $_);
    }
    closedir(DIR);

    return @dirs;
}

sub files {
    my $dir = shift;
    my $fn = shift;
    local *DIR;

    my @files = ();
    open (FIND, "find $dir -type f -print |");
    while (<FIND>) {
        chop;
        push (@files, $_) if /\/$fn$/;
    }
    close (FIND);

    return @files;
}

sub custom {
    my $title = shift;
    my $kind = shift;
    my @releases = @_;

    my $root = $releases[0];
    $root =~ s/\/.*$//;

    print STDERR "$root\n";

    foreach my $rel (@releases) {
        $rel =~ s/[^\/]+\///;
        $rel =~ s/\/index\.html$//;
    }

    print "<li>$title\n<ul>\n";

    for my $file (sort relcompare @releases) {
        print "<li><a href='release/$kind/$root/$file'>$file</a></li>\n";
    }

    print "</ul></li>\n";
}

sub relcompare {
    my $A = $a;
    my $B = $b;

    $B =~ s/^[^\/]+\/[^\/]+\///;
    $B =~ s/\/index\.html$//;

    if ($A =~ /^\d/ && $B =~ /^[^\d]/) {
        return -1
    }

    if ($A =~ /^[^\d]/ && $B =~ /^\d/) {
        return 1
    }

    if ($A =~ /^\d/ && $B =~ /^\d/) {
        return vcompare($A,$B)
    }

    return $A cmp $B
}

sub vcompare {
    my $A = uc(shift);
    my $B = uc(shift);

    $A .= 'ZZ' if $A !~ /[A-Z]/;
    $B .= 'ZZ' if $B !~ /[A-Z]/;

    return $B cmp $A;
}
