# Управление пакетами. Дистрибьюция софта.

## Домашнее задание



## Полезная информация

### MAX PROCESS ID

```
cat /proc/sys/kernel/pid_max
echo 32768 > /proc/sys/kernel/pid_max
Max value 4194304
```

### PS

```
ps -A    #Все активные процессы  
ps -A -u username #Все активные процессы конекретного пользователя  
ps -eF #Полный формат вывода  
ps -U root -u root #Все процессы работающие от рута  
ps -fG group_name #Все процессы запущенные от группы  
ps -fp PID #процессы по PID (можно указать пачкой)  
ps -ft tty1 #Процесс запущенный в определенной интерфейсе  
ps -e --forest   #Показать древо процессов  
ps -fL -C httpd  #Вывести все треды конкретного процесса  
ps -eo pid,ppid,user,cmd  #Форматируем вывод  
ps -p 1154 -o pid,ppid,fgroup,ni,lstart,etime  #Форматируем вывод и выводим по PID  
ps -C httpd  #Показываем родителя и дочернии процессы   
```

### PSTREE

```
pstree -a # Вывод с учетом аргументов командной строки  
pstree -c # Разворачиваем дерево еще сильнее
pstree -g # Вывод GID
pstree -n # Сортировка по PID
pstree username # pstree для определенного пользователя
pstree -s PID # pstree для пида, видим только его дерево
```

### LSOF

```
lsof -u username # Все открытые файлы для конкретного пользователя
lsof -i 4 # Все соединение для протокола ipv4
lsof -i TCP:port # Сортировка по протоколу и порту
lsof -p [PID] # Открытые файлы процесса по пиду
lsof -t [file-name] # каким процессом открыт файл
lsof -t /usr/lib/libcom_err.so.2.1   ^^^
lsof +D  /usr/lib/locale  # Посмотреть кто занимает директорию
lsof -i  # Все интернет соединения
lsof -i udp/tcp # Открытые файлы определенного протокола
```

### STRACE

```
strace program_name # Запуск программы с трасировкой
strace program_name -h # Трассировка системных вызовов
strace -p PID # Трассировка процесса по пиду
strace -c -p PID # Суммарная информация по процессу, нужно по наблюдать
strace -i who -h  # Отображение указателя команд во время каждого системного вызова
strace -t who -h  # Вывод времени когда было обращение
strace -T df -h # Вывод времени которое было затрачено на вызовы
strace -e trace=who df -h # Трассировка только определенных системных вызовов
strace -o debug.log who # Вывод всей информации в файл
strace -d who -h # Вывод информации о дебаге самого strace
```

### LTRACE

```
Пингануть яндекс, спрятать в фон и цепляться к нему или к апачу
ltrace -p <PID> # Дебаг уже запущенного процесса
ltrace -p <PID> -f # Дебаг включая дочернии процессы

```

### Kill all zombies

```
(sleep 1 & exec /bin/sleep 5000) &
# Запускаем основной и дочерний процесс, так как основной занят, он не может закрыть дочерний, начинаем использовать gdb
ps -C sleep # смотри кто у нас зомби
gdb
attach PID # Цепляемся к основнуму процессу
call waitpid(PID_zombie,0,0) #Посылаем основному процессу вызов wait
detach
quit
```