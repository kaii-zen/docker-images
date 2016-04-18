default: node python

MAKE_IT = $(MAKE) -C $@

base:
	$(MAKE_IT)

node: base
	$(MAKE_IT)

python: base
	$(MAKE_IT)

.PHONY: default base node python
