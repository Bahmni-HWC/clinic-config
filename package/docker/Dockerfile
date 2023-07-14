FROM alpine

COPY openmrs /etc/bahmni_config/openmrs
COPY esanjeevani /etc/bahmni_config/esanjeevani
COPY masterdata /etc/bahmni_config/masterdata

COPY package/docker/start.sh start.sh
RUN chmod +x start.sh
CMD ["./start.sh"]
