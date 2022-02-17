DIALECTS = geoscan common minimal
CMD_COPY_MSG_DEFS = $(foreach msg_def,$(DIALECTS),cp ./message_definitions/v1.0/$(msg_def).xml pymavlink/mdefs_temp/v1.0;)

all:
	mkdir -p build; cd build; cmake .. && make -j4

venv:
	python3 -m venv ./venv

pymavlink: venv
	mkdir -p pymavlink/mdefs_temp/v1.0
	$(CMD_COPY_MSG_DEFS)
	. ./venv/bin/activate && MDEF=mdefs_temp python -m pip install ./pymavlink -v
.PHONY: pymavlink
