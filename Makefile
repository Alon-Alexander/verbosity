.PHONY: test document pkgdown cmdcheck r

test:
	Rscript -e "devtools::test()"

document:
	Rscript -e "devtools::document()"

pkgdown:
	Rscript -e "pkgdown::build_site()"

cmdcheck:
	Rscript -e "rcmdcheck::rcmdcheck(args = c('--no-manual', '--compact-vignettes=gs+qpdf'), error_on = 'warning')"

r:
	@echo 'devtools::load_all()' > .Rprofile.session
	@exec env R_PROFILE_USER=$$(pwd)/.Rprofile.session R --quiet --no-save --no-restore-data < /dev/tty
