#!/usr/bin/perl
use strict;
use warnings;

use Path::Class;
use Lingua::EN::Tagger;
use autodie; 
use Text::Table;
use 5.012;

#
# Read file obtained from Brown Corpus: http://www.nltk.org/nltk_data/
#

# as an example use ca03 from Brown corpus. 
# Select any as desired from: http://www.nltk.org/nltk_data/
my $file = file("ca03"); 
my $content = $file->slurp();

# get word by word the already tagged text
# and store them in a table "tabla" [word, tag]
my @words = split /\s+/, $content;
my @text_words;
my $tabla = Text::Table->new();
#untag
foreach my $word (@words) {
	my ($w,$t) = split /\//, $word;
	push @text_words, "$w\n";
	$tabla->add($w,$t);
	}


# save raw text without tags
my $filename = "raw_text.txt";
open(my $fid, '>', $filename) or  die "Cannot open '$filename'";
print $fid @text_words;
close $fid;

#save text in variables
my $read_file = file("raw_text.txt");
my $raw_content = $read_file->slurp();

#
# HMM Aaron Coburn Tagger
# http://search.cpan.org/~acoburn/Lingua-EN-Tagger/
#

my $p = new Lingua::EN::Tagger;

my $tagged = $p->add_tags($raw_content);
my $readable_text = $p->get_readable($raw_content);

$readable_text =~s/ /\n/g;
$readable_text =~s/\// /g;

my $tb_HMM = Text::Table->new("WORD","TAG");
my @line = split /\n/, $readable_text;

foreach my $s (@line) {
	
	 my ($word, $tag) = split / /,$s;
	 $tb_HMM->add($word, $tag);
}


#
# TREE TAGGER
# www.ims.uni-stuttgart.de/projekte/corplex/TreeTagger/DecisionTreeTagger.html
#

# point to your TreeTagger location
my $cmd_treetagger = "TreeTagger/bin/tree-tagger";
my $cmd_par = "TreeTagger/lib/english-utf8.par";
my $cmd =  `cat $filename | $cmd_treetagger -token $cmd_par `;

my $tb_TT = Text::Table->new("WORD","TAG");
@line = split /\n/, $cmd;

foreach my $s (@line) {
	
	my ($word, $tag) = split / /,$s;
	$tb_TT->add($word, $tag);
}

my $merged = Text::Table->new("\tBROWN","\t TREETAGGER","\tHMM");
$merged->add($tabla->select(0,1),$tb_TT->select(0,1),$tb_HMM->select(0,1));

print $merged;

# save results
my $out_file = "result.txt";
open(my $ofid, '>', $out_file) or  die "Cannot open '$out_file'";
print $ofid $merged;
close($ofid);


