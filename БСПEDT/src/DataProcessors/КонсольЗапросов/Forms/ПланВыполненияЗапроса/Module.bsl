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
	
	Если НЕ Параметры.Свойство("АдресХранилищаПланаЗапроса", АдресХранилищаПланаЗапроса) Тогда
		Возврат;
	КонецЕсли;
	
	МеткаЗапроса = Параметры.МеткаЗапроса;
	
	Если НЕ ЗначениеЗаполнено(МеткаЗапроса) Тогда
		Если НЕ Параметры.АнализЗапросаПроведен Тогда
			Отказ = Истина;
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	ЭтотОбъект.Заголовок = НСтр("ru = 'План выполнения запроса ('") + Параметры.ИмяЗапроса + ")";
	
	ПолноеИмяФайлаЖурнала = ФайлТехнологическийЖурнал(Параметры.ИдентификаторПроцессаОС, Параметры.КаталогСЛогФайлами);
	Если НЕ ДанныеИзТехнологическогоЖурналаПрочитаны(ПолноеИмяФайлаЖурнала) Тогда
		Элементы.ГруппаПланВыполненияЗапроса.ТекущаяСтраница = Элементы.ГруппаПолучениеПланаВыполненияЗапроса;
		ТребуетсяПрочитатьЖурналИмя = ПолноеИмяФайлаЖурнала;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТипПоказаЗапросаПриИзменении(Элемент)
	
	Если ВидОтображенияДанных = 0 Тогда
		Если ТипСУБД = "DBMSSQL" Тогда
			Элементы.ДеревоОператорМетаданные.Видимость=Истина;
			Элементы.ДеревоОператор.Видимость=Ложь;
		Иначе
			ПланВыполненияЗапросаТекст = ПланВыполненияЗапросаВМетаданных;
		КонецЕсли;	
		СформированныйSQLТекстЗапроса = ТекстЗапросаВВидеМетаданных;
	Иначе 
		Если ТипСУБД = "DBMSSQL" Тогда 
			Элементы.ДеревоОператорМетаданные.Видимость=Ложь;
			Элементы.ДеревоОператор.Видимость=Истина;
		Иначе
			ПланВыполненияЗапросаТекст = ПланВыполненияЗапросаИзТехЖурнала;
		КонецЕсли;
		
		СформированныйSQLТекстЗапроса = ТекстЗапросаВSQL;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыПланВыполненияЗапросаSQLServer

&НаКлиенте
Процедура ДеревоПриАктивизацииСтроки(Элемент)
	
	Если ТипСУБД = "DBMSSQL" Тогда
		Если ВидОтображенияДанных = 0 Тогда
			ОписаниеОператора = Элемент.ТекущиеДанные.ОператорМетаданные;
		Иначе
			ОписаниеОператора = Элемент.ТекущиеДанные.Оператор;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ОбъектОбработки()
	
	Возврат РеквизитФормыВЗначение("Объект");
	
КонецФункции

&НаСервере
Функция ФайлТехнологическийЖурнал(ИдентификаторПроцессаОС, КаталогСЛогФайлами)
	
	ТекущаяДата = ТекущаяДата(); // АПК:143 имена лог-файлов технологического журнала формируются по дате сервера.
	ОжидаемоеИмяФайла = ИмяФайлТехнологическийЖурнал(ТекущаяДата);
	
	ПолноеИмяФайлаЖурнала = НайтиФайлТехнологическийЖурнал(ОжидаемоеИмяФайла, ИдентификаторПроцессаОС, КаталогСЛогФайлами); 
	Если ЗначениеЗаполнено(ПолноеИмяФайлаЖурнала) Тогда
		Возврат ПолноеИмяФайлаЖурнала;
	Иначе
		ОжидаемоеИмяФайла = ИмяФайлТехнологическийЖурнал(ТекущаяДата - 3600);
		ПолноеИмяФайлаЖурнала =  НайтиФайлТехнологическийЖурнал(ОжидаемоеИмяФайла, ИдентификаторПроцессаОС, КаталогСЛогФайлами);
		Если ЗначениеЗаполнено(ПолноеИмяФайлаЖурнала) Тогда
			Возврат ПолноеИмяФайлаЖурнала;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

&НаСервере
Функция ИмяФайлТехнологическийЖурнал(ДатаФайла)
	
	ОжидаемоеИмяФайла = Формат(ДатаФайла, "ДФ=yyMMddHH")+ ".log";
	Возврат ОжидаемоеИмяФайла;
	
КонецФункции

&НаСервере
Функция НайтиФайлТехнологическийЖурнал(ИмяФайла, ИдентификаторПроцессаОС, КаталогСЛогФайлами)

	СписокФайлов = НайтиФайлы(КаталогСЛогФайлами, "*.log", Истина);
	Для каждого Файл Из СписокФайлов Цикл
		Если СтрНайти(Файл.Путь, "_" + ИдентификаторПроцессаОС) > 0 Тогда
			Если Файл.Имя = ИмяФайла Тогда
				Возврат Файл.ПолноеИмя;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

&НаСервере
Функция ДанныеИзТехнологическогоЖурналаПрочитаны(ПолноеИмяФайлаЖурнала)
	
	Если ЗначениеЗаполнено(АдресХранилищаПланаЗапроса) Тогда
		
		СтруктураПланаЗапроса = ПолучитьИзВременногоХранилища(АдресХранилищаПланаЗапроса);
		
		Если СтруктураПланаЗапроса <> Неопределено Тогда
			ТипСУБД = СтруктураПланаЗапроса.ТипСУБД;
			ТекстЗапросаВSQL = СтруктураПланаЗапроса.СКЛЗапрос;
			ПланВыполненияЗапросаИзТехЖурнала = СтруктураПланаЗапроса.ПланВыполненияЗапроса;
		Иначе
			ПрочитанныеДанные = Новый Структура("ТипСУБД, СКЛЗапрос, ПланВыполненияЗапроса");
			ОбъектОбработки().ПрочитатьТехнологическийЖурнал(ПолноеИмяФайлаЖурнала, МеткаЗапроса, ПрочитанныеДанные);
			
			ТипСУБД = ПрочитанныеДанные.ТипСУБД;
			ТекстЗапросаВSQL = ПрочитанныеДанные.СКЛЗапрос;
			ПланВыполненияЗапросаИзТехЖурнала = ПрочитанныеДанные.ПланВыполненияЗапроса;
			
			СтруктураПланаЗапроса = Новый Структура;
			СтруктураПланаЗапроса.Вставить("ТипСУБД", ТипСУБД);
			СтруктураПланаЗапроса.Вставить("СКЛЗапрос", ТекстЗапросаВSQL);
			СтруктураПланаЗапроса.Вставить("ПланВыполненияЗапроса", ПланВыполненияЗапросаИзТехЖурнала);
			СтруктураПланаЗапроса.Вставить("ПланЗапросаАктуален", Истина);
			
			АдресХранилищаПланаЗапроса = ПоместитьВоВременноеХранилище(СтруктураПланаЗапроса,АдресХранилищаПланаЗапроса);
		КонецЕсли;
	Иначе
		ПрочитанныеДанные = Новый Структура("ТипСУБД, СКЛЗапрос, ПланВыполненияЗапроса");
		ОбъектОбработки().ПрочитатьТехнологическийЖурнал(ПолноеИмяФайлаЖурнала, МеткаЗапроса, ПрочитанныеДанные);
		
		ТипСУБД = ПрочитанныеДанные.ТипСУБД;
		ТекстЗапросаВSQL = ПрочитанныеДанные.СКЛЗапрос;
		ПланВыполненияЗапросаИзТехЖурнала = ПрочитанныеДанные.ПланВыполненияЗапроса;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(ТипСУБД) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ВВидеМетаданных = ОбъектОбработки().ПреобразоватьВМетаданные(ТекстЗапросаВSQL, ПланВыполненияЗапросаИзТехЖурнала, ТипСУБД);
	
	ТекстЗапросаВВидеМетаданных = ВВидеМетаданных.ТекстЗапросаВВидеМетаданных;
	ПланВыполненияЗапросаВМетаданных = ВВидеМетаданных.ПланВыполненияЗапросаВМетаданных;
	
	СформированныйSQLТекстЗапроса = ВВидеМетаданных.ТекстЗапросаВВидеМетаданных;
	ПланВыполненияЗапросаТекст = ВВидеМетаданных.ПланВыполненияЗапросаВМетаданных;
	
	Если ТипСУБД = "DBMSSQL" Тогда
		СуммарнаяСтоимостьОбщая = 0;
		Элементы.ГруппаПланВыполненияЗапроса.ТекущаяСтраница = Элементы.ГруппаПланВыполненияЗапросаSQLСервер;
		ДеревоПланаЗапроса = РеквизитФормыВЗначение("ДеревоПланаВыполненияЗапроса"); // ДеревоЗначений
		ОбъектОбработки().ДеревоПланаВыполненияЗапроса(ПланВыполненияЗапросаИзТехЖурнала, ПланВыполненияЗапросаВМетаданных, ДеревоПланаЗапроса, СуммарнаяСтоимостьОбщая);
		ЗначениеВРеквизитФормы(ДеревоПланаЗапроса, "ДеревоПланаВыполненияЗапроса");
		СуммарнаяСтоимостьЗапроса = СуммарнаяСтоимостьОбщая;
		Элементы.ГруппаИнформацияОСтоимостиЗапроса.Видимость = Истина;
		Элементы.ПоказыватьПланВыполненияЗапросаВВиде.Видимость = Истина;
		Максимум = НайтиМаксимальныйПоказательСтоимости(ДеревоПланаЗапроса.Строки);
		УстановитьОформлениеДанныхВКолонкеСтоимость(Максимум);
	Иначе
		Элементы.ГруппаИнформацияОСтоимостиЗапроса.Видимость = Ложь;
		Элементы.ГруппаПланВыполненияЗапроса.ТекущаяСтраница = Элементы.ГруппаПланВыполненияЗапросаТекстовоеПредставление;
		Элементы.ПоказыватьПланВыполненияЗапросаВВиде.Видимость = Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

&НаСервере
Процедура УстановитьОформлениеДанныхВКолонкеСтоимость(Максимум)
	
	УсловноеОформление.Элементы.Очистить();
	ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
	
	ПолеОформления = ЭлементУсловногоОформления.Поля.Элементы.Добавить();
	ПолеОформления.Поле = Новый ПолеКомпоновкиДанных("ДеревоСтоимость");
	ПолеОформления.Использование = Истина;
	
	ЭлементОтбора = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоПланаВыполненияЗапроса.Стоимость"); 
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно; 
	ЭлементОтбора.ПравоеЗначение = Максимум; 
	ЭлементОтбора.Использование = Истина;
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("Шрифт", Новый Шрифт(, , Истина));
	
КонецПроцедуры

&НаСервере
Функция НайтиМаксимальныйПоказательСтоимости(СтрокиДерева, Максимум = 0)
	
	Для каждого Строка Из СтрокиДерева Цикл
		Если Строка.Строки.Количество() > 0 Тогда
			Максимум = НайтиМаксимальныйПоказательСтоимости(Строка.Строки, Максимум);
		КонецЕсли;
		Если Строка.Стоимость > Максимум Тогда
			Максимум = Строка.Стоимость;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Максимум;
	
КонецФункции

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ЗначениеЗаполнено(ТребуетсяПрочитатьЖурналИмя) Тогда
		ПодключитьОбработчикОжидания("ПрочитатьДанныеИзТехнологическогоЖурналаОбработчик", 2);
		Элементы.ГруппаПолучениеПланаВыполненияЗапроса.Видимость = Истина;
		КоличествоПопыток = 0;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПрочитатьДанныеИзТехнологическогоЖурналаОбработчик()
	
	Если ДанныеИзТехнологическогоЖурналаПрочитаны(ТребуетсяПрочитатьЖурналИмя) Тогда
		ОтключитьОбработчикОжидания("ПрочитатьДанныеИзТехнологическогоЖурналаОбработчик");
		ТребуетсяПрочитатьЖурналИмя = Неопределено;
		Элементы.ГруппаПолучениеПланаВыполненияЗапроса.Видимость = Ложь;
	Иначе
		Если КоличествоПопыток < 5 Тогда
			КоличествоПопыток = КоличествоПопыток + 1;
		Иначе
			ОтключитьОбработчикОжидания("ПрочитатьДанныеИзТехнологическогоЖурналаОбработчик");
			ТребуетсяПрочитатьЖурналИмя = Неопределено;
			Элементы.ГруппаПолучениеПланаВыполненияЗапроса.Видимость = Ложь;
			ПараметрыОповещения = Новый Структура;
			ПараметрыОповещения.Вставить("МеткаЗапроса", МеткаЗапроса);
			Оповестить("ОшибкаПолученияПланаВыполненияЗапроса", ПараметрыОповещения, ЭтотОбъект);
			ПоказатьПредупреждение(, НСтр("ru = 'План выполнения запроса не был получен.'"));
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьПланВыполненияЗапросаВВидеПриИзменении(Элемент)
	
	Если ПоказыватьПланВыполненияЗапросаВВиде = 0 Тогда
		Элементы.ГруппаПланВыполненияЗапроса.ТекущаяСтраница = Элементы.ГруппаПланВыполненияЗапросаSQLСервер;
	Иначе
		Элементы.ГруппаПланВыполненияЗапроса.ТекущаяСтраница = Элементы.ГруппаПланВыполненияЗапросаТекстовоеПредставление;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти


