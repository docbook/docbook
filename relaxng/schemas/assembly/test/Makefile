empty :=
space := $(empty) $(empty)

CLASSPATH=$(subst  $(space),:,$(wildcard ../../../../lib/*.jar))
CALABASH=java -cp $(CLASSPATH) com.xmlcalabash.drivers.Main

VPATH=pass:fail
PASS=$(notdir $(patsubst %.xml,%.pass,$(wildcard pass/*.xml)))
FAIL=$(notdir $(patsubst %.xml,%.fail,$(wildcard fail/*.xml)))
TARGETS=$(PASS) $(FAIL)

all: $(TARGETS)

clean:
	rm -f $(TARGETS)

%.pass: %.xml ../../assembly.rng ../../assembly.sch
	@echo -n "Validate $< "
	@$(CALABASH) -isource=$< -oresult=$@ ../../../tools/validate-pass.xpl schema=../../assembly
	@cat $@

%.fail: %.xml ../../assembly.rng ../../assembly.sch
	@echo -n "Validate $< "
	@$(CALABASH) -isource=$< -oresult=$@ ../../../tools/validate-fail.xpl schema=../../assembly
	@cat $@
