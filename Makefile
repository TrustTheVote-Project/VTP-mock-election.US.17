# Ancient Makefile implicit rule disabler
(%): %
%:: %,v
%:: RCS/%,v
%:: s.%
%:: SCCS/s.%
%.out: %
%.c: %.w %.ch
%.tex: %.w %.ch
%.mk:

# Variables
# Because a receipt.md file contains two header lines since it is markdown
REAL_ROW_MD = $(shell expr ${row} + 2)
REAL_ROW_CSV = $(shell expr ${row} + 1)

INTERACTIVE := $(shell test -t 0 && echo 1)
ifdef INTERACTIVE
    RED	:= \033[0;31m
    END	:= \033[0m
else
    RED	:=
    END	:=
endif

# Let there be no default target
.PHONY: default
default:
	@echo "${RED}There is no default make target.${END}  Specify one of:"
	@echo "row-md file=<path> row=<n>   - will print row n from a voucher"
	@echo "                               .md (markdown) file"
	@echo "row-csv file=<path> row=<n>  - will print row n from a voucher"
	@echo "                               .csv file"

# extract a row from a ballot voucher
.PHONY: row-md
row-md:
	sed -n '${REAL_ROW_MD}'p "${file}"
.PHONY: row-csv
row-csv:
	sed -n '${REAL_ROW_CSV}'p "${file}"

# emacs tags
.PHONY: TAGS
TAGS:
	find . -type file -name '*.yaml' -print0 | xargs -0 -o etags
