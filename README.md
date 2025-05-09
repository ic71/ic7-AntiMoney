# ic7-AntiMoney
A script designed to protect the server's economy from cheating and money exploits. The script monitors players' money and takes automatic actions when suspicious amounts are detected.


سكربت مخصص لحماية اقتصاد السيرفر من الغش واستغلال الأموال. يقوم السكربت بمراقبة أموال اللاعبين واتخاذ إجراءات تلقائية عند اكتشاف مبالغ مشبوهة.

## ⚙️ الميزات الرئيسية
- فحص رصيد اللاعب (الكاش + البنك) عند دخوله للسيرفر
- مراقبة مستمرة للتغيرات في أموال اللاعبين
- إرسال تنبيهات لديسكورد عند اكتشاف مبالغ مشبوهة
- تصفير أموال اللاعب المشبوه تلقائيًا
- طرد اللاعب مع رسالة مخصصة
- خيارات تكوين متعددة لتخصيص عمل السكربت

## 📋 المتطلبات
- إطار عمل [QBCore](https://github.com/qbcore-framework)

## ⚡ التثبيت
1. قم بتنزيل السكربت
2. ضع المجلد في مجلد `resources` الخاص بالسيرفر
3. أضف `ensure ic7-AntiMoney` إلى ملف server.cfg
4. قم بتعديل ملف `config.lua` لتعيين إعداداتك المفضلة وخاصة رابط الويب هوك في ديسكورد

## ⚙️ التكوين
يمكنك تعديل الإعدادات التالية في ملف `config.lua`:

```lua
-- الحد الأقصى للمبلغ المسموح به (افتراضي: 10 مليون)
Config.MaxMoney = 10000000

-- إعدادات الويب هوك في ديسكورد
Config.DiscordWebhook = "رابط_الويب_هوك_هنا"

-- رسالة الطرد
Config.KickMessage = "تم طردك بسبب وجود مبلغ غير مشروع في حسابك."

-- تفعيل أو تعطيل ميزات السكربت
Config.EnableDiscordLog = true    -- إرسال المعلومات إلى ديسكورد
Config.EnableMoneyReset = true    -- تصفير الفلوس
Config.EnableKick = true          -- طرد اللاعب
```

## ⌨️ الأوامر
| الأمر | الوصف | الصلاحيات |
|-------|-------|-----------|
| /setmaxmoney [المبلغ] | تعيين الحد الأقصى للمبلغ المسموح به | مسؤول |

## 🔧 الدعم الفني
[SevenM](https://discord.gg/NR6WAdzMYZ)





## 📝 الترخيص
جميع الحقوق محفوظة © 2023 
