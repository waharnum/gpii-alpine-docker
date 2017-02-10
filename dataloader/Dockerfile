FROM gpiilab/universal
USER root
RUN npm install -g kanso
RUN apk add --no-cache jq curl
USER app
WORKDIR /app/testData/preferences
RUN for fn in *.json; do id=`basename "$fn" .json`; echo $id; cat "$fn" | jq --arg id $id '{"_id": $id, "value": .}' > with_id_"$id".json; done
CMD for fn in with_id*.json; do kanso upload "$fn" http://couchdb:5984/preferences; done
