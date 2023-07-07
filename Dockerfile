FROM alpine:3.18

ENV TERRAFORM_VERSION=1.5.2

RUN apk add unzip wget jq

RUN wget -O hcl2json \
  "https://github.com/tmccombs/hcl2json/releases/download/v0.5.0/hcl2json_linux_amd64" \
  && chmod 755 hcl2json \
  && mv hcl2json /usr/local/bin

RUN wget -O /tmp/terraform_1.5.2_linux_amd64.zip \
  "https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_amd64.zip" \
  && cd /tmp \
  && unzip terraform_1.5.2_linux_amd64.zip \
  && mv terraform /usr/local/bin/ \
  && rm terraform_1.5.2_linux_amd64.zip

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
