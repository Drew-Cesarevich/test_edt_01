///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОтборОтправлено = "Все";
	ТипПолучателейРассылки = Параметры.ТипПолучателейРассылки;
	НаименованиеРассылки = Параметры.НаименованиеРассылки;
	ИдентификаторОбъектаМетаданных = Параметры.ИдентификаторОбъектаМетаданных;
	
	// АПК:1223-выкл Это пример текста SMS.
	Элементы.ДекорацияПодсказка.Подсказка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Пример SMS: Ваш пароль: ******* для получения рассылки ""%1"".'"), НаименованиеРассылки);
	// АПК:1223-вкл
	
	Если НЕ ЭтоАдресВременногоХранилища(Параметры.АдресПолучателей) Тогда
		Возврат;
	КонецЕсли;
	
  	Получатели.Загрузить(ПолучитьИзВременногоХранилища(Параметры.АдресПолучателей));

	УдалитьИзВременногоХранилища(Параметры.АдресПолучателей); 

	УстановитьВидТелефонаПолучателей();
	ЗаполнитьТелефоны();    
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиФормы.Верх;
		Элементы.Переместить(Элементы.Отправить, КоманднаяПанель); 
		Элементы.ПолучательНаименованиеИТелефон.Группировка = ГруппировкаКолонок.Вертикальная; 
		Элементы.Закрыть.Видимость = Ложь; 
		Элементы.Переместить(Элементы.Закрыть, КоманднаяПанель);
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВидТелефонаПолучателейПриИзменении(Элемент)
	ЗаполнитьТелефоны();
КонецПроцедуры

&НаКлиенте
Процедура ОтборОтправленоПриИзменении(Элемент)
	УстановитьОтборыВРезультатеРассылкиSMS();
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыПолучатели

&НаКлиенте
Процедура ПолучателиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)

	Получатель = Элементы.Получатели.ТекущиеДанные.Получатель;

	Если ЗначениеЗаполнено(Получатель) Тогда
		ПоказатьЗначение( , Получатель);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПолучателиПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, ЭтоГруппа, Параметр)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПолучателиПередУдалением(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыРезультатРассылкиSMS

&НаКлиенте
Процедура РезультатРассылкиSMSВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Получатель = Элементы.РезультатРассылкиSMS.ТекущиеДанные.Получатель;

	Если ЗначениеЗаполнено(Получатель) Тогда
		ПоказатьЗначение( , Получатель);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Отправить(Команда)
	Элементы.Отправить.Видимость = Ложь;
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаСостояниеВыполнения;
	
	РезультатРассылкиSMS.Очистить();
	ПодготовленныеSMS = Новый Массив;
	КоличествоНеОтправлено = 0;
	Для Каждого СтрокаПолучатели Из Получатели Цикл
		
		Если Не ЗначениеЗаполнено(СтрокаПолучатели.ПарольАрхива) Или Не ЗначениеЗаполнено(СтрокаПолучатели.Телефон) Тогда

			СтрокаРезультат = РезультатРассылкиSMS.Добавить();
			СтрокаРезультат.Получатель = СтрокаПолучатели.Получатель;
			СтрокаРезультат.НеОтправлено = Истина;

			Если Не ЗначениеЗаполнено(СтрокаПолучатели.ПарольАрхива) Тогда
				СтрокаРезультат.Комментарий = НСтр("ru = 'Не установлен пароль.'");
			КонецЕсли;

			Если Не ЗначениеЗаполнено(СтрокаПолучатели.Телефон) Тогда
				СтрокаРезультат.Комментарий = ?(ЗначениеЗаполнено(СтрокаРезультат.Комментарий),
					СтрокаРезультат.Комментарий + Символы.ПС + НСтр("ru = 'Не указан номер телефона.'"), 
					НСтр("ru = 'Не указан номер телефона.'"));
			КонецЕсли;

			СтрокаРезультатБезОтборов = РезультатРассылкиSMSБезОтборов.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаРезультатБезОтборов, СтрокаРезультат);
			КоличествоНеОтправлено = КоличествоНеОтправлено + 1;
			Продолжить;
		КонецЕсли;
		
		ПодготовкаSMS = Новый Структура("Получатель, ТекстSMS, НомераТелефонов");
		ПодготовкаSMS.Получатель = СтрокаПолучатели.Получатель;
		// АПК:1223-выкл Это текст SMS.
		ПодготовкаSMS.ТекстSMS = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Ваш пароль: %1 для получения рассылки ""%2"".'"), СтрокаПолучатели.ПарольАрхива,
		НаименованиеРассылки);
		// АПК:1223-вкл
		ПодготовкаSMS.НомераТелефонов = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(СтрокаПолучатели.Телефон);
		ПодготовленныеSMS.Добавить(ПодготовкаSMS);
		
	КонецЦикла;
	
	ПараметрыЗапуска = Новый Структура("ПодготовленныеSMS, КоличествоНеОтправлено, Форма");
	ПараметрыЗапуска.ПодготовленныеSMS = ПодготовленныеSMS;
	ПараметрыЗапуска.Форма = ЭтотОбъект;
	ПараметрыЗапуска.КоличествоНеОтправлено = КоличествоНеОтправлено;
	
	РассылкаОтчетовКлиент.ВыполнитьРассылкуSMS(ПараметрыЗапуска);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьОтборыВРезультатеРассылкиSMS()
	
	ТаблицаРезультатРассылкиSMSБезОтборов = РеквизитФормыВЗначение("РезультатРассылкиSMSБезОтборов");

	Построитель = Новый ПостроительЗапроса;
	Построитель.ИсточникДанных = Новый ОписаниеИсточникаДанных(ТаблицаРезультатРассылкиSMSБезОтборов);

	Отбор = Построитель.Отбор;

	Отправлено = Отбор.Добавить("НеОтправлено");
	Отправлено.ВидСравнения	= ВидСравнения.Равно;
	Отправлено.Значение		= ?(ОтборОтправлено = "Отправленные", Ложь, Истина);
	Отправлено.Использование	= ?(ОтборОтправлено = "Все", Ложь, Истина);

	Построитель.Выполнить();
	ТаблицаРезультат = 	Построитель.Результат.Выгрузить();

	ЗначениеВРеквизитФормы(ТаблицаРезультат, "РезультатРассылкиSMS");
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТелефоны()
	
	ПолучателиТаблица = РеквизитФормыВЗначение("Получатели");
	МассивПолучателей = ПолучателиТаблица.ВыгрузитьКолонку("Получатель");
	
	ПолучателиСТелефонами = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъектов(МассивПолучателей,
		Перечисления.ТипыКонтактнойИнформации.Телефон, ВидТелефонаПолучателей);
	
	Если ПолучателиСТелефонами.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Для каждого ПолучательРассылки Из Получатели Цикл
		ПараметрыОтбора = Новый Структура("Объект", ПолучательРассылки.Получатель);
		НайденныеСтрокиСТелефонами = ПолучателиСТелефонами.НайтиСтроки(ПараметрыОтбора);
		Если НайденныеСтрокиСТелефонами.Количество() > 0 Тогда
			ПолучательРассылки.Телефон = НайденныеСтрокиСТелефонами[0].Представление;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидТелефонаПолучателей()
	
	ПолучателиМетаданные = ОбщегоНазначения.ОбъектМетаданныхПоИдентификатору(ИдентификаторОбъектаМетаданных, Ложь);
	ИмяГруппыКИ = СтрЗаменить(ПолучателиМетаданные.ПолноеИмя(), ".", "");
	ГруппаКИ = УправлениеКонтактнойИнформацией.ВидКонтактнойИнформацииПоИмени(ИмяГруппыКИ);
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1 Ссылка ИЗ Справочник.ВидыКонтактнойИнформации ГДЕ Родитель = &Родитель И Тип = &Тип";
	Запрос.УстановитьПараметр("Родитель", ГруппаКИ);
	Запрос.Параметры.Вставить("Тип", Перечисления.ТипыКонтактнойИнформации.Телефон);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ВидТелефонаПолучателей = Выборка.Ссылка;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
