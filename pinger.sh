#!/bin/sh
INTERVAL=${INTERVAL:-1800}

if [ -z "$URL" ]; then
	echo '$URL missing'
	exit 1
fi

echo "Started pinging URL: ${URL}"

RESPONSE=""
PREVIOUS_RESPONSE=""
while true; do
	PREVIOUS_RESPONSE=$RESPONSE
	RESPONSE=$(curl -s -k "$URL" & wait)
	
	if [ -z RESPONSE ] || [ RESPONSE != PREVIOUS_RESPONSE ]; then
		echo "Response changed: ${RESPONSE}"
	fi

	# Sleep and loop
	sleep $INTERVAL & wait
done
