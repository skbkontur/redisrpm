FROM centos:7


RUN echo "8.8.8.8 example.com" >> /etc/hosts

RUN yum update -y && yum upgrade -y && \
    yum install -y \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    fedora-packager \
    devtoolset-8 \
    centos-release-scl \
    patch \
    rpm-build \
    spectool

RUN useradd builder

ARG WORKDIR
WORKDIR ${WORKDIR}
COPY SOURCES/ ${WORKDIR}/SOURCES
COPY SPECS/ ${WORKDIR}/SPECS
COPY repo.patch ${WORKDIR}/repo.patch

RUN patch /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo repo.patch && \
    cat /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo

RUN yum-builddep -y SPECS/redis.spec

RUN chown -R builder.builder ${WORKDIR}
USER builder
RUN spectool -g -R SPECS/redis.spec
RUN rpmbuild -ba SPECS/redis.spec
