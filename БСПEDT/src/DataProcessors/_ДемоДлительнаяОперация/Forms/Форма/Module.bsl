///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОписаниеПеременных

&НаКлиенте
Перем НомерОперации; // порядковый номер длительной операции.

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СкоростьВыполнения = 0;
	ОжидаемыйРезультат = "Успешно";
	ФормаОжидания = "Показывать";
	ПрогрессВыполнения = Истина;
	КоличествоШаговПрогресса = 15;
	РазмерШаговПрогресса = "1 1 5 1 0 0 1 6 0 0 0 0 0 0 0";
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		Элементы.ОжидаемыйРезультат.ВысотаЗаголовка = 2;
		Элементы.СкоростьВыполнения.ВысотаЗаголовка = 2;
		Элементы.ФормаОжидания.ВысотаЗаголовка = 2;
	КонецЕсли;
	
	СекундПередЗакрытием = 0.5;
	СекундПослеЗакрытия = 1;
	
	СекундПередЗакрытиемФормыВладельца = 0.01;
	
	Элементы.СообщенияЧерезСообщить.Подсказка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Выводить сообщения в длительной операции с помощью метода %1, а не %2'"),
		"Сообщение.Сообщить",
		"ОбщегоНазначения.СообщитьПользователю");
	
	Элементы.ГруппаПараметры.ЦветТекстаЗаголовка =
		Метаданные.ЭлементыСтиля.ЦветНедоступногоТекста.Значение;
	
	Если ОбщегоНазначения.РежимОтладки() Тогда
		Элементы.ПредупреждениеНадпись.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			Элементы.ПредупреждениеНадпись.Заголовок, "РежимОтладки");
		Элементы.ГруппаПредупреждение.Видимость = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ФормаОжиданияПриИзменении(Элементы.ФормаОжидания);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ФормаОжиданияПриИзменении(Элемент)
	
	ЦветНедоступногоТекста = Элементы.ГруппаПараметры.ЦветТекстаЗаголовка;
	
	Если ФормаОжидания = "Показывать" Тогда
		Элементы.ПрогрессВыполнения.ЦветТекстаЗаголовка = ЦветНедоступногоТекста;
		Элементы.ВыводитьСообщения.ЦветТекстаЗаголовка = Элементы.ЗапуститьВФоне.ЦветТекстаЗаголовка;
	Иначе
		Элементы.ВыводитьСообщения.ЦветТекстаЗаголовка = ЦветНедоступногоТекста;
		Элементы.ПрогрессВыполнения.ЦветТекстаЗаголовка = Элементы.ЗапуститьВФоне.ЦветТекстаЗаголовка;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыполнитьДействие(Команда)
	
	ПередВыполнением();
	
	ДлительнаяОперация = НачатьВыполнениеПроцедуры(НомерОперации);
	
	Контекст = Новый Структура("НомерОперации, ЭтоРасчетЗначения", НомерОперации, Ложь);
	ОповещениеОЗавершении = Новый ОписаниеОповещения("ОбработатьРезультат", ЭтотОбъект, Контекст);
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, ОповещениеОЗавершении, ПараметрыОжидания());
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьЗначение(Команда)
	
	ПередВыполнением();
	
	ДлительнаяОперация = НачатьВыполнениеФункции(НомерОперации);
	
	Контекст = Новый Структура("НомерОперации, ЭтоРасчетЗначения", НомерОперации, Истина);
	ОповещениеОЗавершении = Новый ОписаниеОповещения("ОбработатьРезультат", ЭтотОбъект, Контекст);
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, ОповещениеОЗавершении, ПараметрыОжидания());
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьОсвобождениеСсылкиНаФормуПослеЗакрытия(Команда)
	
	ОчиститьСообщения();
	ОчиститьСообщенияПользователю(ЭтотОбъект);
	
	// Проверяется вызов длительной операции из формы которая закрывается и
	// освобождение ссылки на форму в достаточно малый промежуток времени.
	
	ПараметрыФормы = Новый Структура("СекундПередЗакрытием", СекундПередЗакрытием);
	ОбработкаЗавершения = Новый ОписаниеОповещения("ПроверитьОсвобождениеСсылкиНаФормуПродолжение", ЭтотОбъект);
	ОткрытьФорму("Обработка._ДемоДлительнаяОперация.Форма.ДлительнаяОперацияСОтменойПриЗакрытии",
		ПараметрыФормы, ЭтотОбъект,,,, ОбработкаЗавершения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВыполнениеДлительнойОперацииПослеЗакрытияФормыВладельца(Команда)
	
	ОчиститьСообщения();
	ОчиститьСообщенияПользователю(ЭтотОбъект);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("СекундПередЗакрытием", СекундПередЗакрытиемФормыВладельца);
	ПараметрыФормы.Вставить("ПоказатьОповещение", ПоказатьОповещениеДляФормыВладельца);
	ОткрытьФорму("Обработка._ДемоДлительнаяОперация.Форма.ДлительнаяОперацияСЗакрытиеФормыВладельцаПослеЗапуска",
		ПараметрыФормы, ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПередВыполнением()
	
	ОчиститьСообщения();
	ОчиститьСообщенияПользователю(ЭтотОбъект);
	
	Если НомерОперации = Неопределено Тогда
		НомерОперации = 0;
	КонецЕсли;
	НомерОперации = НомерОперации + 1;
	
	Если ФормаОжидания = "Показывать" Тогда
		Элементы.СтраницыОперации.ТекущаяСтраница = Элементы.СтраницаУведомление;
	Иначе
		Элементы.СтраницыОперации.ТекущаяСтраница = Элементы.СтраницаДлительнаяОперация;
		ТекстУведомления = НСтр("ru = 'Пожалуйста, подождите...'");
		Если Не ПустаяСтрока(Уведомление) Тогда
			ТекстУведомления = Уведомление + Символы.ПС + ТекстУведомления;
		КонецЕсли;
		Элементы.ДлительнаяОперация.РасширеннаяПодсказка.Заголовок = ТекстУведомления;
	КонецЕсли;
	
	ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = '%1 Начало выполнения %2...'"),
		ОбщегоНазначенияКлиент.ДатаСеанса(),
		НомерОперации);
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.ИдентификаторНазначения = УникальныйИдентификатор;
	Сообщение.Текст = ТекстСообщения;
	СообщениеСообщить(ЭтотОбъект, Сообщение);
	
КонецПроцедуры 

&НаСервере
Функция ДополнительныеПараметрыВыполнения()
	
	Результат = Обработки._ДемоДлительнаяОперация.НовыеДополнительныеПараметрыВыполнения();
	Результат.ДлительностьРасчета = ?(ЗначениеЗаполнено(СкоростьВыполнения), 15, 0);
	Результат.ЗавершитьСОшибкой = ОжидаемыйРезультат = "Ошибка";
	Результат.ВыводитьПрогрессВыполнения = ПрогрессВыполнения;
	Результат.СообщенияЧерезСообщить = СообщенияЧерезСообщить;
	Результат.КоличествоШаговПрогресса = КоличествоШаговПрогресса;
	Результат.РазмерШаговПрогресса = РазмерШаговПрогресса;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция НачатьВыполнениеФункции(НомерОперации)
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	Если ЗапуститьВФоне Тогда
		ПараметрыВыполнения.ЗапуститьВФоне = Истина;
		ПараметрыВыполнения.ОжидатьЗавершение = 0;
	КонецЕсли;
	
	Возврат ДлительныеОперации.ВыполнитьФункцию(ПараметрыВыполнения,
		"Обработки._ДемоДлительнаяОперация.РассчитатьЗначение",
		НомерОперации,
		ДополнительныеПараметрыВыполнения());
	
КонецФункции

&НаСервере
Функция НачатьВыполнениеПроцедуры(НомерОперации)
	
	Если ЗапуститьВФоне Тогда
		ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
		ПараметрыВыполнения.ЗапуститьВФоне = Истина;
		ПараметрыВыполнения.ОжидатьЗавершение = 0;
	Иначе
		ПараметрыВыполнения = Неопределено;
	КонецЕсли;
	
	Возврат ДлительныеОперации.ВыполнитьПроцедуру(ПараметрыВыполнения,
		"Обработки._ДемоДлительнаяОперация.ВыполнитьРасчет", 
		НомерОперации,
		ДополнительныеПараметрыВыполнения());
	
КонецФункции

&НаКлиенте
Процедура ОбработатьРезультат(Результат, Контекст) Экспорт
	
	Элементы.СтраницыОперации.ТекущаяСтраница = Элементы.СтраницаУведомление;
	Если Результат = Неопределено Тогда  // отменено пользователем
		Возврат;
	КонецЕсли;
	
	ВывестиРезультат(Результат, Контекст.НомерОперации, Контекст.ЭтоРасчетЗначения);
	
	Если Результат.Статус = "Ошибка" Тогда
		ПоказатьПредупреждение(,Результат.КраткоеПредставлениеОшибки);
	КонецЕсли;
	
КонецПроцедуры 

&НаКлиенте
Процедура ВыполнитьДействиеПрогрессВыполнения(Прогресс, ДополнительныеПараметры) Экспорт
	
	ТекстУведомления = НСтр("ru = 'Пожалуйста, подождите...'");
	Если Не ПустаяСтрока(Уведомление) Тогда
		ТекстУведомления = Уведомление + Символы.ПС + ТекстУведомления;
	КонецЕсли;
	Если Прогресс.Прогресс <> Неопределено Тогда
		ТекстУведомления = ТекстУведомления + ПрогрессСтрокой(Прогресс.Прогресс);
		Элементы.ДлительнаяОперация.РасширеннаяПодсказка.Заголовок = ТекстУведомления;
	КонецЕсли;
	Если Прогресс.Сообщения <> Неопределено Тогда
		Для Каждого СообщениеПользователю Из Прогресс.Сообщения Цикл
			СообщениеПользователю.Текст = "[" + НСтр("ru = 'Из прогресса'") + "]: " + СообщениеПользователю.Текст;
			СообщениеСообщить(ЭтотОбъект, СообщениеПользователю);
		КонецЦикла;
	КонецЕсли;

КонецПроцедуры 

&НаКлиенте
Процедура ВывестиРезультат(Результат, НомерВыполненнойОперации, ЭтоРасчетЗначения)
	
	Если Результат.Статус = "Выполнено" Тогда
		ТекстСообщения = Неопределено;
		Если ЭтоРасчетЗначения Тогда
			Если Результат.Свойство("АдресРезультата") И ЗначениеЗаполнено(Результат.АдресРезультата) Тогда
				ТекстСообщения = ПолучитьИзВременногоХранилища(Результат.АдресРезультата);
			КонецЕсли;
			Если ТекстСообщения = Неопределено Тогда
				ТекстОшибки = НСтр("ru = 'Из временного хранилища не получен результат (получено Неопределено)'");
				ВызватьИсключение ТекстОшибки;
			КонецЕсли;
		КонецЕсли;
		Если ТекстСообщения = Неопределено Тогда
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Действие %1 успешно выполнено'"), НомерВыполненнойОперации);
		КонецЕсли;
	ИначеЕсли Результат.Статус = "Ошибка" Тогда
		ТекстСообщения = Результат.ПодробноеПредставлениеОшибки;
	КонецЕсли;
	
	Если Результат.Сообщения <> Неопределено Тогда
		Для Каждого СообщениеПользователю Из Результат.Сообщения Цикл
			СообщениеПользователю.Текст = "[" + НСтр("ru = 'При завершении'") + "]: " + СообщениеПользователю.Текст;
			СообщениеСообщить(ЭтотОбъект, СообщениеПользователю);
		КонецЦикла;
	КонецЕсли;
	
	СообщениеСообщить(ЭтотОбъект, СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = '%1 %2'"), ОбщегоНазначенияКлиент.ДатаСеанса(), ТекстСообщения));
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОчиститьСообщенияПользователю(Форма)
	
	Форма.СообщенияПользователю.Очистить();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура СообщениеСообщить(Форма, СообщениеПользователю)
	
	Текст = ?(ТипЗнч(СообщениеПользователю) = Тип("СообщениеПользователю"),
		СообщениеПользователю.Текст, Строка(СообщениеПользователю));
	
	Форма.СообщенияПользователю.ДобавитьСтроку(Текст);
	
КонецПроцедуры

&НаКлиенте
Функция ПрогрессСтрокой(Прогресс)
	
	Результат = "";
	Если Прогресс = Неопределено Тогда
		Возврат Результат;
	КонецЕсли;
	
	Процент = 0;
	Если Прогресс.Свойство("Процент", Процент) Тогда
		Результат = Строка(Процент) + "%";
	КонецЕсли;
	Текст = 0;
	Если Прогресс.Свойство("Текст", Текст) Тогда
		Если Не ПустаяСтрока(Результат) Тогда
			Результат = Результат + " (" + Текст + ")";
		Иначе
			Результат = Текст;
		КонецЕсли;
	КонецЕсли;

	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция ПараметрыОжидания()
	
	Перем ОповещениеОПрогрессеВыполнения, ПараметрыОжидания;
	
	Если ПрогрессВыполнения И (ФормаОжидания <> "Показывать") Тогда
		ОповещениеОПрогрессеВыполнения = Новый ОписаниеОповещения("ВыполнитьДействиеПрогрессВыполнения", ЭтотОбъект);
	Иначе
		ОповещениеОПрогрессеВыполнения = Неопределено;
	КонецЕсли;
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ТекстСообщения = Уведомление;
	ПараметрыОжидания.ВыводитьПрогрессВыполнения = ПрогрессВыполнения;
	ПараметрыОжидания.ОповещениеОПрогрессеВыполнения = ОповещениеОПрогрессеВыполнения;
	ПараметрыОжидания.ОповещениеПользователя.Показать = Истина;
	ПараметрыОжидания.ОповещениеПользователя.НавигационнаяСсылка = "e1cib/app/Обработка._ДемоДлительнаяОперация";
	ПараметрыОжидания.ВыводитьОкноОжидания = (ФормаОжидания = "Показывать");
	ПараметрыОжидания.ВыводитьСообщения = ВыводитьСообщения;
	Возврат ПараметрыОжидания;

КонецФункции

&НаКлиенте
Процедура ПроверитьОсвобождениеСсылкиНаФормуПродолжение(Результат, Контекст) Экспорт
	
	ПодключитьОбработчикОжидания("ОбработчикОжиданияПроверитьОсвобождениеСсылкиНаФорму",
		СекундПослеЗакрытия, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикОжиданияПроверитьОсвобождениеСсылкиНаФорму()
	
	ОповещениеОбработаноВЗакрытойФорме = Ложь;
	Оповестить("ДлительнаяОперацияСОтменойПриЗакрытии", , ЭтотОбъект);
	
	Если ОповещениеОбработаноВЗакрытойФорме Тогда
		ТекстПредупреждения = НСтр("ru = 'Ошибка: Ссылка на форму не освобождена'");
	Иначе
		ТекстПредупреждения = НСтр("ru = 'Ссылка на форму освобождена'");
	КонецЕсли;
	
	ПоказатьПредупреждение(, ТекстПредупреждения);
	
КонецПроцедуры

#КонецОбласти
