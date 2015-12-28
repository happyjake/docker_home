FROM linuxserver/sonarr
RUN mkdir -p /data
# this is necessary because Sonarr expects paths to be
# the same between SABznbd and Sonarr, but they
# aren't because of differences in the Docker volume names
RUN ln -s /tv /data/TV
