FROM gpiilab/universal
USER root
RUN npm install -g kanso
RUN apk add --no-cache jq curl
USER app
ENV COUCHDB_ADDRESS localhost:5984
WORKDIR /app/testData/preferences
RUN for fn in *.json; do id=`basename "$fn" .json`; echo $id; cat "$fn" | jq --arg id $id '{"_id": $id, "value": .}' > with_id_"$id".json; done
CMD curl -X DELETE http://${COUCHDB_ADDRESS}/preferences && for fn in with_id*.json; do kanso upload "$fn" http://${COUCHDB_ADDRESS}/preferences; done
