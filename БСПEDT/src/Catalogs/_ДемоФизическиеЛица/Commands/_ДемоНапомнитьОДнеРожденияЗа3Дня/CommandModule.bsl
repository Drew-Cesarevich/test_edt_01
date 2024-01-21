///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ТекстНапоминания = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'День рождения сотрудника: %1'"), Строка(ПараметрКоманды));
	НапоминанияПользователяКлиент.НапомнитьОЕжегодномСобытииПредмета(
		ТекстНапоминания,
		60*60*24*3,
		ПараметрКоманды,
		"ДатаРождения");
		
	ПоказатьОповещениеПользователя(НСтр("ru = 'Создано напоминание:'"), , ТекстНапоминания, БиблиотекаКартинок.Информация32);
КонецПроцедуры

#КонецОбласти

