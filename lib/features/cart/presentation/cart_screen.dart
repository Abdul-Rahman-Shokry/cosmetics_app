import 'package:cosmetics_app/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../data/models/cart_model.dart';
import '../logic/cart_cubit.dart';
import '../logic/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Text(
                    "My Cart",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: AppImage(
                          "ic_round-shopping-cart-checkout.svg",
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is CartLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CartError) {
                      return Center(child: Text(state.message));
                    } else if (state is CartLoaded) {
                      final cart = state.cart;

                      if (cart.items.isEmpty) {
                        return const Center(child: Text("Your cart is empty"));
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "You have ${cart.items.length} products in your cart",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.secondaryText,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView.separated(
                                itemCount: cart.items.length,
                                separatorBuilder: (context, index) => const Divider(
                                  color: Color(0xFFD9D9D9),
                                  thickness: 1,
                                  height: 30,
                                ),
                                itemBuilder: (context, index) {
                                  final item = cart.items[index];
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(12),
                                              child: AppImage(
                                                item.imageUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 8,
                                            left: 8,
                                            child: GestureDetector(
                                              onTap: () {
                                                context.read<CartCubit>().removeFromCart(item.productId);
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Color(0xFFB00020),
                                                size: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5),
                                            Text(
                                              item.productNameEn,
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryText,
                                                fontSize: 16,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 15),
                                            Text(
                                              "${item.price} EGP",
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.w800,
                                                color: AppColors.primaryText,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: const Color(0xFFB3B3C1)),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        context.read<CartCubit>().updateCartItem(item.productId, item.quantity - 1);
                                                      },
                                                      icon: const Icon(Icons.remove, color: AppColors.primaryText),
                                                      padding: EdgeInsets.zero,
                                                      constraints: const BoxConstraints(),
                                                      iconSize: 20,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                                      child: Text(
                                                        "${item.quantity}",
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 16,
                                                          color: AppColors.primaryText,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        context.read<CartCubit>().updateCartItem(item.productId, item.quantity + 1);
                                                      },
                                                      icon: const Icon(Icons.add, color: AppColors.primaryText),
                                                      padding: EdgeInsets.zero,
                                                      constraints: const BoxConstraints(),
                                                      iconSize: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            _buildPaymentSummary(context, cart),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentSummary(BuildContext context, CartModel cart) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFBFE0E2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "- REVIEW PAYMENT",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primaryText,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "PAYMENT SUMMARY",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryText,
                  fontSize: 14,
                ),
              ),
              Text(
                "${cart.total.toStringAsFixed(2)} EGP",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "SHIPPING FEES",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryText,
                  fontSize: 12,
                ),
              ),
              Text(
                "TO BE CALCULATED",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryText,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(color: Color(0xFF90B4B5), thickness: 1),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOTAL + VAT",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryText,
                  fontSize: 12,
                ),
              ),
              Text(
                "${cart.total.toStringAsFixed(2)} EGP",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_checkout, color: Colors.white, size: 20),
            label: const Text(
              "PROCEED CHECKOUT",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }
}