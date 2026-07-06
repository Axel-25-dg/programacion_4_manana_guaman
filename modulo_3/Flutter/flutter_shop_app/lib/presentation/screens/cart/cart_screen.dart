import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/formatters.dart';
import '../../../theme/app_colors.dart';
import '../../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
      ),
      body: cartState.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Tu carrito está vacío', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 12),
                  const Text('Agrega productos para verlos aquí.'),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartState.items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = cartState.items[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 6),
                                  Text(item.product.category?.name ?? 'Sin categoría', style: const TextStyle(color: AppColors.textSecondary)),
                                  const SizedBox(height: 8),
                                  Text('${formatPrice(item.product.price)} × ${item.quantity}', style: const TextStyle(color: AppColors.textPrimary)),
                                  const SizedBox(height: 4),
                                  Text('Subtotal: ${formatPrice(item.subtotal)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    cartNotifier.addItem(item.product);
                                  },
                                ),
                                Text(item.quantity.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    cartNotifier.updateQuantity(item.product.id, item.quantity - 1);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    border: Border(top: BorderSide(color: AppColors.border)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(formatPrice(cartState.subtotal), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.accent)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const _CheckoutScreen()));
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.onAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Text('Continuar a pagar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _CheckoutScreen extends ConsumerWidget {
  const _CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Resumen de pago')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Confirma tu compra', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: cartState.items.length,
                separatorBuilder: (_, __) => const Divider(color: AppColors.border),
                itemBuilder: (context, index) {
                  final item = cartState.items[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(item.product.name),
                    subtitle: Text('${item.quantity} × ${formatPrice(item.product.price)}'),
                    trailing: Text(formatPrice(item.subtotal)),
                  );
                },
              ),
            ),
            const Divider(color: AppColors.border),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(formatPrice(cartState.subtotal), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.accent)),
              ],
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                ref.read(cartProvider.notifier).clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Compra completada con éxito')), 
                );
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.onAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Finalizar compra'),
            ),
          ],
        ),
      ),
    );
  }
}
