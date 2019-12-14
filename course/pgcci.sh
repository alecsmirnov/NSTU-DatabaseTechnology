#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Illegal number of parameters"
	exit 1
fi

CC=/usr/bin/gcc
PGPATH=/usr/pgsql-9.3
ECPG=${PGPATH}/bin/ecpg
CFLAGS="-std=c99 -I${PGPATH}/include"
LFLAGS="-L${PGPATH}/lib"
LIBS="-lecpg -lecpg_compat"

${ECPG} "${1}.ec"
${CC} "${1}.c" -o "${1}.exe" ${LIBS} ${CFLAGS} ${LFLAGS} "${@:2}"

rm "${1}.c"