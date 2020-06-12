FROM python:3
ENV PORT 8080
EXPOSE 8080

WORKDIR /opt/metamorph
RUN pip3 install mkdocs
COPY . /opt/metamorph
CMD /usr/local/bin/mkdocs serve -a 0.0.0.0:8000
