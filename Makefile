SCHEME = scm754
DAYS = day01 day02 day03 # day04 day05 day06 day07 day08 day09 day10 day11 day12

.PHONY: all $(DAYS)

all: $(DAYS)

$(DAYS):
	@echo "== $@ ======================="
	@cd $@ && time $(SCHEME) do.scm
