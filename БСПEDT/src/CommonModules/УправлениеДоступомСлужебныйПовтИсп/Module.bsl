///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// См. Справочники.ПрофилиГруппДоступа.ПояснениеПоставляемыхПрофилей
Функция ПояснениеПоставляемыхПрофилей() Экспорт
	
	Возврат Справочники.ПрофилиГруппДоступа.ПояснениеПоставляемыхПрофилей();
	
КонецФункции

// См. УправлениеДоступомСлужебный.ПостоянныеВидыОграниченийПравОбъектовМетаданных
Функция ПостоянныеВидыОграниченийПравОбъектовМетаданных(ДляПроверки = Ложь) Экспорт
	
	Возврат УправлениеДоступомСлужебный.ПостоянныеВидыОграниченийПравОбъектовМетаданных(ДляПроверки);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Только для внутреннего использования.
//
// Возвращаемое значение:
//  ФиксированнаяСтруктура:
//    * СвойстваСеанса - см. УправлениеДоступомСлужебный.СвойстваВидовДоступа
//    * ХешСуммы       - см. УправлениеДоступомСлужебный.ХешСуммыСвойствВидовДоступа
//    * Проверка       - Структура:
//        ** Дата - Дата
// 
Функция ОписаниеСвойствВидовДоступаСеанса() Экспорт
	
	СвойстваСеанса = УправлениеДоступомСлужебный.ПроверенныеСвойстваВидовДоступаСеанса();
	ХешСуммы = УправлениеДоступомСлужебный.ХешСуммыСвойствВидовДоступа(СвойстваСеанса);
	
	Результат = Новый Структура;
	Результат.Вставить("СвойстваСеанса", СвойстваСеанса);
	Результат.Вставить("ХешСуммы", ХешСуммы);
	Результат.Вставить("Проверка", Новый Структура("Дата", '00010101'));
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
	
КонецФункции

// См. УправлениеДоступомСлужебный.ПредставлениеВидовДоступа
Функция ПредставлениеВидовДоступа() Экспорт
	
	Возврат УправлениеДоступомСлужебный.ПредставлениеВидовДоступа();
	
КонецФункции

// Только для внутреннего использования.
//
// Возвращаемое значение:
//  ФиксированнаяСтруктура:
//    * ВозможныеПраваСеанса - см. УправлениеДоступомСлужебный.ВозможныеПраваДляНастройкиПравОбъектов
//    * ХешСумма             - Строка
//    * Проверка             - Структура:
//        ** Дата - Дата
// 
Функция ОписаниеВозможныхПравСеансаДляНастройкиПравОбъектов() Экспорт
	
	ВозможныеПраваСеанса = РегистрыСведений.НастройкиПравОбъектов.ПроверенныеВозможныеПраваСеанса();
	ХешСумма = РегистрыСведений.НастройкиПравОбъектов.ХешСуммаВозможныхПрав(ВозможныеПраваСеанса);
	
	Результат = Новый Структура;
	Результат.Вставить("ВозможныеПраваСеанса", ВозможныеПраваСеанса);
	Результат.Вставить("ХешСумма", ХешСумма);
	Результат.Вставить("Проверка", Новый Структура("Дата", '00010101'));
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
	
КонецФункции

// См. РегистрыСведений.НастройкиПравОбъектов.ПредставлениеВозможныхПрав
Функция ПредставлениеВозможныхПрав() Экспорт
	
	Возврат РегистрыСведений.НастройкиПравОбъектов.ПредставлениеВозможныхПрав();
	
КонецФункции

// Только для внутреннего использования.
//
// Возвращаемое значение:
//  ФиксированнаяСтруктура:
//    * ПоставляемыеПрофилиСеанса - см. УправлениеДоступомСлужебный.ПоставляемыеПрофили
//    * ХешСумма                  - Строка
//    * Проверка                  - Структура:
//        ** Дата - Дата
// 
Функция ОписаниеПоставляемыхПрофилейСеанса() Экспорт
	
	ПоставляемыеПрофилиСеанса = Справочники.ПрофилиГруппДоступа.ПроверенныеПоставляемыеПрофилиСеанса();
	ХешСумма = Справочники.ПрофилиГруппДоступа.ХешСуммаПоставляемыхПрофилей(ПоставляемыеПрофилиСеанса);
	
	Результат = Новый Структура;
	Результат.Вставить("ПоставляемыеПрофилиСеанса", ПоставляемыеПрофилиСеанса);
	Результат.Вставить("ХешСумма", ХешСумма);
	Результат.Вставить("Проверка", Новый Структура("Дата", '00010101'));
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
	
КонецФункции

// Только для внутреннего использования.
//
// Возвращаемое значение:
//  ФиксированнаяСтруктура:
//    * РолиСеанса - см. УправлениеДоступомСлужебный.СтандартныеРолиРасширений
//    * ХешСумма   - Строка
//    * Проверка   - Структура:
//        ** Дата - Дата
// 
Функция ОписаниеСтандартныхРолейРасширенийСеанса() Экспорт
	
	РолиСеанса = Справочники.ПрофилиГруппДоступа.ПодготовленныеСтандартныеРолиРасширенийСеанса();
	ХешСумма = Справочники.ПрофилиГруппДоступа.ХешСуммаСтандартныхРолейРасширений(РолиСеанса);
	
	Результат = Новый Структура;
	Результат.Вставить("РолиСеанса", РолиСеанса);
	Результат.Вставить("ХешСумма", ХешСумма);
	Результат.Вставить("Проверка", Новый Структура("Дата", '00010101'));
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
	
КонецФункции

// Возвращаемое значение:
//  Структура:
//   * ХешСумма - Строка
//   * ИдентификаторыРолей - ФиксированноеСоответствие из КлючИЗначение:
//       ** Ключ - СправочникСсылка.ИдентификаторыОбъектовМетаданных
//               - СправочникСсылка.ИдентификаторыОбъектовРасширений
//       ** Значение - Булево - Истина
//
Функция ИдентификаторыРолейСеанса() Экспорт
	
	ПолныеИменаРолей = Новый Массив;
	Для каждого Роль Из Метаданные.Роли Цикл
		ПолныеИменаРолей.Добавить(Роль.ПолноеИмя());
	КонецЦикла;
	ОписаниеИдентификаторовРолей = ОбщегоНазначения.ИдентификаторыОбъектовМетаданных(ПолныеИменаРолей);
	Список = Новый СписокЗначений;
	ИдентификаторыРолей = Новый Соответствие;
	Для Каждого ОписаниеИдентификатораРоли Из ОписаниеИдентификаторовРолей Цикл
		Список.Добавить(ОписаниеИдентификатораРоли.Значение.УникальныйИдентификатор());
		ИдентификаторыРолей.Вставить(ОписаниеИдентификатораРоли.Значение, Истина);
	КонецЦикла;
	Список.СортироватьПоЗначению();
	
	Хеширование = Новый ХешированиеДанных(ХешФункция.SHA256);
	Хеширование.Добавить(ЗначениеВСтрокуВнутр(Список.ВыгрузитьЗначения()));
	ХешСумма = Base64Строка(Хеширование.ХешСумма);
	
	Результат = Новый Структура;
	Результат.Вставить("ХешСумма", ХешСумма);
	Результат.Вставить("ИдентификаторыРолей", Новый ФиксированноеСоответствие(ИдентификаторыРолей));
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
	
КонецФункции

// Только для внутреннего использования.
//
//  Возвращаемое значение:
//    Строка
//
Функция ОписаниеКлючаЗаписи(ТипИлиПолноеИмя) Экспорт
	
	ОписаниеКлюча = Новый Структура("МассивПолей, СтрокаПолей", Новый Массив, "");
	
	Если ТипЗнч(ТипИлиПолноеИмя) = Тип("Тип") Тогда
		ОбъектМетаданных = Метаданные.НайтиПоТипу(ТипИлиПолноеИмя);
	Иначе
		ОбъектМетаданных = ОбщегоНазначения.ОбъектМетаданныхПоПолномуИмени(ТипИлиПолноеИмя);
	КонецЕсли;
	Менеджер = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ОбъектМетаданных.ПолноеИмя());
	
	ВсеПоля = Новый Массив;
	Для Каждого Колонка Из Менеджер.СоздатьНаборЗаписей().Выгрузить().Колонки Цикл
		ВсеПоля.Добавить(Колонка.Имя);
	КонецЦикла;
	
	ПустойКлючЗаписи = Менеджер.СоздатьКлючЗаписи(Новый Структура(СтрСоединить(ВсеПоля, ",")));
	Для Каждого Поле Из ВсеПоля Цикл
		ОдноПоле = Новый Структура(Поле, Null);
		ЗаполнитьЗначенияСвойств(ОдноПоле, ПустойКлючЗаписи);
		Если ОдноПоле[Поле] = Null Тогда
			Продолжить;
		КонецЕсли;
		ОписаниеКлюча.МассивПолей.Добавить(Поле);
	КонецЦикла;
	
	ОписаниеКлюча.СтрокаПолей = СтрСоединить(ОписаниеКлюча.МассивПолей, ",");
	
	Возврат ОбщегоНазначения.ФиксированныеДанные(ОписаниеКлюча);
	
КонецФункции

// Только для внутреннего использования.
//
// Возвращаемое значение:
//  ФиксированноеСоответствие из КлючИЗначение:
//    * Ключ - Тип
//    * Значение - Булево - Истина
//
Функция ТипыПоляТаблицы(ПолноеИмяПоля) Экспорт
	
	ОбъектМетаданных = ОбщегоНазначения.ОбъектМетаданныхПоПолномуИмени(ПолноеИмяПоля);
	МассивТипов = ОбъектМетаданных.Тип.Типы();
	ТипИдентификатора = Тип("СправочникОбъект.ИдентификаторыОбъектовМетаданных");
	
	ТипыПоля = Новый Соответствие;
	Для каждого Тип Из МассивТипов Цикл
		Если Тип = ТипИдентификатора Тогда
			Продолжить;
		КонецЕсли;
		ТипыПоля.Вставить(Тип, Истина);
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(ТипыПоля);
	
КонецФункции

// Возвращает типы объектов и ссылок в указанных подписках на события.
// 
// Параметры:
//  ИменаПодписок - Строка - многострочная строка, содержащая
//                  строки начала имени подписки.
//
// Возвращаемое значение:
//  ФиксированноеСоответствие из КлючИЗначение:
//    * Ключ - Тип
//    * Значение - Булево
//
Функция ТипыОбъектовВПодпискахНаСобытия(ИменаПодписок) Экспорт
	
	ТипИдентификатора = Тип("СправочникОбъект.ИдентификаторыОбъектовМетаданных");
	ТипыОбъектов = Новый Соответствие;
	
	Для Каждого Подписка Из Метаданные.ПодпискиНаСобытия Цикл
		
		Для НомерСтроки = 1 По СтрЧислоСтрок(ИменаПодписок) Цикл
			ИмяПодписки = СтрПолучитьСтроку(ИменаПодписок, НомерСтроки);
			
			Если ВРег(Подписка.Имя) = ВРег(ИмяПодписки) Тогда
				
				Типы = Подписка.Источник.Типы();
				Для Каждого Тип Из Типы Цикл
					Если Тип = ТипИдентификатора Тогда
						Продолжить;
					КонецЕсли;
					ТипыОбъектов.Вставить(Тип, Истина);
				КонецЦикла;
			КонецЕсли;
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(ТипыОбъектов);
	
КонецФункции

// Только для внутреннего использования.
//
// Возвращаемое значение:
//   ХранилищеЗначения
//
Функция ТаблицаПустогоНабораЗаписей(ПолноеИмяРегистра) Экспорт
	
	Менеджер = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ПолноеИмяРегистра);
	
	Возврат Новый ХранилищеЗначения(Менеджер.СоздатьНаборЗаписей().Выгрузить());
	
КонецФункции

// Только для внутреннего использования.
//
// Возвращаемое значение:
//   ХранилищеЗначения - содержит тип ТаблицаЗначений
//
Функция ТаблицаПустыхСсылокУказанныхТипов(ПолноеИмяРеквизита) Экспорт
	
	ОписаниеТипов = ОбщегоНазначения.ОбъектМетаданныхПоПолномуИмени(ПолноеИмяРеквизита).Тип;
	
	ПустыеСсылки = Новый ТаблицаЗначений;
	ПустыеСсылки.Колонки.Добавить("ПустаяСсылка", ОписаниеТипов);
	
	Для каждого ТипЗначения Из ОписаниеТипов.Типы() Цикл
		Если ОбщегоНазначения.ЭтоСсылка(ТипЗначения) Тогда
			ПустыеСсылки.Добавить().ПустаяСсылка = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(
				Метаданные.НайтиПоТипу(ТипЗначения).ПолноеИмя()).ПустаяСсылка();
		КонецЕсли;
	КонецЦикла;
	
	Возврат Новый ХранилищеЗначения(ПустыеСсылки);
	
КонецФункции

// Только для внутреннего использования.
//
// Возвращаемое значение:
//   ФиксированноеСоответствие из КлючИЗначение:
//     * Ключ - Тип
//     * Значение - ЛюбаяСсылка
//
Функция СоответствиеПустыхСсылокУказаннымТипамСсылок(ПолноеИмяРеквизита) Экспорт
	
	ОписаниеТипов = ОбщегоНазначения.ОбъектМетаданныхПоПолномуИмени(ПолноеИмяРеквизита).Тип;
	
	ПустыеСсылки = Новый Соответствие;
	
	Для каждого ТипЗначения Из ОписаниеТипов.Типы() Цикл
		Если ОбщегоНазначения.ЭтоСсылка(ТипЗначения) Тогда
			ПустыеСсылки.Вставить(ТипЗначения, ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(
				Метаданные.НайтиПоТипу(ТипЗначения).ПолноеИмя()).ПустаяСсылка() );
		КонецЕсли;
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(ПустыеСсылки);
	
КонецФункции

// Только для внутреннего использования.
//
// Возвращаемое значение:
//   ФиксированноеСоответствие из КлючИЗначение:
//     * Ключ - Тип
//     * Значение - Строка
//
Функция КодыТиповСсылок(ПолноеИмяРеквизита) Экспорт
	
	ОписаниеТипов = ОбщегоНазначения.ОбъектМетаданныхПоПолномуИмени(ПолноеИмяРеквизита).Тип;
	
	ЧисловыеКодыТипов = Новый Соответствие;
	ТекущийКод = 0;
	
	Для каждого ТипЗначения Из ОписаниеТипов.Типы() Цикл
		Если ОбщегоНазначения.ЭтоСсылка(ТипЗначения) Тогда
			ЧисловыеКодыТипов.Вставить(ТипЗначения, ТекущийКод);
		КонецЕсли;
		ТекущийКод = ТекущийКод + 1;
	КонецЦикла;
	
	СтроковыеКодыТипов = Новый Соответствие;
	
	ДлинаСтроковогоКода = СтрДлина(Формат(ТекущийКод-1, "ЧН=0; ЧГ="));
	ФорматнаяСтрокаКода = "ЧЦ=" + Формат(ДлинаСтроковогоКода, "ЧН=0; ЧГ=") + "; ЧН=0; ЧВН=; ЧГ=";
	
	Для каждого КлючИЗначение Из ЧисловыеКодыТипов Цикл
		СтроковыеКодыТипов.Вставить(
			КлючИЗначение.Ключ,
			Формат(КлючИЗначение.Значение, ФорматнаяСтрокаКода));
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(СтроковыеКодыТипов);
	
КонецФункции

// Только для внутреннего использования.
//
// Возвращаемое значение:
//   ФиксированноеСоответствие из КлючИЗначение:
//     * Ключ - Тип
//     * Значение - Строка
//
Функция КодыПеречислений() Экспорт
	
	КодыПеречислений = Новый Соответствие;
	
	Для каждого ТипЗначенияДоступа Из Метаданные.ОпределяемыеТипы.ЗначениеДоступа.Тип.Типы() Цикл
		МетаданныеТипа = Метаданные.НайтиПоТипу(ТипЗначенияДоступа); // ОбъектМетаданныхПеречисление
		Если МетаданныеТипа = Неопределено ИЛИ НЕ Метаданные.Перечисления.Содержит(МетаданныеТипа) Тогда
			Продолжить;
		КонецЕсли;
		Для каждого ЗначениеПеречисления Из МетаданныеТипа.ЗначенияПеречисления Цикл
			ИмяЗначения = ЗначениеПеречисления.Имя;
			КодыПеречислений.Вставить(Перечисления[МетаданныеТипа.Имя][ИмяЗначения], ИмяЗначения);
		КонецЦикла;
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(КодыПеречислений);
	
КонецФункции

// См. УправлениеДоступомСлужебный.ТипыГруппИЗначенийВидовДоступа
Функция ТипыГруппИЗначенийВидовДоступа() Экспорт
	
	Возврат УправлениеДоступомСлужебный.ТипыГруппИЗначенийВидовДоступа();
	
КонецФункции

// Только для внутреннего использования.
//
// Возвращаемое значение:
//  ОписаниеТипов
//
Функция ОписаниеТиповЗначенийДоступаИВладельцевНастроекПрав() Экспорт
	
	Типы = Новый Массив;
	Для Каждого Тип Из Метаданные.ОпределяемыеТипы.ЗначениеДоступа.Тип.Типы() Цикл
		Типы.Добавить(Тип);
	КонецЦикла;
	
	Для Каждого Тип Из Метаданные.ОпределяемыеТипы.ВладелецНастроекПрав.Тип.Типы() Цикл
		Если Тип = Тип("Строка") Тогда
			Продолжить;
		КонецЕсли;
		Типы.Добавить(Тип);
	КонецЦикла;
	
	Возврат Новый ОписаниеТипов(Типы);
	
КонецФункции

// Смотри также УправлениеДоступомСлужебный.ТипыЗначенийВидовДоступаИВладельцевНастроекПрав()
//
// Возвращаемое значение:
//   ХранилищеЗначения
//
Функция ТипыЗначенийВидовДоступаИВладельцевНастроекПрав() Экспорт
	
	Возврат Новый ХранилищеЗначения(УправлениеДоступомСлужебный.ТипыЗначенийВидовДоступаИВладельцевНастроекПрав());
	
КонецФункции

// Только для внутреннего использования.
//
// Возвращаемое значение:
//  Структура:
//    * ДатаОбновления - Дата
//    * Таблица - ТаблицаЗначений:
//        ** Таблица - СправочникСсылка.ИдентификаторыОбъектовМетаданных
//                   - СправочникСсылка.ИдентификаторыОбъектовРасширений
//        ** Право - Строка - имя права
//        ** ВидДоступа - СправочникСсылка
//        ** Представление - Строка - представление вида доступа
//
Функция ВидыОграниченийПравОбъектовМетаданных() Экспорт
	
	Возврат Новый Структура("ДатаОбновления, Таблица", '00010101');
	
КонецФункции

// Только для внутреннего использования.
//
// Возвращаемое значение:
//  Булево
//
Функция КонстантаОграничиватьДоступНаУровнеЗаписей() Экспорт
	
	Возврат Константы.ОграничиватьДоступНаУровнеЗаписей.Получить();
	
КонецФункции

#Область УниверсальноеОграничение

// Возвращаемое значение:
//  Булево
//
Функция КонстантаОграничиватьДоступНаУровнеЗаписейУниверсально() Экспорт
	
	Возврат УправлениеДоступомСлужебный.КонстантаОграничиватьДоступНаУровнеЗаписейУниверсально();
	
КонецФункции

// Возвращаемое значение:
//   ФиксированноеСоответствие из КлючИЗначение:
//     * Ключ - Тип
//     * Значение - Массив из СправочникСсылка
//
Функция ПустыеСсылкиТиповЗначенийДоступаПоТипамГруппИЗначений() Экспорт
	
	СвойстваВидовДоступа = УправлениеДоступомСлужебный.СвойстваВидовДоступа();
	ПустыеСсылки = Новый Соответствие;
	
	Для Каждого Свойства Из СвойстваВидовДоступа.Массив Цикл
		ДобавитьПустуюСсылкуТипаЗначений(ПустыеСсылки, Свойства.ТипЗначений,      Свойства.ТипЗначений);
		ДобавитьПустуюСсылкуТипаЗначений(ПустыеСсылки, Свойства.ТипГруппЗначений, Свойства.ТипЗначений);
		Для Каждого Описание Из Свойства.ДополнительныеТипы Цикл
			ДобавитьПустуюСсылкуТипаЗначений(ПустыеСсылки, Описание.ТипЗначений,      Описание.ТипЗначений);
			ДобавитьПустуюСсылкуТипаЗначений(ПустыеСсылки, Описание.ТипГруппЗначений, Описание.ТипЗначений);
		КонецЦикла;
	КонецЦикла;
	
	ТипГруппПользователей = Тип("СправочникСсылка.ГруппыПользователей");
	ДобавитьПустуюСсылкуТипаЗначений(ПустыеСсылки, ТипГруппПользователей, ТипГруппПользователей);
	
	ТипГруппВнешнихПользователей = Тип("СправочникСсылка.ГруппыВнешнихПользователей");
	ДобавитьПустуюСсылкуТипаЗначений(ПустыеСсылки, ТипГруппВнешнихПользователей, ТипГруппВнешнихПользователей);
	
	Свойства = СвойстваВидовДоступа.ПоИменам.Получить("Пользователи");
	Для Каждого Описание Из Свойства.ДополнительныеТипы Цикл
		ДобавитьПустуюСсылкуТипаЗначений(ПустыеСсылки, ТипГруппПользователей, Описание.ТипЗначений);
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(ПустыеСсылки);
	
КонецФункции

// Возвращаемое значение:
//   ФиксированноеСоответствие из КлючИЗначение:
//     * Ключ - Тип
//     * Значение - Булево
//
Функция ТиповСсылокВедущихОбъектов() Экспорт
	
	Типы = Новый Соответствие;
	ДобавитьТипы(Типы, Справочники.ТипВсеСсылки().Типы());
	ДобавитьТипы(Типы, Документы.ТипВсеСсылки().Типы());
	ДобавитьТипы(Типы, ПланыВидовХарактеристик.ТипВсеСсылки().Типы());
	ДобавитьТипы(Типы, ПланыСчетов.ТипВсеСсылки().Типы());
	ДобавитьТипы(Типы, ПланыВидовРасчета.ТипВсеСсылки().Типы());
	ДобавитьТипы(Типы, БизнесПроцессы.ТипВсеСсылки().Типы());
	ДобавитьТипы(Типы, Задачи.ТипВсеСсылки().Типы());
	ДобавитьТипы(Типы, ПланыОбмена.ТипВсеСсылки().Типы());
	
	Возврат Новый ФиксированноеСоответствие(Типы);
	
КонецФункции

// Возвращаемое значение:
//   ОписаниеТипов
//
Функция ОписаниеТиповСсылокДопустимыхОбъектов() Экспорт
	
	ОписаниеТипов = Новый ОписаниеТипов(ПланыОбмена.ТипВсеСсылки());
	ОписаниеТипов = Новый ОписаниеТипов(ОписаниеТипов, Справочники.ТипВсеСсылки().Типы());
	ОписаниеТипов = Новый ОписаниеТипов(ОписаниеТипов, Документы.ТипВсеСсылки().Типы());
	ОписаниеТипов = Новый ОписаниеТипов(ОписаниеТипов, ПланыВидовХарактеристик.ТипВсеСсылки().Типы());
	ОписаниеТипов = Новый ОписаниеТипов(ОписаниеТипов, ПланыСчетов.ТипВсеСсылки().Типы());
	ОписаниеТипов = Новый ОписаниеТипов(ОписаниеТипов, ПланыВидовРасчета.ТипВсеСсылки().Типы());
	ОписаниеТипов = Новый ОписаниеТипов(ОписаниеТипов, БизнесПроцессы.ТипВсеСсылки().Типы());
	ОписаниеТипов = Новый ОписаниеТипов(ОписаниеТипов, Задачи.ТипВсеСсылки().Типы());
	ОписаниеТипов = Новый ОписаниеТипов(ОписаниеТипов,, "СправочникСсылка.НаборыГруппДоступа");
	
	Возврат ОписаниеТипов;
	
КонецФункции

// См. УправлениеДоступомСлужебный.НовыйКэшПараметровОграничения
Функция КэшПараметровОграничения(КлючДанныхПовторногоИспользования) Экспорт
	
	Возврат УправлениеДоступомСлужебный.НовыйКэшПараметровОграничения();
	
КонецФункции

// Возвращаемое значение:
//  Структура:
//   * ДляПользователей        - см. УправлениеДоступомСлужебный.КэшРасчетаПравДляВидаПользователей
//   * ДляВнешнихПользователей - см. УправлениеДоступомСлужебный.КэшРасчетаПравДляВидаПользователей
//   * ВерсияДанных            - см. УправлениеДоступомСлужебный.НоваяВерсияДанныхДляКэшаРасчетаПрав
// 
Функция КэшРасчетаПрав(КлючДанныхПовторногоИспользования) Экспорт
	
	Свойства = "ПраваГруппДоступаСписков, ЗначенияГруппДоступа, ПользователиГруппПользователей,
		|УчастникиГруппДоступа, ГруппыПользователейГруппДоступа, ГруппыПользователейКакЗначенияДоступа,
		|РолиПрофилейГруппДоступа, ГруппыДоступаПрофилей";
	
	ВерсияДанных = УправлениеДоступомСлужебный.НоваяВерсияДанныхДляКэшаРасчетаПрав(
		Строка(Новый УникальныйИдентификатор));
	
	Хранилище = Новый Структура;
	Хранилище.Вставить("ДляПользователей",        Новый Структура(Свойства, Новый Соответствие));
	Хранилище.Вставить("ДляВнешнихПользователей", Новый Структура(Свойства, Новый Соответствие));
	Хранилище.Вставить("ВерсияДанных",            ВерсияДанных);
	
	Возврат Хранилище;
	
КонецФункции

Функция КэшИзмененныхСписковПриОтключенномОбновленииКлючейДоступа() Экспорт
	
	ОтключениеОбновления = ПараметрыСеанса.ОтключениеОбновленияКлючейДоступа; // См. УправлениеДоступомСлужебный.НовоеОтключениеОбновленияКлючейДоступа
	
	Возврат ОтключениеОбновления.ИзмененныеСписки.Получить();
	
КонецФункции

// Возвращаемое значение:
//   ФиксированноеСоответствие из КлючИЗначение:
//     * Ключ     - Строка - полное имя списка (таблицы).
//     * Значение - Булево - Истина - текст ограничения в модуле менеджера,
//                           Ложь   - текст ограничения в этом переопределяемом
//                                    модуле в процедуре ПриЗаполненииОграниченияДоступа.
//
Функция СпискиСОграничением() Экспорт
	
	Списки = Новый Соответствие;
	ИнтеграцияПодсистемБСП.ПриЗаполненииСписковСОграничениемДоступа(Списки);
	УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа(Списки);
	
	СвойстваСписков = Новый Соответствие;
	Для Каждого Список Из Списки Цикл
		ПолноеИмя = Список.Ключ.ПолноеИмя();
		СвойстваСписков.Вставить(ПолноеИмя, Список.Значение);
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(СвойстваСписков);
	
КонецФункции

Функция РазрешенныйКлючДоступа() Экспорт
	
	УстановитьОтключениеБезопасногоРежима(Истина);
	УстановитьПривилегированныйРежим(Истина);
	
	Ссылка = Справочники.КлючиДоступа.ПолучитьСсылку(
		Новый УникальныйИдентификатор("8bfeb2d1-08c3-11e8-bcf8-d017c2abb532"));
	
	СсылкаВБазеДанных = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "Ссылка");
	Если Не ЗначениеЗаполнено(СсылкаВБазеДанных) Тогда
		РазрешенныйКлюч = Справочники.КлючиДоступа.СоздатьЭлемент();
		РазрешенныйКлюч.УстановитьСсылкуНового(Ссылка);
		РазрешенныйКлюч.Наименование = НСтр("ru = 'Разрешенный ключ доступа'");
		
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить("Справочник.КлючиДоступа");
		ЭлементБлокировки.УстановитьЗначение("Ссылка", Ссылка);
		
		НачатьТранзакцию();
		Попытка
			Блокировка.Заблокировать();
			СсылкаВБазеДанных = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "Ссылка");
			Если Не ЗначениеЗаполнено(СсылкаВБазеДанных) Тогда
				РазрешенныйКлюч.Записать();
			КонецЕсли;
			ЗафиксироватьТранзакцию();
		Исключение
			ОтменитьТранзакцию();
			ВызватьИсключение;
		КонецПопытки;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Ложь);
	УстановитьОтключениеБезопасногоРежима(Ложь);
	
	Возврат Ссылка;
	
КонецФункции

Функция РазрешенныйПустойНаборГруппДоступа() Экспорт
	
	УстановитьОтключениеБезопасногоРежима(Истина);
	УстановитьПривилегированныйРежим(Истина);
	
	Ссылка = Справочники.НаборыГруппДоступа.ПолучитьСсылку(
		Новый УникальныйИдентификатор("b5bc5b29-a11d-11e8-8787-b06ebfbf08c7"));
	
	СсылкаВБазеДанных = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "Ссылка");
	Если Не ЗначениеЗаполнено(СсылкаВБазеДанных) Тогда
		РазрешенныйПустойНабор = Справочники.НаборыГруппДоступа.СоздатьЭлемент();
		РазрешенныйПустойНабор.УстановитьСсылкуНового(Ссылка);
		РазрешенныйПустойНабор.Наименование = НСтр("ru = 'Разрешенный пустой набор групп доступа'");
		РазрешенныйПустойНабор.ТипЭлементовНабора = Справочники.ГруппыДоступа.ПустаяСсылка();
		
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить("Справочник.НаборыГруппДоступа");
		ЭлементБлокировки.УстановитьЗначение("Ссылка", Ссылка);
		
		НачатьТранзакцию();
		Попытка
			Блокировка.Заблокировать();
			СсылкаВБазеДанных = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "Ссылка");
			Если Не ЗначениеЗаполнено(СсылкаВБазеДанных) Тогда
				РазрешенныйПустойНабор.Записать();
			КонецЕсли;
			ЗафиксироватьТранзакцию();
		Исключение
			ОтменитьТранзакцию();
			ВызватьИсключение;
		КонецПопытки;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Ложь);
	УстановитьОтключениеБезопасногоРежима(Ложь);
	
	Возврат Ссылка;
	
КонецФункции

Функция РазмерностьКлючаДоступа() Экспорт
	
	МетаданныеКлюча = Метаданные.Справочники.КлючиДоступа;
	
	Если КоличествоПодобныхЭлементовВКоллекции(МетаданныеКлюча.Реквизиты, "Значение") <> 5 Тогда
		ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'В справочнике %1 должно быть 5 реквизитов %2 и не более.'"),
			"КлючиДоступа", "Значение" + "*");
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;
	
	Если МетаданныеКлюча.ТабличныеЧасти.Найти("Шапка") = Неопределено
	 Или КоличествоПодобныхЭлементовВКоллекции(МетаданныеКлюча.ТабличныеЧасти.Шапка.Реквизиты, "Значение", 6) <> 5 Тогда
		ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'В справочнике %1 должна быть табличная часть %2 с 5 реквизитами %3 и не более.'"),
			"КлючиДоступа", "Шапка", "Значение" + "*");
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;
	
	КоличествоТабличныхЧастей = КоличествоПодобныхЭлементовВКоллекции(МетаданныеКлюча.ТабличныеЧасти, "ТабличнаяЧасть");
	Если КоличествоТабличныхЧастей < 1 Или КоличествоТабличныхЧастей > 12 Тогда
		ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'В справочнике %1 должно быть от 1 до 12 табличных частей %2.'"),
			"КлючиДоступа", "ТабличнаяЧасть" + "*");
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;
	
	КоличествоТабличныхЧастей = 0;
	КоличествоРеквизитовТабличнойЧасти = 0;
	Для Каждого ТабличнаяЧасть Из МетаданныеКлюча.ТабличныеЧасти Цикл
		Если Не СтрНачинаетсяС(ТабличнаяЧасть.Имя, "ТабличнаяЧасть") Тогда
			Продолжить;
		КонецЕсли;
		КоличествоТабличныхЧастей = КоличествоТабличныхЧастей + 1;
		Количество = КоличествоПодобныхЭлементовВКоллекции(ТабличнаяЧасть.Реквизиты, "Значение");
		Если Количество < 1 Или Количество > 15 Тогда
			КоличествоРеквизитовТабличнойЧасти = 0;
			Прервать;
		КонецЕсли;
		Если КоличествоРеквизитовТабличнойЧасти <> 0
		   И КоличествоРеквизитовТабличнойЧасти <> Количество Тогда
			
			КоличествоРеквизитовТабличнойЧасти = 0;
			Прервать;
		КонецЕсли;
		КоличествоРеквизитовТабличнойЧасти = Количество;
	КонецЦикла;
	
	Если КоличествоРеквизитовТабличнойЧасти = 0 Тогда
		ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'В справочнике %1 в табличных частях %2
			           |допустимо только одинаковое количество реквизитов %3 и не более 15.'"),
			"КлючиДоступа", "ТабличнаяЧасть" + "*", "Значение" + "*");
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;
	
	Размерность = Новый Структура;
	Размерность.Вставить("КоличествоТабличныхЧастей",          КоличествоТабличныхЧастей);
	Размерность.Вставить("КоличествоРеквизитовТабличнойЧасти", КоличествоРеквизитовТабличнойЧасти);
	
	Возврат Новый ФиксированнаяСтруктура(Размерность);
	
КонецФункции

Функция КоличествоОпорныхПолейРегистра(Знач ИмяРегистра = "") Экспорт
	
	Если ИмяРегистра = "" Или ИмяРегистра = "КлючиДоступаКРегистрам" Тогда
		ИмяРегистра = "КлючиДоступаКРегистрам";
		Измерения = Метаданные.РегистрыСведений.КлючиДоступаКРегистрам.Измерения;
		Если Измерения.Количество() < 1 Или Измерения[0].Имя <> "Регистр" Тогда
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'В регистре сведений %1
				           |первым измерением должно быть %2.'"), ИмяРегистра, "Регистр");
			ВызватьИсключение ТекстОшибки;
		КонецЕсли;
		Если Измерения.Количество() < 2 Или Измерения[1].Имя <> "ВариантДоступа" Тогда
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'В регистре сведений %1
				           |вторым измерением должно быть %2.'"), ИмяРегистра, "ВариантДоступа");
			ВызватьИсключение ТекстОшибки;
		КонецЕсли;
		ИндексИзмеренияПоля = 2;
	Иначе
		Измерения = Метаданные.РегистрыСведений[ИмяРегистра].Измерения;
		Если Измерения.Количество() < 1 Или Измерения[0].Имя <> "ВариантДоступа" Тогда
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'В регистре сведений %1
				           |первым измерением должно быть %2.'"), ИмяРегистра, "ВариантДоступа");
			ВызватьИсключение ТекстОшибки;
		КонецЕсли;
		ИндексИзмеренияПоля = 1;
	КонецЕсли;
	
	ВариантДоступаТип = Измерения.ВариантДоступа.Тип;
	
	Если ВариантДоступаТип.Типы().Количество() <> 1
	 Или Не ВариантДоступаТип.СодержитТип(Тип("Число"))
	 Или ВариантДоступаТип.КвалификаторыЧисла.ДопустимыйЗнак <> ДопустимыйЗнак.Неотрицательный
	 Или ВариантДоступаТип.КвалификаторыЧисла.Разрядность <> 4
	 Или ВариантДоступаТип.КвалификаторыЧисла.РазрядностьДробнойЧасти <> 0 Тогда
	
		ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'В регистре сведений %1
			           |измерение %2 должно иметь тип %3.'"),
			ИмяРегистра, "ВариантДоступа", "Число(4,0,Неотрицательное)");
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;
	
	Если Измерения.Количество() <= ИндексИзмеренияПоля
	 Или Измерения[ИндексИзмеренияПоля].Имя <> "Поле1" Тогда
		ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'В регистре сведений %1
			           |после измерения %2 должно быть %3.'"), ИмяРегистра, "ВариантДоступа", "Поле1");
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;
	
	ПоследнийНомерПоля = 0;
	Для Каждого Измерение Из Измерения Цикл
		Если Измерение.Имя = "Регистр" Или Измерение.Имя = "ВариантДоступа" Тогда
			Продолжить;
		КонецЕсли;
		ИмяПоля = "Поле" + XMLСтрока(ПоследнийНомерПоля + 1);
		Если Измерение.Имя <> ИмяПоля Тогда
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'В регистре сведений %1
				           |измерения вида %2<номер> должны идти по порядку
				           |а на месте измерения %3 обнаружено %4'"),
				ИмяРегистра, "Поле", ИмяПоля, Измерение.Имя);
			ВызватьИсключение ТекстОшибки;
		КонецЕсли;
		ПоследнийНомерПоля = ПоследнийНомерПоля + 1;
	КонецЦикла;
	
	Возврат ПоследнийНомерПоля;
	
КонецФункции

Функция МаксимальноеКоличествоОпорныхПолейРегистра() Экспорт
	
	// При изменении нужно синхронно изменить шаблон ограничения доступа ДляРегистра.
	Возврат Число(5);
	
КонецФункции

Функция ПустыеЗначенияОпорныхПолей(Количество) Экспорт
	
	ПустыеЗначения = Новый Структура;
	Для Номер = 1 По Количество Цикл
		ПустыеЗначения.Вставить("Поле" + Номер, Перечисления.ДополнительныеЗначенияДоступа.Null);
	КонецЦикла;
	
	Возврат ПустыеЗначения;
	
КонецФункции

// Возвращаемое значение:
//   см. УправлениеДоступомСлужебный.СинтаксисЯзыка
//
Функция СинтаксисЯзыка() Экспорт
	
	Возврат УправлениеДоступомСлужебный.СинтаксисЯзыка();
	
КонецФункции

// Возвращаемое значение:
//   см. УправлениеДоступомСлужебный.УзлыДляПроверкиДоступности
//
Функция УзлыДляПроверкиДоступности(Список, ЭтоСписокИсключений) Экспорт
	
	Возврат УправлениеДоступомСлужебный.УзлыДляПроверкиДоступности(Список, ЭтоСписокИсключений);
	
КонецФункции

Функция РазделенныеДанныеНедоступны() Экспорт
	
	Возврат Не ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных();
	
КонецФункции

Функция ОписаниеПредопределенногоИдентификатораОбъектаМетаданных(ПолноеИмяОбъектаМетаданных) Экспорт
	
	Имена = УправлениеДоступомСлужебныйПовтИсп.ИменаПредопределенныхЭлементовСправочника(
		"ИдентификаторыОбъектовМетаданных");
	
	Имя = СтрЗаменить(ПолноеИмяОбъектаМетаданных, ".", "");
	
	Если Имена.Найти(Имя) <> Неопределено Тогда
		Возврат "ИдентификаторыОбъектовМетаданных." + Имя;
	КонецЕсли;
	
	Имена = УправлениеДоступомСлужебныйПовтИсп.ИменаПредопределенныхЭлементовСправочника(
		"ИдентификаторыОбъектовРасширений");
	
	Если Имена.Найти(Имя) <> Неопределено Тогда
		Возврат "ИдентификаторыОбъектовРасширений." + Имя;
	КонецЕсли;
	
	ОбъектМетаданных = ОбщегоНазначения.ОбъектМетаданныхПоПолномуИмени(ПолноеИмяОбъектаМетаданных);
	Если ОбъектМетаданных = Неопределено Тогда
		ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Не удалось получить имя предопределенного идентификатора объекта метаданных
			           |так как не существует указанный объект метаданных:
			           |""%1"".'"),
			ПолноеИмяОбъектаМетаданных);
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;
	
	Если ОбъектМетаданных.РасширениеКонфигурации() = Неопределено Тогда
		Возврат "ИдентификаторыОбъектовМетаданных." + Имя;
	КонецЕсли;
	
	Возврат "ИдентификаторыОбъектовРасширений." + Имя;
	
КонецФункции

Функция ИменаПредопределенныхЭлементовСправочника(ИмяСправочника) Экспорт
	
	Возврат Метаданные.Справочники[ИмяСправочника].ПолучитьИменаПредопределенных();
	
КонецФункции

Функция ДопустимыеТипыЗначенийКлючейДоступа() Экспорт
	
	РазмерностьКлюча = РазмерностьКлючаДоступа();
	РеквизитыСправочника      = Метаданные.Справочники.КлючиДоступа.Реквизиты;
	ТабличныеЧастиСправочника = Метаданные.Справочники.КлючиДоступа.ТабличныеЧасти;
	
	ДопустимыеТипы = РеквизитыСправочника.Значение1.Тип.Типы();
	Для НомерРеквизита = 2 По 5 Цикл
		УточнитьДопустимыеТипы(ДопустимыеТипы, РеквизитыСправочника["Значение" + НомерРеквизита]);
	КонецЦикла;
	Для НомерРеквизита = 6 По 10 Цикл
		УточнитьДопустимыеТипы(ДопустимыеТипы, ТабличныеЧастиСправочника.Шапка.Реквизиты["Значение" + НомерРеквизита]);
	КонецЦикла;
	Для НомерТабличнойЧасти = 1 По РазмерностьКлюча.КоличествоТабличныхЧастей Цикл
		ТабличнаяЧасть = ТабличныеЧастиСправочника["ТабличнаяЧасть" + НомерТабличнойЧасти];
		Для НомерРеквизита = 1 По РазмерностьКлюча.КоличествоРеквизитовТабличнойЧасти Цикл
			УточнитьДопустимыеТипы(ДопустимыеТипы, ТабличнаяЧасть.Реквизиты["Значение" + НомерРеквизита]);
		КонецЦикла;
	КонецЦикла;
	
	Возврат Новый ОписаниеТипов(ДопустимыеТипы);
	
КонецФункции

Функция ПоследняяПроверкаВерсииРазрешенныхНаборов() Экспорт
	
	Возврат Новый Структура("Дата", '00010101');
	
КонецФункции

Функция ИменаРолейБазовыеПрава(ДляВнешнихПользователей) Экспорт
	
	ИменаРолей = Новый Массив;
	
	НазначениеРолей = ПользователиСлужебныйПовтИсп.НазначениеРолей();
	
	Для Каждого Роль Из Метаданные.Роли Цикл
		ИмяРоли = Роль.Имя;
		// _Демо начало примера
		Если СтрНачинаетсяС(ИмяРоли, "_Демо") Тогда
			ИмяРоли = Сред(ИмяРоли, СтрДлина("_Демо") + 1);
		КонецЕсли;
		// _Демо конец примера
		Если Не СтрНачинаетсяС(ВРег(ИмяРоли), ВРег("БазовыеПрава")) Тогда
			Продолжить;
		КонецЕсли;
		РольДляВнешнихПользователей = НазначениеРолей.ТолькоДляВнешнихПользователей.Получить(Роль.Имя) <> Неопределено;
		Если НазначениеРолей.СовместноДляПользователейИВнешнихПользователей.Получить(Роль.Имя) <> Неопределено
		 Или РольДляВнешнихПользователей = ДляВнешнихПользователей Тогда
			ИменаРолей.Добавить(Роль.Имя);
		КонецЕсли;
	КонецЦикла;
	
	Возврат ИменаРолей;
	
КонецФункции

Функция ТребуетсяУточнениеПланаЗапроса() Экспорт
	
	Возврат Не ОбщегоНазначения.ИнформационнаяБазаФайловая();
	
КонецФункции

// Только для внутреннего использования.
//
// Возвращаемое значение:
//  Строка
//
Функция УточнениеПланаЗапроса(Хеш, ДлинаХеша) Экспорт
	
	Биты = Новый Массив;
	Для НомерБита = 0 По ДлинаХеша - 1 Цикл
		Биты.Вставить(0, ?(ПроверитьБит(Хеш, НомерБита), "ИСТИНА", "ЛОЖЬ"));
	КонецЦикла;
	
	Возврат "ИСТИНА В (ИСТИНА," + СтрСоединить(Биты, ",") + ")"; // @query-part-1
	
КонецФункции

Функция ПоляВРегистреСимволовМетаданных(ПолноеИмя, Поля) Экспорт
	
	СхемаЗапроса = Новый СхемаЗапроса;
	СхемаЗапроса.УстановитьТекстЗапроса(СтрЗаменить("ВЫБРАТЬ * ИЗ &ИмяТаблицы", "&ИмяТаблицы", ПолноеИмя));
	
	ПоляВМетаданных = Новый Соответствие;
	Для Каждого Колонка Из СхемаЗапроса.ПакетЗапросов[0].Колонки Цикл
		ПоляВМетаданных.Вставить(ВРег(Колонка.Псевдоним), Колонка.Псевдоним);
	КонецЦикла;
	
	ПоляКакУказаны = СтрРазделить(Поля, ",", Ложь);
	ПоляКакВМетаданных = Новый Массив;
	Для Каждого Поле Из ПоляКакУказаны Цикл
		ПоляКакВМетаданных.Добавить(ПоляВМетаданных.Получить(ВРег(Поле)));
	КонецЦикла;
	
	Возврат СтрСоединить(ПоляКакВМетаданных, ",");
	
КонецФункции

Функция ДоступнаБалансировкаНагрузкиНаДиск() Экспорт
	
	Возврат Не ОбщегоНазначения.ИнформационнаяБазаФайловая();
	
КонецФункции

#КонецОбласти

////////////////////////////////////////////////////////////////////////////////
// Вспомогательные процедуры и функции.

Процедура ДобавитьПустуюСсылкуТипаЗначений(ПустыеСсылкиПоТипам, ТипГруппИЗначений, ТипЗначений)
	
	Если ТипГруппИЗначений = Тип("Неопределено") Тогда
		Возврат;
	КонецЕсли;
	
	ПустыеСсылки = ПустыеСсылкиПоТипам.Получить(ТипГруппИЗначений);
	
	Если ПустыеСсылки = Неопределено Тогда
		ПустыеСсылки = Новый Массив;
		ПустыеСсылкиПоТипам.Вставить(ТипГруппИЗначений, ПустыеСсылки);
	КонецЕсли;
	
	Типы = Новый Массив;
	Типы.Добавить(ТипЗначений);
	ОписаниеТипов = Новый ОписаниеТипов(Типы);
	
	ПустаяСсылка = ОписаниеТипов.ПривестиЗначение(Неопределено);
	ПустыеСсылки.Добавить(ПустаяСсылка);
	
КонецПроцедуры

#Область УниверсальноеОграничение

Функция КоличествоПодобныхЭлементовВКоллекции(Коллекция, НачалоИмени, НачальныйНомер = 1)
	
	КоличествоПодобных = 0;
	МаксимальныйНомер = 0;
	
	Для Каждого ЭлементКоллекции Из Коллекция Цикл
		Если Не СтрНачинаетсяС(ЭлементКоллекции.Имя, НачалоИмени) Тогда
			Продолжить;
		КонецЕсли;
		НомерЭлемента = Сред(ЭлементКоллекции.Имя, СтрДлина(НачалоИмени) + 1);
		Если СтрДлина(НомерЭлемента) < 1 Или СтрДлина(НомерЭлемента) > 2 Тогда
			КоличествоПодобных = 0;
			Прервать;
		КонецЕсли;
		Если Не ( Лев(НомерЭлемента, 1) >= "0" И Лев(НомерЭлемента, 1) <= "9" ) Тогда
			КоличествоПодобных = 0;
			Прервать;
		КонецЕсли;
		Если СтрДлина(НомерЭлемента) = 2
		   И Не ( Лев(НомерЭлемента, 2) >= "0" И Лев(НомерЭлемента, 2) <= "9" ) Тогда
			КоличествоПодобных = 0;
			Прервать;
		КонецЕсли;
		НомерЭлемента = Число(НомерЭлемента);
		Если НомерЭлемента < НачальныйНомер Тогда
			КоличествоПодобных = 0;
			Прервать;
		КонецЕсли;
		
		КоличествоПодобных = КоличествоПодобных + 1;
		МаксимальныйНомер = ?(МаксимальныйНомер > НомерЭлемента, МаксимальныйНомер, НомерЭлемента);
	КонецЦикла;
	
	Если МаксимальныйНомер - НачальныйНомер + 1 <> КоличествоПодобных Тогда
		КоличествоПодобных = 0;
	КонецЕсли;
	
	Возврат КоличествоПодобных;
	
КонецФункции

// Для функции ДопустимыеТипыЗначенийКлючейДоступа.
Процедура УточнитьДопустимыеТипы(ДопустимыеТипы, Реквизит);
	
	Индекс = ДопустимыеТипы.Количество() - 1;
	ОписаниеТипов = Реквизит.Тип;
	
	Пока Индекс >= 0 Цикл
		Если Не ОписаниеТипов.СодержитТип(ДопустимыеТипы[Индекс]) Тогда
			ДопустимыеТипы.Удалить(Индекс);
		КонецЕсли;
		Индекс = Индекс - 1;
	КонецЦикла;
	
КонецПроцедуры

// Для функции ТиповСсылокВедущихОбъектов.
Процедура ДобавитьТипы(Типы, ДобавляемыеТипы)
	
	Для Каждого Тип Из ДобавляемыеТипы Цикл
		Типы.Вставить(Тип, Истина);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
