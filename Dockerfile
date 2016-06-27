# MySQL - configured for RTView
#
FROM mysql/mysql-server
MAINTAINER SL Corporation

COPY run.sh /opt/
COPY my.cnf /etc/

EXPOSE 3306

# Execute "run" script instead of built-in entry point script
CMD ["/opt/run.sh"]