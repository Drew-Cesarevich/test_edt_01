///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(МассивРассылок, ПараметрыВыполненияКоманды)
	Если ТипЗнч(МассивРассылок) <> Тип("Массив") ИЛИ МассивРассылок.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Форма = ПараметрыВыполненияКоманды.Источник;
	
	ПараметрыЗапуска = Новый Структура("МассивРассылок, Форма, ЭтоФормаЭлемента");
	ПараметрыЗапуска.МассивРассылок = МассивРассылок;
	ПараметрыЗапуска.Форма = Форма;
	ПараметрыЗапуска.ЭтоФормаЭлемента = (Форма.ИмяФормы = "Справочник.РассылкиОтчетов.Форма.ФормаЭлемента");
	
	РассылкаОтчетовКлиент.ВыполнитьСейчас(ПараметрыЗапуска);
КонецПроцедуры

#КонецОбласти
