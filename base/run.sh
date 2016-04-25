#!/usr/bin/env bash

set -e

caches=${@:1:$(($#-1))}

if [[ -n "$caches" ]]; then
	dockerize -wait tcp://172.17.0.1:873
	for cache in $caches; do
	    rsync -a rsync://172.17.0.1/volume/$cache.tgz . && tar xzf $cache.tgz && rm $cache.tgz || true
	done
fi

echo '#!/usr/bin/env bash' > /tmp/script.sh
echo ${@: -1} >> /tmp/script.sh
chmod +x /tmp/script.sh

docker-ssh-exec /tmp/script.sh

rm -f /tmp/script.sh
