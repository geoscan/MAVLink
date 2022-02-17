FILTER_DIALECTS = all

all:
	mkdir -p build; cd build; cmake .. && make -j4

venv:
	python3 -m venv ./venv

pymavlink: venv
	mkdir -p pymavlink/mdefs_temp/v1.0
	cp -R message_definitions pymavlink

	$(foreach filtered,$(FILTER_DIALECTS),rm pymavlink/message_definitions/v1.0/$(filtered).xml;)

	. ./venv/bin/activate && MDEF=message_definitions python -m pip install ./pymavlink -v
.PHONY: pymavlink
