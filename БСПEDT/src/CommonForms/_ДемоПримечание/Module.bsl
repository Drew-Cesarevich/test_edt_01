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
	
	Если ТипЗнч(Параметры.ПараметрыПодключаемыхКоманд) = Тип("Структура") 
		И Параметры.ПараметрыПодключаемыхКоманд.Свойство("Примечание") Тогда
			ПараметрыПримечание = Параметры.ПараметрыПодключаемыхКоманд; // см. ПараметрыПримечание
		Примечание = ПараметрыПримечание.Примечание;
	КонецЕсли;
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиФормы.Авто;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаОК(Команда)
	
	Если ВладелецФормы <> Неопределено Тогда
		ПараметрыПримечание = ПараметрыПримечание();
		ПараметрыПримечание.Примечание = Примечание; 
		ВладелецФормы.ПараметрыПодключаемыхКоманд.Вставить("Примечание", ПараметрыПримечание.Примечание);
	КонецЕсли;
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращаемое значение:
//  Структура:
//    * Примечание - Строка
//
&НаКлиентеНаСервереБезКонтекста
Функция ПараметрыПримечание()
	
	Возврат Новый Структура ("Примечание", "");
	
КонецФункции	 

#КонецОбласти