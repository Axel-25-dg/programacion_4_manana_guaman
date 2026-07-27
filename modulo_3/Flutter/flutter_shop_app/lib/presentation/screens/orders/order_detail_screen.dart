import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/date_formatters.dart';
import '../../providers/orders_provider.dart';
import '../../widgets/status_badge.dart';
import '../../../domain/model/order.dart';

const _progressSteps = [
  OrderStatus.pending,
  OrderStatus.confirmed,
  OrderStatus.shipped,
  OrderStatus.delivered,
];

class OrderDetailScreen extends ConsumerWidget {
  final int orderId;
  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(orderDetailProvider(orderId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido #$orderId'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: orderAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.accent)),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('❌', style: TextStyle(fontSize: 40)),
              const SizedBox(height: 12),
              Text(error.toString(), style: const TextStyle(color: AppColors.error)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Volver'),
              ),
            ],
          ),
        ),
        data: (order) {
          final currentStep = _progressSteps.indexOf(order.status);
          final subtotal = order.total / 1.15;
          final taxAmount = order.total - subtotal;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(formatDate(order.createdAt), style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                        const SizedBox(height: 4),
                        Text('Cliente: ${order.username}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      ],
                    ),
                    StatusBadge(status: order.status),
                  ],
                ),
                const SizedBox(height: 20),
                _SectionCard(
                  title: 'Estado del pedido',
                  child: _OrderProgressBar(steps: _progressSteps, currentStep: currentStep),
                ),
                const SizedBox(height: 14),
                _SectionCard(
                  title: 'Productos (${order.numItems})',
                  child: Column(
                    children: order.items.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.surface2,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(child: Text('📦', style: TextStyle(fontSize: 20))),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.productName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 4),
                                  Text('${formatPrice(item.unitPrice)} × ${item.quantity} ud.', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                                ],
                              ),
                            ),
                            Text(formatPrice(item.subtotal), style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 14),
                _SectionCard(
                  title: 'Resumen',
                  child: Column(
                    children: [
                      _FinancialRow('Subtotal (sin IVA)', subtotal, false),
                      const SizedBox(height: 6),
                      _FinancialRow('IVA (15%)', taxAmount, false),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      _FinancialRow('Total', order.total, true),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Center(child: Text('Actualizado: ${formatDateTime(order.updatedAt)}', style: const TextStyle(color: AppColors.textFaint, fontSize: 11))),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _OrderProgressBar extends StatelessWidget {
  final List<OrderStatus> steps;
  final int currentStep;

  const _OrderProgressBar({required this.steps, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        final idx = entry.key;
        final step = entry.value;
        final isDone = idx <= currentStep;
        final isCurrent = idx == currentStep;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: isCurrent ? 34 : 28,
                height: isCurrent ? 34 : 28,
                decoration: BoxDecoration(
                  color: isDone ? AppColors.accent : AppColors.surface2,
                  shape: BoxShape.circle,
                  border: Border.all(color: isDone ? AppColors.accent : AppColors.border, width: 1.5),
                  boxShadow: isCurrent
                      ? [BoxShadow(color: AppColors.accent.withOpacity(0.25), blurRadius: 10, spreadRadius: 1)]
                      : null,
                ),
                child: Center(
                  child: Text(
                    isDone ? '✓' : '${idx + 1}',
                    style: TextStyle(
                      color: isDone ? AppColors.onAccent : AppColors.textFaint,
                      fontWeight: FontWeight.bold,
                      fontSize: isCurrent ? 16 : 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(step.label, style: TextStyle(color: isDone ? AppColors.accent : AppColors.textSecondary, fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal)),
                    const SizedBox(height: 2),
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: isDone ? AppColors.accent : AppColors.border,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8)),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _FinancialRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isFinal;

  const _FinancialRow(this.label, this.value, this.isFinal);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: isFinal ? AppColors.textPrimary : AppColors.textSecondary, fontSize: isFinal ? 16 : 14, fontWeight: isFinal ? FontWeight.bold : FontWeight.normal)),
        Text(formatPrice(value), style: TextStyle(color: isFinal ? AppColors.accent : AppColors.textPrimary, fontSize: isFinal ? 18 : 14, fontWeight: isFinal ? FontWeight.w800 : FontWeight.w600)),
      ],
    );
  }
}