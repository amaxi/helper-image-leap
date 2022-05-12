FROM opensuse/leap:15.3

LABEL hu.npsh.maintainer="Maxi Attila <attila.maxi@gmail.com" \
      hu.npsh.version="0.4" \
      hu.npsh.build_date="2022-05-12" \
      hu.npsh.description="Helper image for everything: debug tools, s3 tools"

RUN zypper ar http://download.opensuse.org/distribution/leap/15.3/repo/oss/ leap-153-oss && \
    zypper ar http://download.opensuse.org/update/leap/15.3/sle/ leap-153-oss-update && \
    zypper ar http://download.opensuse.org/distribution/leap/15.3/repo/non-oss/ leap-153-non-oss && \
    zypper ar http://download.opensuse.org/update/leap/15.3/non-oss/ leap-153-non-oss-update && \
    zypper ar https://download.opensuse.org/repositories/Cloud:/Tools/openSUSE_Leap_15.3/ leap_cloud_tools && \
    zypper --non-interactive --gpg-auto-import-keys ref && \
    zypper -n in timezone curl w3m less vim iproute2 iputils wget telnet bind-utils wireshark tcpdump traceroute s3cmd lynx && \
    zypper rr --all && \
    rm /var/log/zypper.log && \
    rm /var/log/zypp/history

RUN mkdir /root/minio-client && \
    cd /root/minio-client && \
    wget https://dl.min.io/client/mc/release/linux-amd64/mc

ENV TZ=Europe/Budapest

ADD loop.sh /tmp/loop.sh
RUN chmod +x /tmp/loop.sh
ENTRYPOINT ["/tmp/loop.sh"]
