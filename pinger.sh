#!/bin/sh
INTERVAL=${INTERVAL:-1800}

if [ -z "$URL" ]; then
	echo '$URL missing'
	exit 1
fi
CUR_TIME=$(date "+%Y.%m.%d-%H.%M.%S")
echo "Started pinging URL: ${URL} at ${CUR_TIME}"

RESPONSE=""
PREVIOUS_RESPONSE=""
while true; do
	RESPONSE=$(curl -s -S -k "$URL" & wait)
	if [ -z "${RESPONSE}" ] || [ "${RESPONSE}" != "${PREVIOUS_RESPONSE}" ]; then
		CUR_TIME=$(date "+%Y.%m.%d-%H.%M.%S")
		echo "Response changed: ${RESPONSE} from ${PREVIOUS_RESPONSE} at ${CUR_TIME}"
	fi

	# Sleep and loop
	PREVIOUS_RESPONSE="${RESPONSE}"
	sleep $INTERVAL & wait
done
