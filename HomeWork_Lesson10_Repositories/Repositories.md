1. Создаем и наполняем репозиторий файлами и коммитами:

![alt text](image.png)
![alt text](image-1.png)

Лог коммитов выглядит следующим образом:
![alt text](image-4.png)
![alt text](image-3.png)

2. Проверяем хэши коммитов командой `git reflog` и переходим на интересующий нас коммит `git checkout <хэш>`:

![alt text](image-6.png)
![alt text](image-5.png)

Возвращаемся обратно командой `git checkout main`:

![alt text](image-7.png)

3. Создаем новую ветку `develop`:

![alt text](image-8.png)

4. Изменяем предыдущий коммит с помощью атрибута `amend`:

![alt text](image-9.png)

5. Делаепм коммит в `main`, но не пушим изменения в удаленный репозиторий:

![alt text](image-10.png)

6. Переносим коммит в новую ветку с помощью `git reset --hard`:

![alt text](image-11.png)

![alt text](image-12.png)

7. Сделаем изменения и отменим их через `git checkout`:

![alt text](image-13.png)