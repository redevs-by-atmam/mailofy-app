import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../supabase/types/tables/templates.dart';

class TemplateCard extends StatelessWidget {
  final TemplatesRow template;

  const TemplateCard({super.key, required this.template});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy');
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: avatar + name + date
              Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Unknown User',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    template.createdAt != null
                        ? dateFormat.format(template.createdAt!)
                        : '',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Subject
              Text(
                template.subject ?? 'No subject',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              if (template.description != null) ...[
                const SizedBox(height: 6),
                Text(
                  template.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                ),
              ],

              const SizedBox(height: 12),

              // Category + use case
              Row(
                children: [
                  if (template.useCase != null)
                    Text(
                      template.useCase.toString().split('.').last,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
