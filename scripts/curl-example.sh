#!/usr/bin/env bash
printf "\n\n######## test ########\n"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
base_url="${BASE_URL:-http://0.0.0.0:8080}"
audio="${AUDIO:-$DIR/hello-world.mp3}"
echo $base_url
echo $audio
url=${base_url}/v1/models/model:predict
echo ${url}

(echo -n '{"instances": [{"audio": {"type": "mp3", "b64":"'; base64 -w 0 "${audio}"; echo '"}}]}') | curl -k -X POST -H "Content-Type: application/json" -d @- $url


