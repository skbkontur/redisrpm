FROM centos:7

ARG WORKDIR

RUN echo "8.8.8.8 example.com" >> /etc/hosts

RUN yum update -y
RUN yum upgrade -y
RUN yum groupinstall -y "Development tools"
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y fedora-packager
RUN yum clean all

RUN useradd builder

WORKDIR ${WORKDIR}
COPY SOURCES/ ${WORKDIR}/SOURCES
COPY SPECS/ ${WORKDIR}/SPECS

RUN chown -R builder.builder ${WORKDIR}

USER builder
RUN spectool -g -R SPECS/redis.spec
RUN rpmbuild -ba SPECS/redis.spec