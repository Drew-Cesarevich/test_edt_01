///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОписаниеПеременных

// СтандартныеПодсистемы.ОценкаПроизводительности
&НаКлиенте
Перем ИдентификаторЗамераПроведение;
// Конец СтандартныеПодсистемы.ОценкаПроизводительности

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПредыдущийСтатусЗаказа = Объект.СтатусЗаказа;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	
	// СтандартныеПодсистемы.Взаимодействия
	Взаимодействия.ПодготовитьОповещения(ЭтотОбъект,Параметры);
	// Конец СтандартныеПодсистемы.Взаимодействия
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	ДополнительныеПараметрыКонтактнойИнформации = УправлениеКонтактнойИнформацией.ПараметрыКонтактнойИнформации();
	ДополнительныеПараметрыКонтактнойИнформации.ИмяЭлементаДляРазмещения = "ГруппаКонтактнаяИнформация";
	ДополнительныеПараметрыКонтактнойИнформации.ПоложениеЗаголовкаКИ = ПоложениеЗаголовкаЭлементаФормы.Лево;
	ДополнительныеПараметрыКонтактнойИнформации.РазрешитьДобавлениеПолей = Ложь;
	УправлениеКонтактнойИнформацией.ПриСозданииНаСервере(ЭтотОбъект, Объект, ДополнительныеПараметрыКонтактнойИнформации);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	ИнициализироватьПоляКонтактнойИнформации();
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	УстановитьВидимостьЭлементов();
	
	// СтандартныеПодсистемы.РаботаСФайлами
	ГиперссылкаФайлов = РаботаСФайлами.ГиперссылкаФайлов();
	ГиперссылкаФайлов.Размещение = "КоманднаяПанель";
	НастройкиРаботыСФайламиВФорме = РаботаСФайлами.НастройкиРаботыСФайламиВФорме();
	НастройкиРаботыСФайламиВФорме.КопироватьПрисоединенныеФайлы = Истина;
	РаботаСФайлами.ПриСозданииНаСервере(ЭтотОбъект, ГиперссылкаФайлов, НастройкиРаботыСФайламиВФорме);
	// Конец СтандартныеПодсистемы.РаботаСФайлами
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		
		Элементы.Договор.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Верх;
		Элементы.Комментарий.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Верх;
		Элементы.ШаблонСообщения.Заголовок = НСтр("ru = 'Шаблон'");
		Элементы.ШаблонСообщения.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Авто;
		Элементы.СчетаНаОплатуНомерСтроки.Видимость = Ложь;
		Элементы.ПартнерыИКонтактныеЛицаНомерСтроки.Видимость = Ложь;
		Элементы.ШапкаСправа.ВыравниваниеЭлементовИЗаголовков =
			ВариантВыравниванияЭлементовИЗаголовков.ЭлементыПравоЗаголовкиЛево;
		Элементы.ГруппаОсновное.ВыравниваниеЭлементовИЗаголовков =
			ВариантВыравниванияЭлементовИЗаголовков.ЭлементыПравоЗаголовкиЛево;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьСчетчикиСтрокТаблиц();
	
	// СтандартныеПодсистемы.РаботаСФайлами
	РаботаСФайламиКлиент.ПриОткрытии(ЭтотОбъект, Отказ);
	// Конец СтандартныеПодсистемы.РаботаСФайлами
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ОбработкаПроверкиЗаполненияНаСервере(ЭтотОбъект, Объект, Отказ);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация

КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	УстановитьВидимостьЭлементов();
	
	// СтандартныеПодсистемы.КонтрольВеденияУчета
	КонтрольВеденияУчета.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.КонтрольВеденияУчета
	
	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.ОценкаПроизводительности
	Если ПараметрыЗаписи.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
	
		ИдентификаторЗамераПроведение = ОценкаПроизводительностиКлиент.ЗамерВремени();
		
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ОценкаПроизводительности
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация

КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.РаботаСФайлами
	РаботаСФайлами.ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи, ЭтотОбъект);
	// Конец СтандартныеПодсистемы.РаботаСФайлами
	
	// СтандартныеПодсистемы.Взаимодействия
	Если ЗначениеЗаполнено(ВзаимодействиеОснование) Тогда
		Взаимодействия.ПриЗаписиПредметаИзФормы(
			ТекущийОбъект.Ссылка, ВзаимодействиеОснование, Отказ);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Взаимодействия
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	// СтандартныеПодсистемы.ШаблоныСообщений
	Если ТекущийОбъект.СтатусЗаказа <> ПредыдущийСтатусЗаказа
		И ТекущийОбъект.УведомлятьОбИзменениеСтатусаЗаказа Тогда
		
			УчетныеЗаписи = РаботаСПочтовымиСообщениями.ДоступныеУчетныеЗаписи(Истина, Ложь);

			ДополнительныеПараметры = ШаблоныСообщений.ПараметрыОтправкиПисьмаПоШаблону();
			ДополнительныеПараметры.ОтправитьСразу = Истина;
			Если УчетныеЗаписи.Количество() > 0 Тогда
				ДополнительныеПараметры.УчетнаяЗапись = УчетныеЗаписи[0].Ссылка;
			КонецЕсли;
			
			ДополнительныеПараметры.ЗначенияПараметровСКД.Вставить("ДатаДоставки", Формат(ТекущаяДатаСеанса() + 24*60*60, "ДЛФ=DD;" ));
			
			Результат = ШаблоныСообщений.СформироватьСообщениеИОтправить(ТекущийОбъект.ШаблонСообщения, ТекущийОбъект.Ссылка, УникальныйИдентификатор, ДополнительныеПараметры);
			
			Если Не Результат.Отправлено Тогда
				ЗаписьЖурналаРегистрации(СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Предупреждение, Метаданные.Документы._ДемоЗаказПокупателя,
					Объект.Ссылка, Результат.ОписаниеОшибки);
			КонецЕсли;
			ПредыдущийСтатусЗаказа = ТекущийОбъект.СтатусЗаказа;
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ШаблоныСообщений
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.ОценкаПроизводительности
	Если ПараметрыЗаписи.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
        
        ОценкаПроизводительностиКлиент.УстановитьКлючевуюОперациюЗамера(ИдентификаторЗамераПроведение, "_ДемоЗаказПокупателяПроведение");
		
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ОценкаПроизводительности
	
	// СтандартныеПодсистемы.Взаимодействия
	ВзаимодействияКлиент.ВзаимодействиеПредметПослеЗаписи(ЭтотОбъект,Объект,ПараметрыЗаписи,"_ДемоЗаказПокупателя");
	// Конец СтандартныеПодсистемы.Взаимодействия
	
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	Оповестить("Запись__ДемоЗаказПокупателя", Новый Структура, Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	// СтандартныеПодсистемы.РаботаСФайлами
	РаботаСФайламиКлиент.ОбработкаОповещения(ЭтотОбъект, ИмяСобытия);
	// Конец СтандартныеПодсистемы.РаботаСФайлами

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КонтрагентПриИзменении(Элемент)
	
	УстановитьВидимостьЭлементов();
	
КонецПроцедуры

// СтандартныеПодсистемы.КонтактнаяИнформация

// Демонстрация программного интерфейса для размещения полей контактной информации в форме.

&НаКлиенте
Процедура ПредставлениеАдресаДоставкиПриИзменении(Элемент)
	
	Текст = Элемент.ТекстРедактирования;
	Если ПустаяСтрока(Текст) Тогда
		// Очистка данных, сбрасываем как представления, так и внутренние значения полей.
		ПредставлениеАдресаДоставки = "";
		КомментарийАдресаДоставки   = "";
		Объект.АдресДоставки        = "";
		Возврат;
	КонецЕсли;
		
	// Формируем внутренние значения полей по тексту и параметрам формирования из
	// реквизита ВидКонтактнойИнформацииАдресаДоставки.
	ПредставлениеАдресаДоставки = Текст;
	Объект.АдресДоставки = ЗначенияПолейКонтактнойИнформацииСервер(Текст, ВидКонтактнойИнформацииАдресаДоставки, КомментарийАдресаДоставки);
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеАдресаДоставкиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	// Если представление было изменено в поле и сразу нажата кнопка выбора, то необходимо 
	// привести данные в соответствие и сбросить внутренние поля для повторного разбора.
	Если Элемент.ТекстРедактирования <> ПредставлениеАдресаДоставки Тогда
		ПредставлениеАдресаДоставки = Элемент.ТекстРедактирования;
		Объект.АдресДоставки        = "";
	КонецЕсли;
	
	// Данные для редактирования
	ПараметрыОткрытия = УправлениеКонтактнойИнформациейКлиент.ПараметрыФормыКонтактнойИнформации(ВидКонтактнойИнформацииАдресаДоставки, 
		Объект.АдресДоставки, ПредставлениеАдресаДоставки, КомментарийАдресаДоставки);
		
	Если ПустаяСтрока(Объект.АдресДоставки) Тогда
		ПараметрыОткрытия.ТипАдреса = "АдминистративноТерриториальный";
	КонецЕсли;
	
	УправлениеКонтактнойИнформациейКлиент.ОткрытьФормуКонтактнойИнформации(ПараметрыОткрытия, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеАдресаДоставкиОчистка(Элемент, СтандартнаяОбработка)
	// Сбрасываем как представления, так и внутренние значения полей.
	ПредставлениеАдресаДоставки = "";
	КомментарийАдресаДоставки   = "";
	Объект.АдресДоставки        = "";
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеАдресаДоставкиОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Если ТипЗнч(ВыбранноеЗначение)<>Тип("Структура") Тогда
		// Отказ от выбора, данные неизменны.
		Возврат;
	КонецЕсли;
	
	ПредставлениеАдресаДоставки = ВыбранноеЗначение.Представление;
	КомментарийАдресаДоставки   = ВыбранноеЗначение.Комментарий;
	Объект.АдресДоставки        = ВыбранноеЗначение.Значение;
	Модифицированность          = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура КомментарийАдресаДоставкиПриИзменении(Элемент)
	ЗаполнитьКомментарийАдресаДоставкиСервер();
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеЭлектроннойПочтыПриИзменении(Элемент)
	Текст = Элемент.ТекстРедактирования;
	Если ПустаяСтрока(Текст) Тогда
		// Очистка данных, сбрасываем как представления, так и внутренние значения полей.
		ПредставлениеЭлектроннойПочты = "";
		Объект.ЭлектроннаяПочта       = "";
		Возврат;
	КонецЕсли;
		
	// Формируем внутренние значения полей по тексту и параметрам формирования из
	// реквизита ВидКонтактнойИнформацииЭлектроннойПочты.
	ПредставлениеЭлектроннойПочты = Текст;
	Объект.ЭлектроннаяПочта = ЗначенияПолейКонтактнойИнформацииСервер(Текст, ВидКонтактнойИнформацииЭлектроннойПочты);
КонецПроцедуры

// Конец СтандартныеПодсистемы.КонтактнаяИнформация

// СтандартныеПодсистемы.ШаблоныСообщений

&НаКлиенте
Процедура ШаблонСообщенияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Оповещение = Новый ОписаниеОповещения("ПослеВыбораШаблона", ЭтотОбъект);
	ШаблоныСообщенийКлиент.ВыбратьШаблон(Оповещение, "Письмо", "ОповещениеКлиентаИзменениеЗаказа");
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ШаблоныСообщений

// СтандартныеПодсистемы.РаботаСФайлами
&НаКлиенте
Процедура Подключаемый_ПолеПредпросмотраНажатие(Элемент, СтандартнаяОбработка)

	РаботаСФайламиКлиент.ПолеПредпросмотраНажатие(ЭтотОбъект, Элемент, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПолеПредпросмотраПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)

	РаботаСФайламиКлиент.ПолеПредпросмотраПроверкаПеретаскивания(ЭтотОбъект, Элемент,
				ПараметрыПеретаскивания, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПолеПредпросмотраПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)

	РаботаСФайламиКлиент.ПолеПредпросмотраПеретаскивание(ЭтотОбъект, Элемент,
				ПараметрыПеретаскивания, СтандартнаяОбработка);

КонецПроцедуры
// Конец СтандартныеПодсистемы.РаботаСФайлами

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСчетаНаОплату

&НаКлиенте
Процедура СчетаНаОплатуПриИзменении(Элемент)
	ОбновитьСчетчикиСтрокТаблиц();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыПартнерыИКонтактныеЛица

&НаКлиенте
Процедура ПартнерыИКонтактныеЛицаПриИзменении(Элемент)
	ОбновитьСчетчикиСтрокТаблиц();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура НаписатьЭлектронноеПисьмо(Команда)
	
	УправлениеКонтактнойИнформациейКлиент.СоздатьЭлектронноеПисьмо(Объект.ЭлектроннаяПочта,
		ПредставлениеЭлектроннойПочты, ВидКонтактнойИнформацииЭлектроннойПочты, Объект.Партнер);
		
КонецПроцедуры

// СтандартныеПодсистемы.РаботаСФайлами
&НаКлиенте
Процедура Подключаемый_КомандаПанелиПрисоединенныхФайлов(Команда)

	РаботаСФайламиКлиент.КомандаУправленияПрисоединеннымиФайлами(ЭтотОбъект, Команда);

КонецПроцедуры
// Конец СтандартныеПодсистемы.РаботаСФайлами

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает строковую константу для формирования сообщений журнала регистрации.
//
// Возвращаемое значение:
//   Строка
//
&НаСервереБезКонтекста
Функция СобытиеЖурналаРегистрации()
	
	Возврат НСтр("ru = 'Неудачная отправка оповещения'", ОбщегоНазначения.КодОсновногоЯзыка());
	
КонецФункции

// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов

&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъекта(Команда)
	
	ЗаблокированныеРеквизиты = ЗапретРедактированияРеквизитовОбъектовКлиент.Реквизиты(ЭтотОбъект);
	
	Если ЗаблокированныеРеквизиты.Количество() > 0 Тогда
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Ссылка", Объект.Ссылка);
		ПараметрыФормы.Вставить("ЗаблокированныеРеквизиты", ЗаблокированныеРеквизиты);
		
		ОткрытьФорму("Документ._ДемоЗаказПокупателя.Форма.РазблокированиеРеквизитов", ПараметрыФормы,
			ЭтотОбъект,,,, Новый ОписаниеОповещения("ПослеВыбораРеквизитовДляРазблокирования", ЭтотОбъект));
	Иначе
		ЗапретРедактированияРеквизитовОбъектовКлиент.ПоказатьПредупреждениеВсеВидимыеРеквизитыРазблокированы();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораРеквизитовДляРазблокирования(РазблокируемыеРеквизиты, Контекст) Экспорт
	
	Если ТипЗнч(РазблокируемыеРеквизиты) <> Тип("Массив") Тогда
		Возврат;
	КонецЕсли;
	
	ЗапретРедактированияРеквизитовОбъектовКлиент.УстановитьДоступностьЭлементовФормы(ЭтотОбъект,
		РазблокируемыеРеквизиты);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов

&НаСервере
Процедура УстановитьВидимостьЭлементов()
	
	Если ЗначениеЗаполнено(Объект.Контрагент) Тогда
		ВидКонтрагента = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Контрагент, "ВидКонтрагента");
	Иначе
		ВидКонтрагента = Неопределено;
	КонецЕсли;
	
	Элементы.Договор.Видимость = ВидКонтрагента <> Перечисления._ДемоЮридическоеФизическоеЛицо.ФизическоеЛицо;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСчетчикиСтрокТаблиц()
	
	Элементы.СтраницаСчетаНаОплату.Заголовок = 
		?(Объект.СчетаНаОплату.Количество() > 0, 
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Счета на оплату (%1)'"), Объект.СчетаНаОплату.Количество()),
			НСтр("ru = 'Счета на оплату'"));
	Элементы.СтраницаПартнерыИКонтактныеЛица.Заголовок = 
		?(Объект.ПартнерыИКонтактныеЛица.Количество() > 0, 
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Контактные лица (%1)'"), Объект.ПартнерыИКонтактныеЛица.Количество()),
			НСтр("ru = 'Контактные лица'"));
	
КонецПроцедуры

// СтандартныеПодсистемы.КонтактнаяИнформация

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриИзменении(Элемент)
	УправлениеКонтактнойИнформациейКлиент.НачатьИзменение(ЭтотОбъект, Элемент);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.НачатьВыбор(ЭтотОбъект, Элемент, , СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриНажатии(Элемент, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.НачатьВыбор(ЭтотОбъект, Элемент, , СтандартнаяОбработка);
КонецПроцедуры

// Параметры:
//  Элемент - ПолеФормы
//  СтандартнаяОбработка - Булево
//
&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОчистка(Элемент, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.НачатьОчистку(ЭтотОбъект, Элемент.Имя);
КонецПроцедуры

// Параметры:
//  Команда - КомандаФормы
// 
&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияВыполнитьКоманду(Команда)
	УправлениеКонтактнойИнформациейКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда.Имя);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	УправлениеКонтактнойИнформациейКлиент.АвтоПодборАдреса(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка);
	
КонецПроцедуры

// Параметры:
//  Элемент - ПолеФормы
//  ВыбранноеЗначение - Произвольный
//  СтандартнаяОбработка -Булево
//
&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	УправлениеКонтактнойИнформациейКлиент.ОбработкаВыбора(ЭтотОбъект, ВыбранноеЗначение, Элемент.Имя, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.НачатьОбработкуНавигационнойСсылки(ЭтотОбъект, Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьОбновлениеКонтактнойИнформации(Результат, ДополнительныеПараметры) Экспорт
	ОбновитьКонтактнуюИнформацию(Результат);
КонецПроцедуры

&НаСервере
Процедура ОбновитьКонтактнуюИнформацию(Результат)
	УправлениеКонтактнойИнформацией.ОбновитьКонтактнуюИнформацию(ЭтотОбъект, Объект, Результат);
КонецПроцедуры

// Демонстрация программного интерфейса для размещения полей контактной информации в форме.

&НаСервере
Процедура ИнициализироватьПоляКонтактнойИнформации()
	
	// Реквизит формы, контролирующий работу с адресом доставки.
	ОписаниеВидКонтактнойИнформации = УправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации(Перечисления.ТипыКонтактнойИнформации.Адрес);
	ОписаниеВидКонтактнойИнформации.НастройкиПроверки.ПроверятьКорректность = Истина;
	ОписаниеВидКонтактнойИнформации.НастройкиПроверки.ВключатьСтрануВПредставление = Истина;
	ОписаниеВидКонтактнойИнформации.Наименование = НСтр("ru = 'Адрес доставки'");
	ВидКонтактнойИнформацииАдресаДоставки = ОписаниеВидКонтактнойИнформации;
	
	// Аналогичные реквизиты для электронной почты.
	ВидКонтактнойИнформацииЭлектроннойПочты = Новый Структура;
	ВидКонтактнойИнформацииЭлектроннойПочты.Вставить("Тип", Перечисления.ТипыКонтактнойИнформации.АдресЭлектроннойПочты);
	
	// Считываем данные из полей адреса в реквизиты для редактирования.
	ПредставлениеАдресаДоставки = УправлениеКонтактнойИнформацией.ПредставлениеКонтактнойИнформации(Объект.АдресДоставки);
	КомментарийАдресаДоставки   = УправлениеКонтактнойИнформацией.КомментарийКонтактнойИнформации(Объект.АдресДоставки);
	
	ПредставлениеЭлектроннойПочты = УправлениеКонтактнойИнформацией.ПредставлениеКонтактнойИнформации(Объект.ЭлектроннаяПочта);
КонецПроцедуры

// Устанавливаем новый комментарий для адреса доставки.
// 
&НаСервере
Процедура ЗаполнитьКомментарийАдресаДоставкиСервер()
	
	Если ПустаяСтрока(Объект.АдресДоставки) Тогда
		// Необходимо инициализировать данные.
		Объект.АдресДоставки = ЗначенияПолейКонтактнойИнформацииСервер(ПредставлениеАдресаДоставки, ВидКонтактнойИнформацииАдресаДоставки, КомментарийАдресаДоставки);
		Возврат;
	КонецЕсли;
	
	УправлениеКонтактнойИнформацией.УстановитьКомментарийКонтактнойИнформации(Объект.АдресДоставки, КомментарийАдресаДоставки);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗначенияПолейКонтактнойИнформацииСервер(Знач Представление, Знач ВидКонтактнойИнформации, Знач Комментарий = Неопределено)
	
	// Создаем новый экземпляр по представлению.
	Результат = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияПоПредставлению(Представление, ВидКонтактнойИнформации);
	
	Возврат Результат;
КонецФункции

// Конец СтандартныеПодсистемы.КонтактнаяИнформация

// СтандартныеПодсистемы.КонтрольВеденияУчета

&НаКлиенте
Процедура Подключаемый_ОткрытьОтчетПоПроблемам(ЭлементИлиКоманда, НавигационнаяСсылка, СтандартнаяОбработка)
	КонтрольВеденияУчетаКлиент.ОткрытьОтчетПоПроблемамОбъекта(ЭтотОбъект, Объект.Ссылка, СтандартнаяОбработка);
КонецПроцедуры

// Конец СтандартныеПодсистемы.КонтрольВеденияУчета

// СтандартныеПодсистемы.ШаблоныСообщений

&НаКлиенте
Процедура ПослеВыбораШаблона(Шаблон, ДополнительныеПараметры) Экспорт
	Если Шаблон <> Неопределено Тогда
		Объект.ШаблонСообщения = Шаблон;
		Модифицированность = Истина;
	КонецЕсли;
КонецПроцедуры

// Конец СтандартныеПодсистемы.ШаблоныСообщений


#КонецОбласти
