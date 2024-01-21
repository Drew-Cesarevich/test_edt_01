///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	Если ДанныеЗаполнения = Неопределено Тогда // Ввод нового.
		_ДемоСтандартныеПодсистемы.ПриВводеНовогоЗаполнитьОрганизацию(ЭтотОбъект);
	КонецЕсли;
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	СчетФактура = Неопределено;
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	СформироватьДвиженияПоМестамХранения();
	
	СформироватьБухгалтерскиеДвижения();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СформироватьДвиженияПоМестамХранения()
	
	Движения._ДемоОстаткиТоваровВМестахХранения.Записывать = Истина;
	
	Для Каждого СтрокаТовары Из Товары Цикл
		
		Движение = Движения._ДемоОстаткиТоваровВМестахХранения.Добавить();
		
		Движение.Период        = Дата;
		Движение.ВидДвижения   = ВидДвиженияНакопления.Приход;
		
		Движение.Организация   = Организация;
		Движение.МестоХранения = МестоХранения;
		
		Движение.Номенклатура  = СтрокаТовары.Номенклатура;
		Движение.Количество    = СтрокаТовары.Количество;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура СформироватьБухгалтерскиеДвижения()
	
	ВалютныйДокумент = Валюта.Код <> "643";
	Если Валюта.Пустая() Тогда
		ВалютаДокумента  = Новый Структура("Курс, Кратность", 1, 1,);
	Иначе
		ВалютаДокумента  = РаботаСКурсамиВалют.ПолучитьКурсВалюты(Валюта, Дата);
	КонецЕсли;
	
	ОбрабатыватьНДС = УчитыватьНДС И Не ВалютныйДокумент;
	
	Движения._ДемоЖурналПроводокБухгалтерскогоУчета.Записывать = Истина;    
	Движения._ДемоЖурналПроводокБухгалтерскогоУчетаБезКорреспонденции.Записывать = Истина;
	
	Для Каждого СтрокаТовара Из Товары Цикл
		
		СформироватьДвижениеПоступленияТовараПоРегиструОсновной(СтрокаТовара, ВалютныйДокумент, ВалютаДокумента);   
		СформироватьДвижениеПоступленияТовараПоРегиструОсновнойБезКорреспонденции(СтрокаТовара, ВалютныйДокумент, ВалютаДокумента);
		
		Если ОбрабатыватьНДС Тогда
			СформироватьДвижениеУчетаВходящегоНДСПоРегиструОсновной(СтрокаТовара); 
			СформироватьДвижениеУчетаВходящегоНДСПоРегиструОсновнойБезКорреспонденции(СтрокаТовара);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура СформироватьДвижениеПоступленияТовараПоРегиструОсновной(Знач СтрокаТовара, Знач ВалютныйУчет, Знач ВалютаДокумента)
	
	ВалютнаяСумма = СтрокаТовара.Цена * СтрокаТовара.Количество;
	РублеваяСумма = ВалютнаяСумма * ВалютаДокумента.Курс / ВалютаДокумента.Кратность;
	
	Движение = Движения._ДемоЖурналПроводокБухгалтерскогоУчета.Добавить();
	Движение.Период      = Дата;
	Движение.Организация = Организация;
	Движение.Содержание  = НСтр("ru = 'Поступление товаров'");
	Движение.Сумма       = РублеваяСумма;
	
	Движение.СчетДт = ПланыСчетов._ДемоОсновной.ТоварыНаСкладах;
	
	Движение.СубконтоДт.Контрагенты  = Контрагент;
	Движение.СубконтоДт.Номенклатура = СтрокаТовара.Номенклатура;
	Движение.СубконтоДт.Склады       = МестоХранения;
	
	Движение.КоличествоДт = СтрокаТовара.Количество;
	
	Если ВалютныйУчет Тогда
		Движение.СчетКт          = ПланыСчетов._ДемоОсновной.РасчетыСПоставщикамиВал;
		Движение.ВалютаКт        = Валюта;
		Движение.ВалютнаяСуммаКт = ВалютнаяСумма;
	Иначе
		Движение.СчетКт = ПланыСчетов._ДемоОсновной.РасчетыСПоставщиками;
	КонецЕсли;
	
	Движение.СубконтоКт.Контрагенты = Контрагент;
	Движение.СубконтоКт.Договоры    = Договор;
	
	Движение.КоличествоКт = СтрокаТовара.Количество;
	
КонецПроцедуры

Процедура СформироватьДвижениеУчетаВходящегоНДСПоРегиструОсновной(Знач СтрокаТовара)
	
	РублеваяСумма = СтрокаТовара.Цена * СтрокаТовара.Количество;
	СуммаНДС = РублеваяСумма / 100 * СтавкаНДС.Ставка;
	
	Движение = Движения._ДемоЖурналПроводокБухгалтерскогоУчета.Добавить();
	Движение.Период      = Дата;
	Движение.Организация = Организация;
	Движение.Содержание  = НСтр("ru = 'Поступление товаров'");
	Движение.Сумма       = СуммаНДС;
	
	Движение.СчетДт = ПланыСчетов._ДемоОсновной.НДСПоПриобретеннымМПЗ;
	Движение.СубконтоДт.Контрагенты = Контрагент;
	
	Движение.СчетКт = ПланыСчетов._ДемоОсновной.РасчетыСПоставщиками;
	Движение.СубконтоКт.Контрагенты = Контрагент;
	Движение.СубконтоКт.Договоры    = Договор;
	
КонецПроцедуры

Процедура СформироватьДвижениеПоступленияТовараПоРегиструОсновнойБезКорреспонденции(Знач СтрокаТовара, Знач ВалютныйУчет, Знач ВалютаДокумента)
	
	ВалютнаяСумма = СтрокаТовара.Цена * СтрокаТовара.Количество;
	РублеваяСумма = ВалютнаяСумма * ВалютаДокумента.Курс / ВалютаДокумента.Кратность;
	
	Движение = Движения._ДемоЖурналПроводокБухгалтерскогоУчетаБезКорреспонденции.Добавить();
	Движение.Период      = Дата;
	Движение.Организация = Организация;
	Движение.Содержание  = НСтр("ru = 'Поступление товаров'");
	Движение.Сумма       = РублеваяСумма;	
	Движение.Счет = ПланыСчетов._ДемоОсновной.ТоварыНаСкладах;	
	Движение.Субконто.Контрагенты  = Контрагент;
	Движение.Субконто.Номенклатура = СтрокаТовара.Номенклатура;
	Движение.Субконто.Склады       = МестоХранения;	
	Движение.Количество = СтрокаТовара.Количество;
		
	Движение = Движения._ДемоЖурналПроводокБухгалтерскогоУчетаБезКорреспонденции.Добавить();
	Движение.Период      = Дата;
	Движение.Организация = Организация;
	Движение.Содержание  = НСтр("ru = 'Поступление товаров'");
	Движение.Сумма       = РублеваяСумма;	
	
	Если ВалютныйУчет Тогда
		Движение.Счет          = ПланыСчетов._ДемоОсновной.РасчетыСПоставщикамиВал;
		Движение.Валюта        = Валюта;
		Движение.ВалютнаяСумма = ВалютнаяСумма;
	Иначе
		Движение.Счет = ПланыСчетов._ДемоОсновной.РасчетыСПоставщиками;
	КонецЕсли;
	
	Движение.Субконто.Контрагенты = Контрагент;
	Движение.Субконто.Договоры    = Договор;
	
	Движение.Количество = СтрокаТовара.Количество; 
		
КонецПроцедуры

Процедура СформироватьДвижениеУчетаВходящегоНДСПоРегиструОсновнойБезКорреспонденции(Знач СтрокаТовара)
	
	РублеваяСумма = СтрокаТовара.Цена * СтрокаТовара.Количество;
	СуммаНДС = РублеваяСумма / 100 * СтавкаНДС.Ставка;
	
	Движение = Движения._ДемоЖурналПроводокБухгалтерскогоУчетаБезКорреспонденции.Добавить();
	Движение.Период      = Дата;
	Движение.Организация = Организация;
	Движение.Содержание  = НСтр("ru = 'Поступление товаров'");
	Движение.Сумма       = СуммаНДС;
	Движение.Счет = ПланыСчетов._ДемоОсновной.НДСПоПриобретеннымМПЗ;
	Движение.Субконто.Контрагенты = Контрагент;      
	
	Движение = Движения._ДемоЖурналПроводокБухгалтерскогоУчетаБезКорреспонденции.Добавить();
	Движение.Период      = Дата;
	Движение.Организация = Организация;
	Движение.Содержание  = НСтр("ru = 'Поступление товаров'");
	Движение.Сумма       = СуммаНДС;	
	Движение.Счет = ПланыСчетов._ДемоОсновной.РасчетыСПоставщиками;
	Движение.Субконто.Контрагенты = Контрагент;
	Движение.Субконто.Договоры    = Договор;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли