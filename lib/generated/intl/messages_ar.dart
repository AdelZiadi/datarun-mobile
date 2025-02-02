// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(count) =>
      "${Intl.plural(count, zero: 'لا توجد استمارات', one: 'استمارة واحدة', two: 'استمارتان', other: '${count} استمارة')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNew": MessageLookupByLibrary.simpleMessage("إضافة جديد"),
        "appName": MessageLookupByLibrary.simpleMessage("ماس برو"),
        "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "configurationReady":
            MessageLookupByLibrary.simpleMessage("اكتملت تهيئة التطبيق"),
        "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
        "confirmSyncFormData": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد أنك تريد مزامنة البيانات المحددة؟"),
        "dashboard": MessageLookupByLibrary.simpleMessage("الرئيسية"),
        "discard": MessageLookupByLibrary.simpleMessage("تجاهل"),
        "enterYourUsername":
            MessageLookupByLibrary.simpleMessage("من فضلك أدخل اسم المستخدم"),
        "error": MessageLookupByLibrary.simpleMessage("خطأ"),
        "errorOpeningNewForm":
            MessageLookupByLibrary.simpleMessage("حدث خطأ أثناء فتح الإستمارة"),
        "error_access_keystore": MessageLookupByLibrary.simpleMessage(
            "لا يمكن الوصول إلى مستودع المفاتيح"),
        "error_account_disabled":
            MessageLookupByLibrary.simpleMessage("تم تعطيل حساب المستخدم"),
        "error_account_locked":
            MessageLookupByLibrary.simpleMessage("تم قفل حساب المستخدم"),
        "error_already_authenticated":
            MessageLookupByLibrary.simpleMessage("المستخدم مصادق عليه بالفعل"),
        "error_already_executed":
            MessageLookupByLibrary.simpleMessage("الإجراء تم تنفيذه بالفعل"),
        "error_api_invalid_query":
            MessageLookupByLibrary.simpleMessage("استعلام API غير صالح"),
        "error_app_name_not_set":
            MessageLookupByLibrary.simpleMessage("اسم التطبيق غير مضبوط"),
        "error_app_version_not_set":
            MessageLookupByLibrary.simpleMessage("إصدار التطبيق غير مضبوط"),
        "error_create_existing_error": MessageLookupByLibrary.simpleMessage(
            "لا يمكن إنشاء كائن موجود بالفعل"),
        "error_delete_non_existing_object":
            MessageLookupByLibrary.simpleMessage("لا يمكن حذف كائن غير موجود"),
        "error_different_offline_user": MessageLookupByLibrary.simpleMessage(
            "مستخدم آخر مصادق عليه بشكل غير متصل"),
        "error_export_encrypted":
            MessageLookupByLibrary.simpleMessage("لا يتم دعم التصدير المشفر"),
        "error_export_login":
            MessageLookupByLibrary.simpleMessage("يرجى تسجيل الدخول للتصدير"),
        "error_file_not_found":
            MessageLookupByLibrary.simpleMessage("الملف غير موجود"),
        "error_file_resize":
            MessageLookupByLibrary.simpleMessage("فشل تغيير حجم الصورة"),
        "error_generate_coordinate":
            MessageLookupByLibrary.simpleMessage("تعذر إنشاء الإحداثيات"),
        "error_import_exist":
            MessageLookupByLibrary.simpleMessage("الاستيراد موجود بالفعل"),
        "error_import_logout": MessageLookupByLibrary.simpleMessage(
            "الرجاء تسجيل الخروج قبل الاستيراد"),
        "error_import_version": MessageLookupByLibrary.simpleMessage(
            "إصدار الاستيراد أعلى من المدعوم"),
        "error_instance_keystore": MessageLookupByLibrary.simpleMessage(
            "لا يمكن إنشاء مثيل مستودع المفاتيح"),
        "error_invalid_characters":
            MessageLookupByLibrary.simpleMessage("أحرف غير صالحة"),
        "error_invalid_geometry":
            MessageLookupByLibrary.simpleMessage("قيمة هندسية غير صالحة"),
        "error_job":
            MessageLookupByLibrary.simpleMessage("تقرير العمل غير متاح"),
        "error_low_on_available_values":
            MessageLookupByLibrary.simpleMessage("نقص القيم المتاحة"),
        "error_many_requests":
            MessageLookupByLibrary.simpleMessage("الكثير من الطلبات"),
        "error_max_tei_count_reached": MessageLookupByLibrary.simpleMessage(
            "تم الوصول إلى الحد الأقصى لعدد TEI"),
        "error_min_attributes": MessageLookupByLibrary.simpleMessage(
            "الحد الأدنى للسمات المطلوبة في البحث"),
        "error_no_reserved_values":
            MessageLookupByLibrary.simpleMessage("لا توجد قيم محجوزة"),
        "error_no_values_left_on_server": MessageLookupByLibrary.simpleMessage(
            "لا توجد قيم متبقية للحجز على الخادم"),
        "error_null_url": MessageLookupByLibrary.simpleMessage(
            "عنوان URL للخادم لا يمكن أن يكون فارغًا"),
        "error_object_insert":
            MessageLookupByLibrary.simpleMessage("لا يمكن إدراج الكائن"),
        "error_object_update":
            MessageLookupByLibrary.simpleMessage("لا يمكن تحديث الكائن"),
        "error_org_unit_scope": MessageLookupByLibrary.simpleMessage(
            "الوحدة التنظيمية غير مشمولة في نطاق البحث"),
        "error_ownership_access":
            MessageLookupByLibrary.simpleMessage("تم رفض وصول الملكية"),
        "error_relationship_updated":
            MessageLookupByLibrary.simpleMessage("لا يمكن تحديث العلاقات"),
        "error_reserve_value_on_server": MessageLookupByLibrary.simpleMessage(
            "تعذر الحجز على القيمة على الخادم"),
        "error_server_malformed":
            MessageLookupByLibrary.simpleMessage("عنوان URL للخادم غير صحيح"),
        "error_set_value":
            MessageLookupByLibrary.simpleMessage("لا يمكن تعيين القيمة"),
        "error_settings_app_not_intalled":
            MessageLookupByLibrary.simpleMessage("تطبيق الإعدادات غير مثبت"),
        "error_settings_app_not_supported":
            MessageLookupByLibrary.simpleMessage("تطبيق الإعدادات غير مدعوم"),
        "error_sms_not_supported": MessageLookupByLibrary.simpleMessage(
            "غير مدعومة خدمة الرسائل القصيرة"),
        "error_socket_timeout":
            MessageLookupByLibrary.simpleMessage("انتهاء مهلة الاتصال"),
        "error_ssl": MessageLookupByLibrary.simpleMessage("خطأ SSL"),
        "error_too_manu_org_units": MessageLookupByLibrary.simpleMessage(
            "عدد كبير جدًا من الوحدات التنظيمية"),
        "error_too_many_periods":
            MessageLookupByLibrary.simpleMessage("عدد كبير جدًا من الفترات"),
        "error_unexpected":
            MessageLookupByLibrary.simpleMessage("حدث خطأ غير متوقع"),
        "error_url_not_found":
            MessageLookupByLibrary.simpleMessage("عنوان URL غير موجود"),
        "error_user_no_authenticated":
            MessageLookupByLibrary.simpleMessage("لا يوجد مستخدم مصادق عليه"),
        "error_user_no_authenticated_offline":
            MessageLookupByLibrary.simpleMessage(
                "لا يوجد مستخدم مصادق عليه حاليًا"),
        "error_value_reservation_time": MessageLookupByLibrary.simpleMessage(
            "استغرق حجز القيم وقتًا طويلاً"),
        "finalData": MessageLookupByLibrary.simpleMessage("بيانات نهائية"),
        "form": m0,
        "hidePassword": MessageLookupByLibrary.simpleMessage("اخفاء كلمة السر"),
        "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "loginErrorBadCredentials": MessageLookupByLibrary.simpleMessage(
            "اسم مستخدم أو كلمة مرور غير صحيحة"),
        "loginErrorErrorResponse":
            MessageLookupByLibrary.simpleMessage("خطأ في معالجة الاستجابة"),
        "loginErrorNoDataRunInstance":
            MessageLookupByLibrary.simpleMessage("لم يتم العثور على الخادم"),
        "loginErrorNullPass": MessageLookupByLibrary.simpleMessage(
            "لا يمكن أن تكون كلمة المرور فارغة"),
        "loginErrorNullUsername": MessageLookupByLibrary.simpleMessage(
            "لا يمكن أن يكون اسم المستخدم فارغًا"),
        "loginErrorUnknownHost":
            MessageLookupByLibrary.simpleMessage("مضيف غير معروف"),
        "loginErrorUnsuccessfulResponse":
            MessageLookupByLibrary.simpleMessage("استجابة غير ناجحة من الخادم"),
        "markAsFinalData": MessageLookupByLibrary.simpleMessage(
            "تعيين هذه البيانات كنهائية وجاهزة للإرسال."),
        "nmcpYemen": MessageLookupByLibrary.simpleMessage(
            "البرنامج الوطني لمكافحة الملاريا"),
        "noFormsAvailable": MessageLookupByLibrary.simpleMessage(
            "لا تتوفر استمارات لهذا النشاط"),
        "notMappedError": MessageLookupByLibrary.simpleMessage("خطأ غير معتمد"),
        "notNow": MessageLookupByLibrary.simpleMessage("ليس الآن"),
        "objectAccessClosed":
            MessageLookupByLibrary.simpleMessage("الوصول مغلق لهذا الكائن"),
        "objectAccessDenied":
            MessageLookupByLibrary.simpleMessage("الوصول مرفوض لهذا الكائن"),
        "ok": MessageLookupByLibrary.simpleMessage("موافق"),
        "online_search_parsing_error":
            MessageLookupByLibrary.simpleMessage("خطأ في تحليل بحث الشبكة"),
        "open": MessageLookupByLibrary.simpleMessage("فتح"),
        "openNewForm":
            MessageLookupByLibrary.simpleMessage("فتح استمارة جديدة"),
        "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
        "send": MessageLookupByLibrary.simpleMessage("إرسال"),
        "showPassword": MessageLookupByLibrary.simpleMessage("أظهر كلمة السر"),
        "syncFormData":
            MessageLookupByLibrary.simpleMessage("مزامنة بيانات الاستمارة"),
        "syncingConfiguration":
            MessageLookupByLibrary.simpleMessage("إعدادات المزامنة"),
        "syncingData": MessageLookupByLibrary.simpleMessage("مزامنة بيانات"),
        "syncingEvents":
            MessageLookupByLibrary.simpleMessage("مزامنة الإستمارات"),
        "user": MessageLookupByLibrary.simpleMessage("مستخدم"),
        "username": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
        "viewAvailableForms":
            MessageLookupByLibrary.simpleMessage("استعرض الاستمارات المتاحة"),
        "viewList": MessageLookupByLibrary.simpleMessage("عرض القائمة")
      };
}
