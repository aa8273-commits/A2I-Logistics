import 'package:flutter/material.dart';

class SmartShipmentScreen extends StatefulWidget {
  const SmartShipmentScreen({Key? key}) : super(key: key);

  @override
  State<SmartShipmentScreen> createState() => _SmartShipmentScreenState();
}

class _SmartShipmentScreenState extends State<SmartShipmentScreen> {
  // الألوان الأساسية المستخرجة من الهوية
  final Color backgroundColor = const Color(0xFF080E1E); // الكحلي العميق
  final Color cardBackgroundColor = const Color(
    0xFF131D33,
  ); // لون الكروت الداخلي
  final Color primaryCyan = const Color(0xFF00B4D8); // الأزرق الكهربائي
  final Color warningOrange = const Color(0xFFFF6B00); // البرتقالي للتنبيهات

  // قيم تفاعلية للتجربة داخل الشاشة
  double cargoWeight = 8.0; // بالطن
  double cargoVolume = 24.0; // بالمر المربع
  bool isRefrigerated = true;
  double targetTemperature = 4.0; // درجة مئوية

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome, color: primaryCyan, size: 20),
            const SizedBox(width: 8),
            const Text(
              'A2I Smart Shipment',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Title
            const Text(
              'تفاصيل البضاعة المطلوبة',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'أدخل مواصفات الشحنة ليقوم النظام بالتحليل الآلي',
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            const SizedBox(height: 16),

            // Form Fields Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCustomTextField(
                    'عنوان التحليم (من)',
                    'القاهرة - المنطقة الصناعية',
                    Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildCustomTextField(
                    'عنوان التسليم (إلى)',
                    'أسوان - الميناء النمساوي',
                    Icons.flag_outlined,
                  ),
                  const SizedBox(height: 16),

                  // Weight Slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'الوزن الإجمالي:',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '${cargoWeight.toInt()} طن',
                        style: TextStyle(
                          color: primaryCyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: cargoWeight,
                    min: 1,
                    max: 30,
                    activeColor: primaryCyan,
                    inactiveColor: Colors.white10,
                    onChanged: (val) => setState(() => cargoWeight = val),
                  ),

                  // Refrigeration Switch
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'هل تحتاج تبريد/تجميد؟',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    activeColor: primaryCyan,
                    value: isRefrigerated,
                    onChanged: (val) => setState(() => isRefrigerated = val),
                  ),

                  if (isRefrigerated) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'درجة الحرارة المطلوبة:',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          '${targetTemperature.toInt()}°C',
                          style: TextStyle(
                            color: warningOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: targetTemperature,
                      min: -20,
                      max: 15,
                      activeColor: warningOrange,
                      inactiveColor: Colors.white10,
                      onChanged: (val) =>
                          setState(() => targetTemperature = val),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // AI Suggestion Output Panel (كارت التحليل الذكي)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: primaryCyan.withOpacity(0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryCyan.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: warningOrange.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.bolt, color: warningOrange, size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'اقتراح خوارزمية AI Engine',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white12, height: 24),

                  _buildAIRow(
                    'السعر التقديري للرحلة:',
                    '\$2,340 USD',
                    isHighlight: true,
                  ),
                  _buildAIRow(
                    'المركبة المقترحة:',
                    'تريلا مبردة (Refrigerated)',
                  ),
                  _buildAIRow('زمن الرحلة المتوقع:', '6 ساعات و 45 دقيقة'),
                  _buildAIRow('استهلاك الوقود:', '142 لتر'),

                  const SizedBox(height: 16),

                  // Button Demo (دون توجيه لصفحات ثانية)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryCyan,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // مجرد إظهار رسالة لتجربة الشكل
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم حفظ البيانات ومعاينتها بنجاح!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: const Text(
                        'تأكيد وطرح في المزايدة العكسية',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTextField(String label, String hint, IconData icon) {
    return TextField(
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: primaryCyan, size: 20),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60, fontSize: 13),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
        filled: true,
        fillColor: backgroundColor.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildAIRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          Text(
            value,
            style: TextStyle(
              color: isHighlight ? primaryCyan : Colors.white,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
              fontSize: isHighlight ? 16 : 13,
            ),
          ),
        ],
      ),
    );
  }
}
