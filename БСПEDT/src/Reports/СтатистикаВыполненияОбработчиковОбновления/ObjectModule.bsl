///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	Макет = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, КомпоновщикНастроек.ПолучитьНастройки(), ДанныеРасшифровки);
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(Макет, Новый Структура("Таблица", ПротоколВыполненияОбновления()), ДанныеРасшифровки);
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	
	ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
КонецПроцедуры

Функция ПротоколВыполненияОбновления()
	
	Результат = Новый ТаблицаЗначений;
	Результат.Колонки.Добавить("НомерСтроки", Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(15, 0, ДопустимыйЗнак.Неотрицательный)));
	Результат.Колонки.Добавить("Библиотека", Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0, ДопустимаяДлина.Переменная)));
	Результат.Колонки.Добавить("Версия", Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0, ДопустимаяДлина.Переменная)));
	Результат.Колонки.Добавить("ВерсияРегистрации", Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0, ДопустимаяДлина.Переменная)));
	Результат.Колонки.Добавить("Процедура", Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0, ДопустимаяДлина.Переменная)));
	Результат.Колонки.Добавить("Длительность", Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(15, 3)));
	Результат.Колонки.Добавить("ОбластьДанныхИспользование", Новый ОписаниеТипов("Булево"));
	Результат.Колонки.Добавить("ОбластьДанныхЗначение", Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(7, 0)));
	
	ИмяФайлаСхемы = ПолучитьИмяВременногоФайла("xsd");
	ПолучитьМакет("СхемаЖурнала").Записать(ИмяФайлаСхемы);
	
	Фабрика = СоздатьФабрикуXDTO(ИмяФайлаСхемы);
	
	УдалитьФайлы(ИмяФайлаСхемы);
	
	ТипЗаписьЖР = Фабрика.Тип("http://v8.1c.ru/eventLog", "Event");
	
	ИмяФайлаДанных = ПолучитьИмяВременногоФайла("xml");
	
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(АдресДанных); // ДвоичныеДанные
	ДвоичныеДанные.Записать(ИмяФайлаДанных);
	
	Чтение = Новый ЧтениеXML;
	Чтение.ОткрытьФайл(ИмяФайлаДанных);
	Чтение.ПерейтиКСодержимому();
	Чтение.Прочитать();
	
	СтароеИмяСобытия = ОбновлениеИнформационнойБазыСлужебный.СобытиеЖурналаРегистрации() + ". " + НСтр("ru = 'Протокол выполнения'", ОбщегоНазначения.КодОсновногоЯзыка());
	ИмяСобытия = ОбновлениеИнформационнойБазыСлужебный.СобытиеЖурналаРегистрацииПротокол();
	
	НомерСтроки = 1;
	Пока Чтение.ТипУзла = ТипУзлаXML.НачалоЭлемента Цикл
		ЗаписьЖР = Фабрика.ПрочитатьXML(Чтение, ТипЗаписьЖР);
		
		Если ЗаписьЖР.Event <> ИмяСобытия
			И ЗаписьЖР.Event <> СтароеИмяСобытия Тогда
			Продолжить;
		КонецЕсли;
		
		ОписаниеОбработчика = ЗначениеИзСтрокиXML(ЗаписьЖР.Comment);
		
		СтрокаОбработчика = Результат.Добавить();
		СтрокаОбработчика.НомерСтроки = НомерСтроки;
		ЗаполнитьЗначенияСвойств(СтрокаОбработчика, ОписаниеОбработчика);
		
		НомерСтроки = НомерСтроки + 1;
	КонецЦикла;
	
	Чтение.Закрыть();
	УдалитьФайлы(ИмяФайлаДанных);
	
	Возврат Результат;
	
КонецФункции

// Возвращает значение, полученное из XML-строки. 
// Получены из XML-строки могут быть только те объекты, 
// для которых в описании указано, что они сериализуются.
//
// Параметры:
//   СтрокаXML - Произвольный - значение, которое необходимо сериализовать в XML-строку.
//
// Возвращаемое значение:
//   Строка - XML-строка.
//
Функция ЗначениеИзСтрокиXML(СтрокаXML) Экспорт
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.УстановитьСтроку(СтрокаXML);
	
	Возврат СериализаторXDTO.ПрочитатьXML(ЧтениеXML);
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли