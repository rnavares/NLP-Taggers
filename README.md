# NLP Taggers

A comparison of Part-of-Speech statistical taggers based on HMM over bigrams and binary decision trees. 

## Getting Started

A Perl5 wrapper to Lingua-EN-Tagger and Tree-Tagger 

### Prerequisites

Perl is a high-level programming language that comes installed by default in Linux.

```
sh sudo cpan
cpan[1]> upgrade
```

or 

```
sh sudo perl -MCPAN -e 'upgrade'
```


Install the Tree-Tagger, also available in http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/

```
sh install-tagger.sh
```

Install Lingua-EN-Tagger, also available in http://search.cpan.org/dist/Lingua-EN-Tagger/Tagger.pm

```
sh cpan Lingua::EN::Tagger
```


## Running the wrapper

```
sh sudo chmod +x wrapper.pl
sh perl wrapper.pl
```

### Results

Go to guide.pdf to check the results and licences 

