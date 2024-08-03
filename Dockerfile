FROM python:3.13.0b4-slim

RUN mkdir -p /data/input /data/output
RUN useradd -m unblob
RUN chown -R unblob /data

WORKDIR /data/output

COPY unblob/install-deps.sh /
RUN /install-deps.sh

USER unblob
ENV PATH="/home/unblob/.local/bin:${PATH}"

# You MUST do a poetry build before to have the wheel to copy & install here (CI action will do this when building)
COPY dist/*.whl /tmp/
RUN pip --disable-pip-version-check install --upgrade pip
RUN pip install /tmp/unblob*.whl

ENTRYPOINT ["unblob"]
