///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.Печать

// Заполняет список команд печати.
//
// Параметры:
//  КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Идентификатор = "ПечатьКарточкиОрганизации";
	КомандаПечати.Представление = НСтр("ru = 'Карточка организации'");
	КомандаПечати.Обработчик = "ПечатьКарточкиОрганизации";
КонецПроцедуры

// Конец СтандартныеПодсистемы.Печать

// СтандартныеПодсистемы.ПодключаемыеКоманды

// Параметры:
//  НастройкиПрограммногоИнтерфейса - Структура:
//   * ДобавитьКомандыПечати - Булево
//   * Размещение - Массив
//
Процедура ПриОпределенииНастроек(НастройкиПрограммногоИнтерфейса) Экспорт
	НастройкиПрограммногоИнтерфейса.ДобавитьКомандыПечати = Истина;
	НастройкиПрограммногоИнтерфейса.Размещение.Добавить(Метаданные.Справочники._ДемоОрганизации);
КонецПроцедуры

// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Формирует печатную форму карточки организации.
Функция СформироватьКарточкуОрганизации(СписокОрганизаций, ОбластиОбъектов) Экспорт
	
	СведенияОбОрганизациях = СведенияОбОрганизациях(СписокОрганизаций);
	ТабличныйДокумент = Новый ТабличныйДокумент;
	Макет = УправлениеПечатью.МакетПечатнойФормы("Обработка._ДемоПечатьКарточкиОрганизации.ПФ_MXL_КарточкаОрганизации");
	Для Каждого Организация Из СведенияОбОрганизациях Цикл
		НомерСтрокиНачало = ТабличныйДокумент.ВысотаТаблицы + 1;
		
		МассивОбластейМакета = Новый Массив;
		МассивОбластейМакета.Добавить("ОсновныеСведения");
		Если Организация.КонтактнаяИнформация.Количество() > 0 Тогда
			МассивОбластейМакета.Добавить("КонтактнаяИнформацияЗаголовок");
			МассивОбластейМакета.Добавить("КонтактнаяИнформацияСтрока");
		КонецЕсли;
		Если Организация.ОтветственныеЛица.Количество() > 0 Тогда
			МассивОбластейМакета.Добавить("ОтветственныеЛицаЗаголовок");
			МассивОбластейМакета.Добавить("ОтветственныеЛицаСтрока");
		КонецЕсли;
		
		Для Каждого ИмяОбласти Из МассивОбластейМакета Цикл
			ОбластьМакета = Макет.ПолучитьОбласть(ИмяОбласти);
			Если СтрЗаканчиваетсяНа(ИмяОбласти, "Строка") Тогда
				ИсточникСведений = Новый Массив;
				Если СтрНайти(ИмяОбласти, "ОтветственныеЛица") = 1 Тогда
					ИсточникСведений = Организация.ОтветственныеЛица;
				ИначеЕсли СтрНайти(ИмяОбласти, "КонтактнаяИнформация") = 1 Тогда
					ИсточникСведений = Организация.КонтактнаяИнформация;
				КонецЕсли;
				
				Для Каждого Сведения Из ИсточникСведений Цикл
					ОбластьМакета.Параметры.Заполнить(Сведения);
					ТабличныйДокумент.Вывести(ОбластьМакета);
				КонецЦикла;
			Иначе
				ЗаполнитьЗначенияСвойств(ОбластьМакета.Параметры, Организация.ОсновныеСведения);
				ТабличныйДокумент.Вывести(ОбластьМакета);
			КонецЕсли;
		КонецЦикла;
	
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабличныйДокумент, НомерСтрокиНачало, ОбластиОбъектов, Организация.Ссылка);
		
	КонецЦикла;
	
	Возврат ТабличныйДокумент;
	
КонецФункции

// Получает сведения об организациях.
//
// Параметры:
//  СписокОрганизаций - Массив
// Возвращаемое значение:
//  Массив из Структура: 
//   * Ссылка - СправочникСсылка._ДемоОрганизации
//   * ОсновныеСведения - см. ОрганизацииСервер.СведенияОбОрганизации
//   * КонтактнаяИнформация - ТаблицаЗначений
//   * ОтветственныеЛица - ТаблицаЗначений
//
Функция СведенияОбОрганизациях(СписокОрганизаций)
	
	Результат = Новый Массив;
	СвойстваОрганизации = "Наименование,Код,СведенияОРуководителеФИО";
	
	КонтактнаяИнформация = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъектов(СписокОрганизаций, , , ТекущаяДатаСеанса());
	
	КонтактнаяИнформация.Колонки.Вид.Имя           = "ВидКонтактнойИнформации";
	КонтактнаяИнформация.Колонки.Представление.Имя = "ПредставлениеКонтактнойИнформации";
	
	Для Каждого Организация Из СписокОрганизаций Цикл
		
		Дата = ТекущаяДатаСеанса();
		ОсновныеСведения = Новый Структура;
		// Локализация
		ОсновныеСведения = ОрганизацииСервер.СведенияОбОрганизации(Организация, СвойстваОрганизации, Дата);
		// Конец Локализация
		ОсновныеСведения.Вставить("ДатаФормирования", Дата);
		
		ОписаниеОрганизации = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Организация, "Код, Представление");
		
		КонтактнаяИнформацияПоОрганизации = КонтактнаяИнформация.НайтиСтроки(Новый Структура("Объект", Организация));
		
		ОтветственныеЛица = Новый ТаблицаЗначений;
		ОтветственныеЛица.Колонки.Добавить("ФИО");
		Если ОсновныеСведения.Свойство("СведенияОРуководителеФИО") Тогда
			НС = ОтветственныеЛица.Добавить();
			НС.ФИО = ОсновныеСведения.СведенияОРуководителеФИО;
		КонецЕсли;
		
		ОписаниеОрганизации = Новый Структура;
		ОписаниеОрганизации.Вставить("Ссылка",               Организация);
		ОписаниеОрганизации.Вставить("ОсновныеСведения",     ОсновныеСведения);
		ОписаниеОрганизации.Вставить("КонтактнаяИнформация", КонтактнаяИнформация.Скопировать(КонтактнаяИнформацияПоОрганизации));
		ОписаниеОрганизации.Вставить("ОтветственныеЛица",    ОтветственныеЛица);
		
		Результат.Добавить(ОписаниеОрганизации);
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецЕсли