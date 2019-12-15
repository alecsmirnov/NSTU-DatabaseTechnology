#ifndef DATABASEFUNCTIONS_H
#define DATABASEFUNCTIONS_H

#include "fileFunctions.h"

#define SERVER "students@fpm2.ami.nstu.ru"
//EXEC SQL DEFINE SERVER "students@fpm2.ami.nstu.ru";

// Подключение к базе данных по указанному логину и паролю
void connectToDatabase(const char* login, const char* password);

// Подключение к указанной схеме бд
void connectToScheme(const char* scheme_name);

// Подключение к бд при помощи файла пользователя: логин, пароль, схема
void dbConnect(const char* user_filename);

#endif