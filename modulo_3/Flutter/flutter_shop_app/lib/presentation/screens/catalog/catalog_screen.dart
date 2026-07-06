// lib/presentation/screens/catalog/catalog_screen.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../providers/catalog_provider.dart';
import '../../widgets/product_card.dart';
import 'catalog_filter_sheet.dart';

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  final _searchCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  Timer? _debounce;

  void _onScroll() {
    if (_scrollCtrl.position.pixels >= _scrollCtrl.position.maxScrollExtent - 200) {
      ref.read(catalogProvider.notifier).loadMore();
    }
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(catalogProvider.notifier).setSearch(query.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(catalogProvider);
    final catsAsync = ref.watch(categoriesProvider);
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.surface,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Catálogo', style: tt.headlineMedium),
                      Text(
                        '${state.total} productos',
                        style: tt.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchCtrl,
                    onChanged: _onSearchChanged,
                    decoration: const InputDecoration(
                      hintText: 'Buscar productos...',
                      prefixIcon: Icon(Icons.search_rounded, color: AppColors.textSecondary),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 34,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (final item in [
                                ('', 'Relevancia'),
                                ('price', 'Precio ↑'),
                                ('-price', 'Precio ↓'),
                                ('-created_at', 'Recientes'),
                              ])
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: Text(item.$2),
                                    selected: state.ordering == item.$1,
                                    onSelected: (_) => ref.read(catalogProvider.notifier).setOrdering(item.$1),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => CatalogFilterSheet(
                              minPrice: state.minPrice,
                              maxPrice: state.maxPrice,
                              onApply: (min, max) => ref.read(catalogProvider.notifier).setPriceRange(minPrice: min, maxPrice: max),
                              onClear: () => ref.read(catalogProvider.notifier).clearFilters(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.filter_list_rounded),
                        color: AppColors.accent,
                        tooltip: 'Filtrar',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (state.minPrice != null || state.maxPrice != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Wrap(
                        spacing: 8,
                        children: [
                          if (state.minPrice != null)
                            InputChip(
                              label: Text('Desde ${state.minPrice!.toStringAsFixed(0)}'),
                              onDeleted: () => ref.read(catalogProvider.notifier).setPriceRange(minPrice: null, maxPrice: state.maxPrice),
                            ),
                          if (state.maxPrice != null)
                            InputChip(
                              label: Text('Hasta ${state.maxPrice!.toStringAsFixed(0)}'),
                              onDeleted: () => ref.read(catalogProvider.notifier).setPriceRange(minPrice: state.minPrice, maxPrice: null),
                            ),
                        ],
                      ),
                    ),
                  catsAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (cats) => SizedBox(
                      height: 34,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: const Text('Todas'),
                              selected: state.selectedCategory == null,
                              onSelected: (_) => ref.read(catalogProvider.notifier).setCategory(null),
                            ),
                          ),
                          for (final cat in cats.where((c) => c.isActive))
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(cat.name),
                                selected: state.selectedCategory == cat.id,
                                onSelected: (_) => ref.read(catalogProvider.notifier).setCategory(cat.id),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            Expanded(
              child: Builder(
                builder: (_) {
                  if (state.isLoading && state.products.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.accent),
                    );
                  }
                  if (state.error != null && state.products.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('❌', style: TextStyle(fontSize: 40)),
                          const SizedBox(height: 12),
                          Text(state.error!, style: const TextStyle(color: AppColors.error)),
                          const SizedBox(height: 16),
                          FilledButton(
                            onPressed: () => ref.read(catalogProvider.notifier).refresh(),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: AppColors.onAccent,
                            ),
                            child: const Text('Reintentar'),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state.products.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('🔍', style: TextStyle(fontSize: 48)),
                          SizedBox(height: 12),
                          Text('Sin resultados', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Intenta con otra búsqueda', style: TextStyle(color: AppColors.textSecondary)),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    controller: _scrollCtrl,
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: state.products.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (ctx, i) {
                      if (i >= state.products.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(
                              color: AppColors.accent,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }
                      final product = state.products[i];
                      return ProductCard(
                        product: product,
                        onTap: () => context.push('/catalog/${product.id}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
