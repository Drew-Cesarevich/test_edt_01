///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	ТолькоПросмотр = Параметры.ТолькоПросмотр;
	Если ТолькоПросмотр Тогда
		Элементы.ФормаОтмена.Видимость             = Ложь;
		Элементы.ИсправленияОтметка.ТолькоПросмотр = Истина;
	КонецЕсли;
	
	Элементы.ГруппаПояснениеОтозвано.Видимость = Ложь;
	ОписаниеИсправлений = ПолучитьИзВременногоХранилища(Параметры.АдресОписаниеИсправлений);
	ДляНовойВерсии = Параметры.ДляНовойВерсии;
	ИмяКолонки = ?(ДляНовойВерсии, "ДляНовойВерсии", "ДляТекущейВерсии");
	Для Каждого ТекущееИсправление Из ОписаниеИсправлений Цикл
		
		Если Не ТекущееИсправление[ИмяКолонки] Тогда
			Продолжить;
		КонецЕсли;
		
		Если ТекущееИсправление.Отозвано Тогда
			Элементы.ГруппаПояснениеОтозвано.Видимость = Истина;
		КонецЕсли;
		
		СтрокаИсправление = Исправления.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаИсправление, ТекущееИсправление, "Описание, Отозвано, Идентификатор");
		
		СтрокаИсправление.Наименование = ?(
			СтрокаИсправление.Отозвано,
			ТекущееИсправление.Наименование + " " + НСтр("ru = '(Исправление отозвано)'"),
			ТекущееИсправление.Наименование);
		
		СтрокаИсправление.Отметка = (СтрокаИсправление.Отозвано
			Или Параметры.ВыбранныеИсправления.НайтиПоЗначению(СтрокаИсправление.Идентификатор) <> Неопределено);
		
		СтрокаИсправление.ОписаниеОтображаемое = ТекстСвернутогоОписания(
			СтрокаИсправление.Описание,
			СтрокаИсправление.ВозможноРазвертывание);
		
		Если СтрокаИсправление.ВозможноРазвертывание Тогда
			// Изначально описание свернуто.
			СтрокаИсправление.ЗаголовокСсылкиДействия = НСтр("ru = 'Подробнее'");
		КонецЕсли;
		
	КонецЦикла;
	
	ОбновитьНадписьВсегоВыбраноИсправлений(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыИсправления

&НаКлиенте
Процедура ИсправленияВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя = "ИсправленияЗаголовокСсылкиДействия" Тогда
		ТекущиеДанные = Элементы.Исправления.ТекущиеДанные;
		Если ТекущиеДанные.Развернута Тогда
			ТекущиеДанные.ОписаниеОтображаемое = ТекстСвернутогоОписания(ТекущиеДанные.Описание);
			ТекущиеДанные.Развернута = Ложь;
			ТекущиеДанные.ЗаголовокСсылкиДействия = НСтр("ru = 'Подробнее'");
		Иначе
			ТекущиеДанные.ОписаниеОтображаемое = ТекущиеДанные.Описание;
			ТекущиеДанные.Развернута = Истина;
			ТекущиеДанные.ЗаголовокСсылкиДействия = НСтр("ru = 'Свернуть'");
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИсправленияОтметкаПриИзменении(Элемент)
	
	ОбновитьНадписьВсегоВыбраноИсправлений(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОтметитьВсе(Команда)
	
	Для Каждого СтрокаИсправления Из Исправления Цикл
		СтрокаИсправления.Отметка = Истина;
	КонецЦикла;
	
	ОбновитьНадписьВсегоВыбраноИсправлений(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьОтметкуСоВсех(Команда)
	
	СнятьОтметку();
	ОбновитьНадписьВсегоВыбраноИсправлений(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОК(Команда)
	
	Если ТолькоПросмотр Тогда
		
		Закрыть();
		
	Иначе
		
		Результат = Новый СписокЗначений;
		Для Каждого СтрокаИсправления Из Исправления Цикл
			Если СтрокаИсправления.Отметка Тогда
				Результат.Добавить(СтрокаИсправления.Идентификатор);
			КонецЕсли;
		КонецЦикла;
		
		Если Результат.Количество() = 0 Тогда
			ПоказатьПредупреждение(, НСтр("ru = 'Выберите исправления для установки.'"));
			Возврат;
		КонецЕсли;
		
		Закрыть(Результат);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подобрать(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"ПодобратьЗавершение",
		ЭтотОбъект);
	
	ПоказатьВводСтроки(
		ОписаниеОповещения,
		"",
		НСтр("ru = 'Введите список наименований исправлений (патчей).'"),
		,
		Истина);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Функция ТекстСвернутогоОписания(Описание, ВозможноРазвертывание = Ложь)
	
	ВозможноРазвертывание = Истина;
	ПозицияСимволПС = СтрНайти(Описание, Символы.ПС);
	Если ПозицияСимволПС = 0 Тогда
		Если СтрДлина(Описание) > 100 Тогда
			Возврат Лев(Описание, 100) + "...";
		Иначе
			ВозможноРазвертывание = Ложь;
			Возврат Описание;
		КонецЕсли;
	ИначеЕсли ПозицияСимволПС > 100 Тогда
		Возврат Лев(Описание, 100) + "...";
	Иначе
		Возврат Лев(Описание, ПозицияСимволПС - 1) + "...";
	КонецЕсли;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьНадписьВсегоВыбраноИсправлений(Форма)
	
	ВыбраноКоличество = 0;
	Для Каждого СтрокаИсправление Из Форма.Исправления Цикл
		Если СтрокаИсправление.Отметка Тогда
			ВыбраноКоличество = ВыбраноКоличество + 1;
		КонецЕсли;
	КонецЦикла;
	
	Форма.ТекстВыбраноИсправлений = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Всего выбрано исправлений %1 из %2'"),
		ВыбраноКоличество,
		Форма.Исправления.Количество());
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьОтметку()
	
	Для Каждого СтрокаИсправления Из Исправления Цикл
		Если Не СтрокаИсправления.Отозвано Тогда
			СтрокаИсправления.Отметка = Ложь;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ИсправленияОтметка.Имя);
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ИсправленияНаименование.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Исправления.Отозвано");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ТолькоПросмотр", Истина);
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста",     ЦветаСтиля.ПоясняющийОшибкуТекст);
	
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ИсправленияЗаголовокСсылкиДействия.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Исправления.ВозможноРазвертывание");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("Видимость", Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ПодобратьЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	СнятьОтметку();
	Если Не ЗначениеЗаполнено(Результат) Тогда
		Возврат;
	КонецЕсли;
	
	СоставСтроки = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивСлов(Результат);
	
	Для Каждого Значение Из СоставСтроки Цикл
		Для Каждого СтрокаИсправления Из Исправления Цикл
			Если СтрокаИсправления.Наименование = Значение Тогда
				СтрокаИсправления.Отметка = Истина;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	ОбновитьНадписьВсегоВыбраноИсправлений(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти
