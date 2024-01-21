///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Определяет состав программного интерфейса для вызова из кода конфигурации.
//
// Параметры:
//  НастройкиПрограммногоИнтерфейса - Структура:
//   * ДобавитьКомандыПечати - Булево
//   * Размещение - Массив
//
Процедура ПриОпределенииНастроек(НастройкиПрограммногоИнтерфейса) Экспорт
	
	НастройкиПрограммногоИнтерфейса.Размещение.Добавить(Метаданные.Документы._ДемоЗаказПокупателя);
	НастройкиПрограммногоИнтерфейса.Размещение.Добавить(Метаданные.Документы._ДемоСчетНаОплатуПокупателю);
	НастройкиПрограммногоИнтерфейса.Размещение.Добавить(Метаданные.Документы._ДемоРеализацияТоваров);
	
	НастройкиПрограммногоИнтерфейса.ДобавитьКомандыПечати = Истина;
	
КонецПроцедуры

// Заполняет список команд печати.
// 
// Параметры:
//  КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.МенеджерПечати = "УправлениеПечатью";
	КомандаПечати.Идентификатор = "Обработка._ДемоПечатьДоговораКуплиПродажи.ПФ_MXL_ДоговорКуплиПродажи";
	КомандаПечати.Представление = НСтр("ru = 'Договор купли-продажи (общий макет)'");

КонецПроцедуры

#КонецОбласти

#КонецЕсли
