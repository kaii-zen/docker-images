#!/usr/bin/env bash

set -e

wait_for_cache_container() {
  dockerize -wait tcp://172.17.0.1:80
}

cache_url() {
  local cache_name=$1
  echo "http://172.17.0.1/${cache_name}.tgz"
}

url_exists() {
  local url=$1
  curl --output /dev/null --silent --head --fail "$url"
}

cache_exists() {
  local cache_name=$1
  url_exists $(cache_url $cache_name)
}

get_cache() {
  local cache_name=$1
  curl --output - --silent $(cache_url $cache_name) | tar xzf -
}

# Treat all arguments but the last as caches (yep, hardocre bash voodoo)
caches=${@:1:$(($#-1))}

# Retrieve caches
if [[ -n "$caches" ]]; then
  # Wait for the cache server to start
  wait_for_cache_container

  for cache in $caches; do
    if cache_exists $cache; then
      get_cache $cache
    else
      echo $cache is not in the cache. Skipping...
    fi
  done
fi

# Now take the last argument, put it in a script,
# run it through docker-ssh-exec and delete it so
# that we leave no trace.
echo '#!/usr/bin/env bash' > /tmp/script.sh
echo ${@: -1} >> /tmp/script.sh
chmod +x /tmp/script.sh

docker-ssh-exec /tmp/script.sh

rm -f /tmp/script.sh
