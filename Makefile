all:
	$(MAKE) -C relaxng/schemas
	$(MAKE) -C xmlschema/schemas

clean:
	$(MAKE) -C relaxng/schemas clean
	$(MAKE) -C xmlschema/schemas clean
