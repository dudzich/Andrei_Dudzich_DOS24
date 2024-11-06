
1. **Какие три утверждения о сетях являются правильными? (Выберите три.)**
```
A. Сети используются для передачи данных в разном окружении,
включающем дома, небольшие офисы и большие заводы.
B. В головном офисе может быть сотни или даже тысячи людей, кто
зависит от доступа к сети для выполнения их работы.
C. Сеть является совокупностью соединенных устройств, которые связаны
друг с другом.
D. Головной офис обычно имеет одну большую сеть для соединения всех
пользователей.
E. Целью создания сети является возможность предоставления всем
работникам доступа ко всей информации и компонентам, которые
доступны через сеть.
F. Удаленные местоположения не могут присоединиться к главному офису
через сеть.
```

_Ответ:_ ***A, B, C***

    A: Верно, сети используются в различных средах, от домашних сетей до крупных корпоративных.
    B: Верно, многие люди зависят от сети для работы.
    C: Верно, сеть — это набор соединенных между собой устройств.
    D: Не верно, в больших офисах могут быть несколько сетей, не обязательно одна.
    E: Не верно, цель сети — предоставить доступ к нужным ресурсам, а не ко всем.
    F: Не верно, удаленные местоположения могут подключаться через сеть.



2. **Эталонная модель OSI является многоуровневой. Какое из положений
неправильно характеризует причину многоуровневости модели?**
```
A. Многоуровневая модель увеличивает сложность.
B. Многоуровневая модель стандартизирует интерфейсы.
C. Многоуровневая модель дает возможность разработчикам
сконцентрировать усилия на более специализированных направлениях.
D. Многоуровневая модель предотвращает влияние изменений в одной
области на другие области.
```
_Ответ:_ ***A***

    A: Неправильно. Многоуровневая модель упрощает разработку и понимание сетевых взаимодействий, а не увеличивает сложность.
    B, C, D: Правильные утверждения. Многоуровневость стандартизирует интерфейсы, позволяет сосредоточиться на отдельных аспектах и снижает влияние изменений.


3. **Какой уровень эталонной модели OSI решает вопросы уведомления о
неисправностях, учитывает топологию сети и управляет потоком данных?**

    A. Физический.
    B. Канальный.
    C. Транспортный.
    D. Сетевой.

_Ответ:_ ***B***

    Канальный уровень (Layer 2) отвечает за обнаружение ошибок и управление потоком данных в пределах физического канала.


4. **Какой уровень эталонной модели OSI устанавливает, обслуживает и
управляет сеансами взаимодействия прикладных программ?**
```
A. Транспортный.
B. Сеансовый.
C. Уровень представлений.
D. Уровень приложений.
```
_Ответ:_ ***B***

    Этот уровень управляет установлением, поддержанием и завершением сеансов (сессий) между приложениями.


5. **Что из приведенного ниже наилучшим образом описывает функцию уровня
представлений?**
```
A. Он обеспечивает форматирование кода и представление данных.
B. Он обрабатывает уведомления об ошибках, учитывает топологию сети и
управляет потоком данных.
C. Он предоставляет сетевые услуги пользовательским прикладным
программам.
D. Он обеспечивает электрические, механические, процедурные и
функциональные средства для активизации и поддержания канала связи
между системами.
```
_Ответ:_ ***A***

    Уровень представлений занимается форматированием данных и их преобразованием в подходящий для передачи формат.


6. **Какой уровень эталонной модели OSI обеспечивает сетевые услуги
пользовательским прикладным программам?**
```
A. Транспортный.
B. Сеансовый.
C. Уровень представлений.
D. Уровень приложений.
```
_Ответ:_ ***D***

    Этот уровень взаимодействует напрямую с приложениями, предоставляя им сетевые услуги.


7. **Какое описание пяти этапов преобразования данных в процессе
инкапсуляции при отправке почтового сообщения одним компьютером
другому является правильным?**
```
A. Данные, сегменты, пакеты, кадры, биты.
B. Биты, кадры, пакеты, сегменты, данные.
C. Пакеты, сегменты, данные, биты, кадры.
D. Сегменты, пакеты, кадры, биты, данные.
```
_Ответ:_ ***A***



8. **При отправке почтового сообщения с компьютера А на компьютер В
данные необходимо инкапсулировать. Какое из описаний первого этапа
инкапсуляции является правильным?**
```
A. Алфавитно-цифровые символы конвертируются в данные.
B. Сообщение сегментируется в легко транспортируемые блоки.
C. К сообщению добавляется сетевой заголовок (адреса источника и
получателя).
D. Сообщение преобразовывается в двоичный формат.
```
_Ответ:_ ***A***

    Первый этап инкапсуляции включает преобразование исходных данных в цифровую форму.


9. **При отправке почтового сообщения с компьютера А на компьютер В по
локальной сети данные необходимо инкапсулировать. Что происходит после
создания пакета?**
```
A. Пакет передается по среде.
B. Пакет помещается в кадр.
C. Пакет сегментируется на кадры.
D. Пакет преобразовывается в двоичный формат.
```
_Ответ:_ ***B***

    На канальном уровне данные инкапсулируются в кадр.


10. **При отправке почтового сообщения с компьютера А на компьютер В
данные необходимо инкапсулировать. Что происходит после преобразования
алфавитно-цифровых символов в данные?**
```
A. Данные преобразовываются в двоичный формат.
B. К данным добавляется сетевой заголовок.
C. Данные сегментируются на меньшие блоки.
D. Данные помещаются в кадр.
```
_Ответ:_ ***C***

    Данные разбиваются на сегменты для передачи на транспортном уровне.


11. **Что из приведенного ниже наилучшим образом описывает дейтаграмму?**
```
A. Посылаемое источнику сообщение с подтверждением получения
неповрежденных данных.
B. Двоичное представление информации о маршрутизации.
C. Пакет данных размером менее 100 байт.
D. Пакет сетевого уровня.
```
_Ответ:_ ***D***

    Дейтаграмма — это пакет данных сетевого уровня, который может быть отправлен по ненадежному протоколу, например, UDP.