WORKDIR := /home/builder/rpmbuild

PGKIMAGENAME  := redisrpm
PKGDOCKERFILE := redisrpm.Dockerfile

buildrpm:
	@docker build --build-arg WORKDIR=${WORKDIR} -t $(PGKIMAGENAME) -f $(PKGDOCKERFILE) .
	@docker run --name $(PGKIMAGENAME) -t -d $(PGKIMAGENAME)
	@docker cp $(PGKIMAGENAME):${WORKDIR}/RPMS RPMS
	@docker stop $(PGKIMAGENAME) && docker rm $(PGKIMAGENAME)
.PHONY: buildrpm