CC     = /usr/bin/gcc
PGPATH = /usr/pgsql-9.3
ECPG   = ${PGPATH}/bin/ecpg
CFLAGS = -std=c99 -I${PGPATH}/include
LFLAGS = -L${PGPATH}/lib
LIBS   = -lecpg -lecpg_compat

all: dataInitialization systemSimulation dataReplication cleanTemp

dataInitialization: dataInitialization.o databaseFunctions.o fileFunctions.o sqlFunctions.o
	$(CC) $(CFLAGS) -o dataInitialization dataInitialization.o databaseFunctions.o fileFunctions.o sqlFunctions.o ${LIBS} ${CFLAGS} ${LFLAGS} 
dataInitialization.o: dataInitialization.ec databaseFunctions.h sqlFunctions.h
	${ECPG} -c dataInitialization.ec
	$(CC) $(CFLAGS) -c dataInitialization.c ${LIBS} ${CFLAGS} ${LFLAGS} 

systemSimulation: systemSimulation.o databaseFunctions.o fileFunctions.o sqlFunctions.o
	$(CC) $(CFLAGS) -o systemSimulation systemSimulation.o databaseFunctions.o fileFunctions.o sqlFunctions.o ${LIBS} ${CFLAGS} ${LFLAGS} 
systemSimulation.o: systemSimulation.ec databaseFunctions.h sqlFunctions.h
	${ECPG} -c systemSimulation.ec
	$(CC) $(CFLAGS) -c systemSimulation.c ${LIBS} ${CFLAGS} ${LFLAGS} 	

dataReplication: dataReplication.o databaseFunctions.o fileFunctions.o sqlFunctions.o
	$(CC) $(CFLAGS) -o dataReplication dataReplication.o databaseFunctions.o fileFunctions.o sqlFunctions.o ${LIBS} ${CFLAGS} ${LFLAGS} 
dataReplication.o: dataReplication.ec databaseFunctions.h sqlFunctions.h
	${ECPG} -c dataReplication.ec
	$(CC) $(CFLAGS) -c dataReplication.c ${LIBS} ${CFLAGS} ${LFLAGS} 	

databaseFunctions.o: databaseFunctions.ec databaseFunctions.h fileFunctions.h
	${ECPG} -c databaseFunctions.ec
	$(CC) $(CFLAGS) -c databaseFunctions.c ${LIBS} ${CFLAGS} ${LFLAGS} 
fileFunctions.o: fileFunctions.ec fileFunctions.h
	${ECPG} -c fileFunctions.ec
	$(CC) $(CFLAGS) -c fileFunctions.c ${LIBS} ${CFLAGS} ${LFLAGS} 
sqlFunctions.o: sqlFunctions.ec sqlFunctions.h sqlPatterns.h
	${ECPG} -c sqlFunctions.ec
	$(CC) $(CFLAGS) -c sqlFunctions.c ${LIBS} ${CFLAGS} ${LFLAGS} 

cleanTemp:
	rm -rf *.o *.c

clean:
	rm -rf dataInitialization systemSimulation dataReplication