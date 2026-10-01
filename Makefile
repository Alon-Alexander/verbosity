.PHONY: test document cmdcheck r

test:
	Rscript -e "devtools::test()"

document:
	Rscript -e "devtools::document()"

cmdcheck:
	Rscript -e "rcmdcheck::rcmdcheck()"

r:
	@echo 'devtools::load_all()' > .Rprofile.session
	@exec env R_PROFILE_USER=$$(pwd)/.Rprofile.session R --quiet --no-save --no-restore-data < /dev/tty
