FROM linuxserver/smokeping
RUN apt-get update && apt-get -y install tcptraceroute bc
ADD config.d/ /etc/smokeping/config.d/
ADD http://www.vdberg.org/~richard/tcpping /usr/local/bin/tcpping
RUN chmod +x /usr/local/bin/tcpping
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run
