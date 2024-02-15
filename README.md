# The DocBook Schemas

[![build-specs](https://github.com/docbook/docbook/actions/workflows/build-branch.yml/badge.svg)](https://github.com/docbook/docbook/actions/workflows/build-branch.yml)

This repository contains the sources for the DocBook schemas. On 23
July 2020, the branching structure was reorganized. Apologies for any
inconvenience caused. Going forward:

* `main` is the primary development branch. This is where v.next is developed (currently 5.2)
  This branch used to be called `docbook-5.2-dev`.
* `docbook-5.1` is DocBook 5.1
* `docbook50-rewind` is DocBook 5.0. This branch has a slightly odd name because we failed to
  properly tag and branch 5.0 when we did it; Norm had to reconstruct this branch from the history.
  The -rewind name is to acknowledge this fact.
* `gh-pages` contains some generated content; this needs work, TBH

There are a few other moribund and stale branches lying around. Those may get removed
eventually.
