all: publishers.dtd

DEBUG=0

publishers.dtd: ../../publishers/dtd.rng overrides/publishers.xml
	calabash -isource=$< -oresult=$@ pipe.xpl override=overrides/publishers.xml debug=$(DEBUG)

docbook.dtd: ../../docbook/dtd.rng overrides/docbook.xml
	calabash -isource=$< -oresult=$@ pipe.xpl override=overrides/docbook.xml debug=$(DEBUG)

assembly.dtd: ../../docbook/assemblydtd.rng overrides/assembly.xml
	calabash -isource=$< -oresult=$@ pipe.xpl override=overrides/assembly.xml debug=$(DEBUG)
