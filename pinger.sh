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
	RESPONSE=$(curl -s -S -k "$URL" & wait)
	if [ -z "${RESPONSE}" ] || [ "${RESPONSE}" != "${PREVIOUS_RESPONSE}" ]; then
		echo "Response changed: ${RESPONSE} from ${PREVIOUS_RESPONSE}"
	fi

	# Sleep and loop
	PREVIOUS_RESPONSE="${RESPONSE}"
	sleep $INTERVAL & wait
done
