1. Создаем и наполняем репозиторий файлами и коммитами:

![alt text](images/1.png)
![alt text](images/2.png)

Лог коммитов выглядит следующим образом:
![alt text](images/3.png)
![alt text](images/4.png)

2. Проверяем хэши коммитов командой `git reflog` и переходим на интересующий нас коммит `git checkout <хэш>`:

![alt text](images/5.png)
![alt text](images/6.png)

Возвращаемся обратно командой `git checkout main`:

![alt text](images/7.png)

3. Создаем новую ветку `develop`:

![alt text](images/8.png)

4. Изменяем предыдущий коммит с помощью атрибута `amend`:

![alt text](images/9.png)

5. Делаепм коммит в `main`, но не пушим изменения в удаленный репозиторий:

![alt text](images/10.png)

6. Переносим коммит в новую ветку с помощью `git reset --hard`:

![alt text](images/11.png)

![alt text](images/12.png)

7. Сделаем изменения и отменим их через `git checkout`:

![alt text](images/13.png)