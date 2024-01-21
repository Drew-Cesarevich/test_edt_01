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

// СтандартныеПодсистемы.ВариантыОтчетов

// Задать настройки формы отчета.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения
//         - Неопределено
//   КлючВарианта - Строка
//                - Неопределено
//   Настройки - см. ОтчетыКлиентСервер.НастройкиОтчетаПоУмолчанию
//
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	    
	Настройки.События.ПриСозданииНаСервере = Истина;
	Настройки.События.ПередЗагрузкойВариантаНаСервере    = Истина; 
	Настройки.События.ПередЗагрузкойНастроекВКомпоновщик = Истина;
	Настройки.ФормироватьСразу = Истина;    

КонецПроцедуры

// См. ОтчетыПереопределяемый.ПриСозданииНаСервере.
Процедура ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	Если Форма.Параметры.ПредставлениеВарианта = "Расшифровка" Тогда
		ВызватьИсключение НСтр("ru = 'Выбранное действие в данном отчете не доступно.'");
	КонецЕсли;
	
	РассылкаОтчетовСсылка = Неопределено;
	
	Если Не Форма.Параметры.Свойство("РассылкаОтчетов", РассылкаОтчетовСсылка)
		И Не Форма.Параметры.Свойство("ПараметрКоманды", РассылкаОтчетовСсылка)
		И Не ЗначениеЗаполнено(РассылкаОтчетовСсылка) Тогда 
		Возврат;
	КонецЕсли;  
				
	СтруктураПараметровДанных = Новый Структура("РассылкаОтчетов", ПараметрДанных(РассылкаОтчетовСсылка));
	УстановитьПараметрыДанных(КомпоновщикНастроек.Настройки, СтруктураПараметровДанных);   
		
КонецПроцедуры

// См. ОтчетыПереопределяемый.ПередЗагрузкойВариантаНаСервере.
Процедура ПередЗагрузкойВариантаНаСервере(Форма, НовыеНастройкиКД) Экспорт
	
	НайденныйПараметр = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("РассылкаОтчетов");
	Если НайденныйПараметр = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РассылкаОтчетовСсылка = НайденныйПараметр.Значение;
	Если Не ЗначениеЗаполнено(РассылкаОтчетовСсылка) Тогда 
		Возврат;
	КонецЕсли;
		
	СтруктураПараметровДанных = Новый Структура;
	СтруктураПараметровДанных.Вставить("РассылкаОтчетов", ПараметрДанных(РассылкаОтчетовСсылка));  
	СтруктураПараметровДанных.Вставить("Период", ПараметрДанных(Новый СтандартныйПериод));  
		
	Если ЗначениеЗаполнено(Форма.КонтекстВарианта) Тогда 
		НовыеНастройкиКД.ДополнительныеСвойства.Вставить("РассылкаОтчетов", РассылкаОтчетовСсылка);
	КонецЕсли;    
		
	УстановитьПараметрыДанных(НовыеНастройкиКД, СтруктураПараметровДанных);
	
КонецПроцедуры

// Вызывается перед загрузкой новых настроек. Используется для изменения СКД отчета.
//
// Параметры:
//   Контекст - Произвольный
//   КлючСхемы - Строка
//   КлючВарианта - Строка
//                - Неопределено
//   НовыеНастройкиКД - НастройкиКомпоновкиДанных
//                    - Неопределено
//   НовыеПользовательскиеНастройкиКД - ПользовательскиеНастройкиКомпоновкиДанных
//                                    - Неопределено
//
Процедура ПередЗагрузкойНастроекВКомпоновщик(Контекст, КлючСхемы, КлючВарианта, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД) Экспорт
		
	НайденныйПараметр = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("РассылкаОтчетов");
	Если НайденныйПараметр = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РассылкаОтчетовСсылка = НайденныйПараметр.Значение;
	Если Не ЗначениеЗаполнено(РассылкаОтчетовСсылка) Тогда
		Возврат;
	КонецЕсли;
	
	// Отключение всех отборов
	Для Каждого Элемент Из НовыеНастройкиКД.Отбор.Элементы Цикл
		Элемент.Использование = Ложь;
		Если Не ЗначениеЗаполнено(Элемент.ИдентификаторПользовательскойНастройки) Тогда
			Продолжить;
		КонецЕсли;	
		СоответствующийПараметр = НовыеПользовательскиеНастройкиКД.Элементы.Найти(
			Элемент.ИдентификаторПользовательскойНастройки);
			
		Если СоответствующийПараметр <> Неопределено Тогда
			СоответствующийПараметр.Использование = Ложь;
		КонецЕсли;
	КонецЦикла;
	
	ПараметрыПоследнейРассылки = РассылкаОтчетов.ПараметрыЖурналаРегистрации(РассылкаОтчетовСсылка);
	
	СтруктураПараметровДанных = Новый Структура;

	Если ПараметрыПоследнейРассылки <> Неопределено Тогда
		Период  = Новый СтандартныйПериод;
		Период.ДатаНачала = ПараметрыПоследнейРассылки.ДатаНачала;
		Период.ДатаОкончания = ПараметрыПоследнейРассылки.ДатаОкончания;
		СтруктураПараметровДанных.Вставить("Период", ПараметрДанных(Период));
	КонецЕсли;  	
	
	СтруктураПараметровДанных.Вставить("Получатели", ПараметрДанных(Новый СписокЗначений(), Ложь));
		
	УстановитьПараметрыДанных(НовыеНастройкиКД, СтруктураПараметровДанных, НовыеПользовательскиеНастройкиКД);
			
КонецПроцедуры 

// Конец СтандартныеПодсистемы.ВариантыОтчетов

#КонецОбласти

#КонецОбласти
		
#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	НайденныйПараметр = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("РассылкаОтчетов");
	Если НайденныйПараметр = Неопределено
		Или Не ЗначениеЗаполнено(НайденныйПараметр.Значение) Тогда
		Возврат;
	КонецЕсли;
	
	РассылкаОтчетовСсылка = НайденныйПараметр.Значение;
	
	НайденныйПараметр = НайтиПараметрПользовательскихНастроек(КомпоновщикНастроек.ПользовательскиеНастройки.Элементы, "Период");
	Если НайденныйПараметр <> Неопределено И НайденныйПараметр.Значение <> Неопределено Тогда
		Период = НайденныйПараметр.Значение;
	Иначе
		Период = Новый СтандартныйПериод;
	КонецЕсли;  
	
	ДополнительныеПараметры = Новый Структура; 
	
	НайденныйПараметр = НайтиПараметрПользовательскихНастроек(КомпоновщикНастроек.ПользовательскиеНастройки.Элементы, "Получатели");
	Если НайденныйПараметр <> Неопределено И НайденныйПараметр.Значение <> Неопределено Тогда
		ДополнительныеПараметры.Вставить("Получатели", ПараметрДанных(НайденныйПараметр.Значение, НайденныйПараметр.Использование));
	Иначе
		ДополнительныеПараметры.Вставить("Получатели", ПараметрДанных(Новый СписокЗначений, Ложь));
	КонецЕсли;  
	
	ДокументРезультат.Очистить();
	
	ДанныеОтчета = ДанныеИсторииРассылкиОтчетов(РассылкаОтчетовСсылка, Период, ДополнительныеПараметры); 
	
	СтрокаИтогиРассылки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
	НСтр("ru = 'Отправлено: %1; Не отправлено: %2; Всего: %3'"), ДанныеОтчета.Отправлено, ДанныеОтчета.НеОтправлено, ДанныеОтчета.Всего);	
	КомпоновщикНастроек.Настройки.ПараметрыДанных.УстановитьЗначениеПараметра("СтрокаИтогиРассылки", СтрокаИтогиРассылки);
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	Настройки = КомпоновщикНастроек.ПолучитьНастройки();
	
	ВнешниеНаборыДанных = Новый Структура;
	ВнешниеНаборыДанных.Вставить("ДанныеИсторииРассылкиОтчетов", ДанныеОтчета.ИсторияРассылки);
				
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, Настройки, ДанныеРасшифровки);
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, ВнешниеНаборыДанных, ДанныеРасшифровки, Истина);
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	
	ПроцессорВывода.НачатьВывод();
	ЭлементРезультата = ПроцессорКомпоновки.Следующий();
	Пока ЭлементРезультата <> Неопределено Цикл
		ПроцессорВывода.ВывестиЭлемент(ЭлементРезультата);
		ЭлементРезультата = ПроцессорКомпоновки.Следующий();
	КонецЦикла;
	ПроцессорВывода.ЗакончитьВывод();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДанныеИсторииРассылкиОтчетов(Рассылка, Период, ДополнительныеПараметры)
	
	Запрос = Новый Запрос;
	ТекстЗапроса =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ИсторияРассылкиОтчетов.РассылкаОтчетов КАК РассылкаОтчетов,
		|	ИсторияРассылкиОтчетов.Получатель КАК Получатель,
		|	ИсторияРассылкиОтчетов.Выполнена КАК Успешно,
		|	ИсторияРассылкиОтчетов.Комментарий КАК Комментарий,
		|	ИсторияРассылкиОтчетов.ЗапускРассылки КАК ЗапускРассылки,
		|	ИсторияРассылкиОтчетов.ЭлектронноеПисьмоИсходящее КАК ЭлектронноеПисьмоИсходящее,
		|	ИсторияРассылкиОтчетов.СпособПолучения КАК СпособПолучения,
		|	ИсторияРассылкиОтчетов.Период КАК Отправлено,
		|	ИсторияРассылкиОтчетов.ДатаДоставки КАК ДатаДоставки,
		|	ИсторияРассылкиОтчетов.АдресЭП КАК АдресЭП,
		|	ИсторияРассылкиОтчетов.Статус КАК Статус
		|ИЗ
		|	РегистрСведений.ИсторияРассылкиОтчетов КАК ИсторияРассылкиОтчетов
		|ГДЕ
		|	ИсторияРассылкиОтчетов.РассылкаОтчетов = &РассылкаОтчетов
		|	И ИсторияРассылкиОтчетов.Период МЕЖДУ &ДатаНачала И &ДатаОкончания";

	Запрос.УстановитьПараметр("РассылкаОтчетов", Рассылка); 
	Запрос.УстановитьПараметр("ДатаНачала", Период.ДатаНачала); 
	Запрос.УстановитьПараметр("ДатаОкончания", ?(ЗначениеЗаполнено(Период.ДатаОкончания),Период.ДатаОкончания,'39991231235959'));
	
	Если ДополнительныеПараметры.Получатели.Использование Тогда      
		ТекстЗапроса = ТекстЗапроса + "	И ИсторияРассылкиОтчетов.Получатель в (&Получатели)";
		Запрос.УстановитьПараметр("Получатели", ДополнительныеПараметры.Получатели.ЗначениеПараметра); 
	КонецЕсли;
	
	Запрос.Текст = ТекстЗапроса;
	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	
	ИсторияРассылки = Новый ТаблицаЗначений;
	ИсторияРассылки.Колонки.Добавить("РассылкаОтчетов", Новый ОписаниеТипов("СправочникСсылка.РассылкиОтчетов")); 
	ИсторияРассылки.Колонки.Добавить("Получатель", Метаданные.ОпределяемыеТипы.ПолучательРассылки.Тип);
	ИсторияРассылки.Колонки.Добавить("Отправлено", Новый ОписаниеТипов("Дата"));   
	ИсторияРассылки.Колонки.Добавить("АдресЭП", Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(100)));
	ИсторияРассылки.Колонки.Добавить("Успешно", Новый ОписаниеТипов("Булево"));
	ИсторияРассылки.Колонки.Добавить("Комментарий", Новый ОписаниеТипов("Строка"));
	ИсторияРассылки.Колонки.Добавить("НомерСеанса",Новый ОписаниеТипов("Строка",,,Новый КвалификаторыЧисла(25)));
	ИсторияРассылки.Колонки.Добавить("ЗапускРассылки", Новый ОписаниеТипов("Дата"));  
	ИсторияРассылки.Колонки.Добавить("ДатаДоставки", Новый ОписаниеТипов("Дата"));   
	ИсторияРассылки.Колонки.Добавить("СпособПолучения", Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(500)));
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Взаимодействия") Тогда	
		ИсторияРассылки.Колонки.Добавить("ЭлектронноеПисьмоИсходящее", Новый ОписаниеТипов("ДокументСсылка.ЭлектронноеПисьмоИсходящее"));   
	Иначе
		ИсторияРассылки.Колонки.Добавить("СпособПолучения", Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(10)));
	КонецЕсли;
		
	Пока Выборка.Следующий() Цикл

		ОтборСтрок = Новый Структура;
		ОтборСтрок.Вставить("РассылкаОтчетов", Выборка.РассылкаОтчетов);
		ОтборСтрок.Вставить("Получатель", Выборка.Получатель);
		ОтборСтрок.Вставить("ЗапускРассылки", Выборка.ЗапускРассылки); 
		ОтборСтрок.Вставить("АдресЭП", Выборка.АдресЭП);

		СтрокиИстории = ИсторияРассылки.НайтиСтроки(ОтборСтрок);

		Если СтрокиИстории.Количество() > 0 Тогда
			СтрокаИстории = СтрокиИстории[0];
			СтрокаИстории.Отправлено = Макс(СтрокаИстории.Отправлено, Выборка.Отправлено);
			СтрокаИстории.Успешно = Макс(СтрокаИстории.Успешно, Выборка.Успешно);
			Если Выборка.Статус = Перечисления.СтатусыЭлектронныхПисем.НеДоставлено Тогда
				СтрокаИстории.Успешно = Ложь;	
			КонецЕсли;
			СтрокаИстории.Комментарий = ?(ЗначениеЗаполнено(СтрокаИстории.Комментарий), СтрокаИстории.Комментарий
				+ Символы.ПС + Выборка.Комментарий, Выборка.Комментарий);
			Если ЗначениеЗаполнено(Выборка.ЭлектронноеПисьмоИсходящее) Тогда
				СтрокаИстории.ЭлектронноеПисьмоИсходящее = Выборка.ЭлектронноеПисьмоИсходящее;
			КонецЕсли;              
			Если ЗначениеЗаполнено(Выборка.ДатаДоставки) Тогда 
				СтрокаИстории.ДатаДоставки = Выборка.ДатаДоставки;  
			КонецЕсли;
		Иначе
			СтрокаИстории = ИсторияРассылки.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаИстории, Выборка);
		КонецЕсли;

	КонецЦикла;    
		
	Отправлено = 0; 
	НеОтправлено = 0;
	Для Каждого ПолеИстории Из ИсторияРассылки Цикл
		Если ПолеИстории.Успешно Тогда
			Отправлено = Отправлено + 1;
		Иначе
			НеОтправлено = НеОтправлено + 1;
		КонецЕсли;		
	КонецЦикла;
	
	ДанныеОтчета = Новый Структура;    
	ДанныеОтчета.Вставить("ИсторияРассылки", ИсторияРассылки);
	ДанныеОтчета.Вставить("Отправлено", Отправлено);  
	ДанныеОтчета.Вставить("НеОтправлено", НеОтправлено); 
	ДанныеОтчета.Вставить("Всего", Отправлено + НеОтправлено);
	
	Возврат ДанныеОтчета;
	
КонецФункции

Процедура УстановитьПараметрыДанных(Настройки, ЗначенияПараметров, ПользовательскиеНастройки = Неопределено)
	
	ПараметрыДанных = Настройки.ПараметрыДанных.Элементы;
	
	Для Каждого ЗначениеПараметра Из ЗначенияПараметров Цикл 
		
		ПараметрДанных = ПараметрыДанных.Найти(ЗначениеПараметра.Ключ);
		
		Если ПараметрДанных = Неопределено Тогда
             Продолжить;
		КонецЕсли;
		
		ПараметрДанных.Использование = ЗначениеПараметра.Значение.Использование;
		ПараметрДанных.Значение = ЗначениеПараметра.Значение.ЗначениеПараметра;
		
		Если Не ЗначениеЗаполнено(ПараметрДанных.ИдентификаторПользовательскойНастройки)
			Или ТипЗнч(ПользовательскиеНастройки) <> Тип("ПользовательскиеНастройкиКомпоновкиДанных") Тогда 
			Продолжить;
		КонецЕсли;
		
		СоответствующийПараметр = ПользовательскиеНастройки.Элементы.Найти(
			ПараметрДанных.ИдентификаторПользовательскойНастройки);
		
		Если СоответствующийПараметр <> Неопределено Тогда 
			ЗаполнитьЗначенияСвойств(СоответствующийПараметр, ПараметрДанных, "Использование, Значение");
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Функция ПараметрДанных(ЗначениеПараметра, Использование = Истина)

	Возврат Новый Структура("ЗначениеПараметра, Использование", ЗначениеПараметра, Использование);
	
КонецФункции

Функция НайтиПараметрПользовательскихНастроек(ЭлементыПользовательскихНастроек, ИмяПараметра)   
	
	ИскомыйПараметр = Новый ПараметрКомпоновкиДанных(ИмяПараметра);

	Для Каждого Элемент Из ЭлементыПользовательскихНастроек Цикл 
		Если ТипЗнч(Элемент) = Тип("ЗначениеПараметраНастроекКомпоновкиДанных") И Элемент.Параметр = ИскомыйПараметр Тогда
			Возврат Элемент;    
		КонецЕсли;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли