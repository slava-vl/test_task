# mad_soft

Тестовое задание на позицию Flutter-разработчик


https://github.com/slava-vl/test_task/assets/61556435/272781f5-f7d7-4dc1-8209-3fb854dd964e



Задача:
Нужно реализовать функциональность экранов: список объектов и просмотр схемы одного объекта.

Функционал:

При открытии страницы с объектами данные загружаются из API, ссылка на которое представлена ниже. 

На экране списка объектов должны показываться:

Поле поиска по имени объекта

Карточка с объектом со следующим списком полей:

     Заголовок - title
     
     Кол-во точек, оставшихся для съемки -     remaining_points
     
     Общее кол-во точек - total_points_count
     
     Оценка, занимаемого съемкой места - высчитывать по формуле total_points_count * 5 (средний размер одной съемки)
     
     Доступный объем памяти на устройстве - рассчитывать  через файловую систему устройства

Bottom Nav Bar с тремя табами, которые ведут на одну и ту же страницу со списком объектов.

При вводе в поле поиска объекты должны фильтроваться по заголовку - title

При скролле вниз списка объекта должен быть плавный переход поиска в header  

При клике на карточку объекта должен открываться экран схемы объекта

На экране схемы объектов должна отображаться схема с точками на ней

Схема объекта моковая, представлена в дизайне, она должна отображаться в оригинальном размере

Должна быть возможность скроллить и зумить данную схему, при этом положение точек не должно меняться

Точки имеют координаты в пикселях x, y на указанной схеме

Для точек выводится разный маркер в зависимости от статуса: completed, uncompleted


Требования и примечания:

Логика экранов должна быть организована при помощи BLoC. При отсутствии опыта работы с BLoC можно использовать наиболее знакомый вам стейт менеджер

Верстка должна соответствовать дизайну, но некоторые моменты можно упустить


Список библиотек:

Bloc или другой знакомый стейт менеджер 

freezed

Dio
