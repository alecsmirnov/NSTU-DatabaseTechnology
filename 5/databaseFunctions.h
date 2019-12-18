#ifndef DATABASEFUNCTIONS_H
#define DATABASEFUNCTIONS_H

#define SERVER "students@fpm2.ami.nstu.ru"

// Отлов ошибок и вывода информации на экран
void errorHandle(const char* error_name);

// Подключение к базе данных по указанному логину и паролю
void connectToDatabase(const char* login, const char* password);

// Подключение к указанной схеме бд
void connectToScheme(const char* scheme_name);

#endif