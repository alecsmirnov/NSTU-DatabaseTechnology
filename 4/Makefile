CC     = /usr/bin/gcc
PGPATH = /usr/pgsql-9.3
ECPG   = ${PGPATH}/bin/ecpg
CFLAGS = -std=c99 -I${PGPATH}/include
LFLAGS = -L${PGPATH}/lib
LIBS   = -lecpg -lecpg_compat

#APPS = task1 task2 task3 task4 task5

all: task1 task2 task3 task4 task5 cleanTemp

#$(APPS): %: %.o databaseFunctions.o sqlFunctions.o
#	echo $@ $<
#	$(CC) $(CFLAGS) -o $@ $< databaseFunctions.o sqlFunctions.o ${LIBS} ${CFLAGS} ${LFLAGS} 
#$(APPS).o: %: %.ec databaseFunctions.h sqlFunctions.h
#	echo $<
#	${ECPG} -c $<
#	$(CC) $(CFLAGS) -c $@.c ${LIBS} ${CFLAGS} ${LFLAGS} 	

task1: task1.o databaseFunctions.o sqlFunctions.o
	$(CC) $(CFLAGS) -o task1 task1.o databaseFunctions.o sqlFunctions.o ${LIBS} ${CFLAGS} ${LFLAGS} 
task1.o: task1.ec databaseFunctions.h sqlFunctions.h
	${ECPG} -c task1.ec
	$(CC) $(CFLAGS) -c task1.c ${LIBS} ${CFLAGS} ${LFLAGS} 	

task2: task2.o databaseFunctions.o sqlFunctions.o
	$(CC) $(CFLAGS) -o task2 task2.o databaseFunctions.o sqlFunctions.o ${LIBS} ${CFLAGS} ${LFLAGS} 
task2.o: task2.ec databaseFunctions.h sqlFunctions.h
	${ECPG} -c task2.ec
	$(CC) $(CFLAGS) -c task2.c ${LIBS} ${CFLAGS} ${LFLAGS} 	

task3: task3.o databaseFunctions.o sqlFunctions.o
	$(CC) $(CFLAGS) -o task3 task3.o databaseFunctions.o sqlFunctions.o ${LIBS} ${CFLAGS} ${LFLAGS} 
task3.o: task3.ec databaseFunctions.h sqlFunctions.h
	${ECPG} -c task3.ec
	$(CC) $(CFLAGS) -c task3.c ${LIBS} ${CFLAGS} ${LFLAGS} 	

task4: task4.o databaseFunctions.o sqlFunctions.o
	$(CC) $(CFLAGS) -o task4 task4.o databaseFunctions.o sqlFunctions.o ${LIBS} ${CFLAGS} ${LFLAGS} 
task4.o: task4.ec databaseFunctions.h sqlFunctions.h
	${ECPG} -c task4.ec
	$(CC) $(CFLAGS) -c task4.c ${LIBS} ${CFLAGS} ${LFLAGS} 	

task5: task5.o databaseFunctions.o sqlFunctions.o
	$(CC) $(CFLAGS) -o task5 task5.o databaseFunctions.o sqlFunctions.o ${LIBS} ${CFLAGS} ${LFLAGS} 
task5.o: task5.ec databaseFunctions.h sqlFunctions.h
	${ECPG} -c task5.ec
	$(CC) $(CFLAGS) -c task5.c ${LIBS} ${CFLAGS} ${LFLAGS} 	

databaseFunctions.o: databaseFunctions.ec databaseFunctions.h
	${ECPG} -c databaseFunctions.ec
	$(CC) $(CFLAGS) -c databaseFunctions.c ${LIBS} ${CFLAGS} ${LFLAGS} 
sqlFunctions.o: sqlFunctions.ec sqlFunctions.h
	${ECPG} -c sqlFunctions.ec
	$(CC) $(CFLAGS) -c sqlFunctions.c ${LIBS} ${CFLAGS} ${LFLAGS} 

cleanTemp:
	rm -rf *.o *.c

clean:
	rm -rf task1 task2 task3 task4 task5