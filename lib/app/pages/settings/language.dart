import 'package:flutter/material.dart';

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  String selectedLanguage = 'English';

  final List<Map<String, dynamic>> languages = [
    {
      'name': 'English',
      'nativeName': 'English',
      'flag': '🇺🇸',
      'available': true,
    },
    {
      'name': 'Hindi',
      'nativeName': 'हिन्दी',
      'flag': '🇮🇳',
      'available': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Language', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          final isSelected = selectedLanguage == language['name'];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12),
              border: isSelected 
                ? Border.all(color: Colors.blue, width: 2)
                : null,
            ),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Text(language['flag'], style: const TextStyle(fontSize: 20))),
              ),
              title: Text(
                language['name'],
                style: TextStyle(
                  color: language['available'] ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                language['nativeName'],
                style: TextStyle(color: language['available'] ? Colors.grey : Colors.grey.withOpacity(0.5)),
              ),
              trailing: language['available']
                ? (isSelected 
                    ? const Icon(Icons.check_circle, color: Colors.blue)
                    : const Icon(Icons.radio_button_unchecked, color: Colors.grey))
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('Coming Soon', style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.w500)),
                  ),
              onTap: () {
                if (language['available']) {
                  setState(() {
                    selectedLanguage = language['name'];
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Language changed to ${language['name']}'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Coming Soon! Hindi support will be available in future updates.'),
                      backgroundColor: Colors.orange,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
