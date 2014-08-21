empty :=
space := $(empty) $(empty)

CP=$(subst  $(space),:,$(wildcard ../../../../lib/*.jar))
CALABASH=java -cp $(CLASSPATH):$(CP) com.xmlcalabash.drivers.Main

DBPASS=../../../../relaxng/schemas/docbook/test/pass
VPATH=$(DBPASS):pass:fail

PASS=$(notdir $(patsubst %.xml,%.pass,$(wildcard pass/*.xml))) \
     $(notdir $(patsubst %.xml,%.pass,$(wildcard $(DBPASS)/*.xml)))
FAIL=$(notdir $(patsubst %.xml,%.fail,$(wildcard fail/*.xml)))
TARGETS=$(PASS) $(FAIL)

all: $(TARGETS)
	echo $(TARGETS)

clean:
	rm -f $(TARGETS)

%.pass: %.xml ../docbook.xsd
	@echo -n "Validate $< "
	$(CALABASH) -isource=$< -oresult=$@ ../../../tools/validate-pass.xpl schema=../docbook.xsd
	@cat $@

%.fail: %.xml ../docbook.xsd
	@echo -n "Validate $< "
	@$(CALABASH) -isource=$< -oresult=$@ ../../../tools/validate-fail.xpl schema=../docbook.xsd
	@cat $@
