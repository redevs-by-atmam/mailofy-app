import 'package:flutter/material.dart';
import 'package:mailofly_android/components/TemplateCard.dart';
import 'package:mailofly_android/services/api_service.dart';
import 'package:mailofly_android/services/template_service.dart';
import 'package:mailofly_android/supabase/types/tables/templates.dart';
import 'package:mailofly_android/utils/api_response_model.dart';

class TemplatesPage extends StatefulWidget {
  const TemplatesPage({super.key});

  @override
  State<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  late ApiResponse<List<TemplatesRow>>? response;

  @override
  void initState() {
    Future.microtask(() async {
      ApiClient api = ApiClient();
      TemplateService service = TemplateService(api);
      response = await service.getTemplates();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (response == null) return Text('Fetching');
    return Scaffold(
      appBar: AppBar(title: Text('Templates')),
      body:
          (response!.success && response!.data!.isNotEmpty)
              ? ListView.builder(
                itemCount: response!.data!.length,
                itemBuilder: (context, index) {
                  return TemplateCard(template: response!.data![index]);
                },
              )
              : Center(child: Text(response!.error?.message ?? 'Error')),
    );
  }
}
