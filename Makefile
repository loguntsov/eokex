REBAR=./rebar3

.PHONY: all clean test

all:
	$(REBAR) compile

edoc:
	$(REBAR) doc

clean:
	$(REBAR) clean

build_plt:
	$(REBAR) build-plt

dialyzer:
	$(REBAR) dialyze

.PHONY: run
run:
	rm -rf ./log/*
	$(REBAR) shell

.PHONY: test
test:
	rm -rf test/ct_logs
#	$(REBAR) eunit --application=ai_net
	$(REBAR) ct

.PHONY: release
release:
	$(REBAR) release
	rm -rf _build/default/rel/ai_net/log/*

.PHONY: start
start: release
	cd _build/default/rel/ai_net/ && \
	    ./bin/ai_net start

.PHONY: stop
stop:
	cd _build/default/rel/ai_net/ && \
	    ./bin/ai_net stop

.PHONY: restart
restart:
	cd _build/default/rel/ai_net/ && \
	    bin/ai_net restart

.PHONY: status
status:
	cd _build/default/rel/ai_net/ && \
	    ./bin/ai_net status

.PHONY: console
console: release
	cd _build/default/rel/ai_net/ && \
	    ./bin/ai_net console



