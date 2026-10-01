.PHONY: test document cmdcheck

test:
	Rscript -e "devtools::test()"

document:
	Rscript -e "devtools::document()"

cmdcheck:
	Rscript -e "rcmdcheck::rcmdcheck()"
