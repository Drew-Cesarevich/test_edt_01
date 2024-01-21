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

// СтандартныеПодсистемы.УправлениеДоступом

// Параметры:
//   Ограничение - см. УправлениеДоступомПереопределяемый.ПриЗаполненииОграниченияДоступа.Ограничение.
//
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	// АПК:336-выкл - №737.3 проверка по ролям, так как право есть всегда.
	Ограничение.Текст =
	"РазрешитьЧтение
	|ГДЕ
	|	  (    РольДоступна(ЧтениеДатЗапретаИзменения)
	|	   ИЛИ РольДоступна(ДобавлениеИзменениеДатЗапретаИзменения))
	|	И (    ТИПЗНАЧЕНИЯ(Пользователь) = ТИП(Справочник.Пользователи)
	|	   ИЛИ ТИПЗНАЧЕНИЯ(Пользователь) = ТИП(Справочник.ГруппыПользователей)
	|	   ИЛИ ТИПЗНАЧЕНИЯ(Пользователь) = ТИП(Справочник.ВнешниеПользователи)
	|	   ИЛИ ТИПЗНАЧЕНИЯ(Пользователь) = ТИП(Справочник.ГруппыВнешнихПользователей)
	|	   ИЛИ Пользователь = ЗНАЧЕНИЕ(Перечисление.ВидыНазначенияДатЗапрета.ДляВсехПользователей))
	|	ИЛИ
	|	  (    РольДоступна(ЧтениеДатЗапретаЗагрузки)
	|	   ИЛИ РольДоступна(ДобавлениеИзменениеДатЗапретаЗагрузки))
	|	И ТИПЗНАЧЕНИЯ(Пользователь) <> ТИП(Справочник.Пользователи)
	|	И ТИПЗНАЧЕНИЯ(Пользователь) <> ТИП(Справочник.ГруппыПользователей)
	|	И ТИПЗНАЧЕНИЯ(Пользователь) <> ТИП(Справочник.ВнешниеПользователи)
	|	И ТИПЗНАЧЕНИЯ(Пользователь) <> ТИП(Справочник.ГруппыВнешнихПользователей)
	|	И Пользователь <> НЕОПРЕДЕЛЕНО
	|	И Пользователь <> ЗНАЧЕНИЕ(Перечисление.ВидыНазначенияДатЗапрета.ПустаяСсылка)
	|	И Пользователь <> ЗНАЧЕНИЕ(Перечисление.ВидыНазначенияДатЗапрета.ДляВсехПользователей)
	|;
	|РазрешитьИзменениеЕслиРазрешеноЧтение
	|ГДЕ
	|	  РольДоступна(ДобавлениеИзменениеДатЗапретаИзменения)
	|	И (    ТИПЗНАЧЕНИЯ(Пользователь) = ТИП(Справочник.Пользователи)
	|	   ИЛИ ТИПЗНАЧЕНИЯ(Пользователь) = ТИП(Справочник.ГруппыПользователей)
	|	   ИЛИ ТИПЗНАЧЕНИЯ(Пользователь) = ТИП(Справочник.ВнешниеПользователи)
	|	   ИЛИ ТИПЗНАЧЕНИЯ(Пользователь) = ТИП(Справочник.ГруппыВнешнихПользователей)
	|	   ИЛИ Пользователь = ЗНАЧЕНИЕ(Перечисление.ВидыНазначенияДатЗапрета.ДляВсехПользователей))
	|	ИЛИ
	|	  РольДоступна(ДобавлениеИзменениеДатЗапретаЗагрузки)
	|	И ТИПЗНАЧЕНИЯ(Пользователь) <> ТИП(Справочник.Пользователи)
	|	И ТИПЗНАЧЕНИЯ(Пользователь) <> ТИП(Справочник.ГруппыПользователей)
	|	И ТИПЗНАЧЕНИЯ(Пользователь) <> ТИП(Справочник.ВнешниеПользователи)
	|	И ТИПЗНАЧЕНИЯ(Пользователь) <> ТИП(Справочник.ГруппыВнешнихПользователей)
	|	И Пользователь <> НЕОПРЕДЕЛЕНО
	|	И Пользователь <> ЗНАЧЕНИЕ(Перечисление.ВидыНазначенияДатЗапрета.ПустаяСсылка)
	|	И Пользователь <> ЗНАЧЕНИЕ(Перечисление.ВидыНазначенияДатЗапрета.ДляВсехПользователей)";
	// АПК:336-вкл
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#КонецЕсли
