import 'package:cosmetics_app/core/utils/helper_methods.dart';
import 'package:cosmetics_app/core/widgets/app_image.dart';
import 'package:cosmetics_app/features/cart/presentation/checkout_screen.dart';
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
       _buildAppBar(context),
       const SizedBox(height: 24),
       Expanded(
        child: BlocBuilder<CartCubit, CartState>(
         builder: (context, state) {
          return switch (state) {
           CartLoading() => const Center(
            child: CircularProgressIndicator(),
           ),
           CartError() => _buildErrorState(state.message),
           CartLoaded() => _buildCartContent(context, state.cart),
           _ => const SizedBox.shrink(),
          };
         },
        ),
       ),
      ],
     ),
    ),
   ),
  );
 }

 Widget _buildAppBar(BuildContext context) {
  return Padding(
   padding: const EdgeInsets.symmetric(horizontal: 20),
   child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
     const SizedBox(width: 24), // Balance spacing
     Text(
      "My Cart",
      style: Theme.of(context).textTheme.displayLarge,
     ),
     BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
       final isEnabled = state is CartLoaded && state.cart.items.isNotEmpty;
       return GestureDetector(
        onTap: isEnabled
            ? () {
         final cart = state.cart;
         goTo(
          page: CheckoutScreen(
           total: cart.total.toStringAsFixed(2),
          ),
          canPop: true,
         );
        }
            : null,
        child: Opacity(
         opacity: isEnabled ? 1.0 : 0.5,
         child: const AppImage(
          "ic_round-shopping-cart-checkout.svg",
          width: 24,
          height: 24,
         ),
        ),
       );
      },
     ),
    ],
   ),
  );
 }

 Widget _buildErrorState(String message) {
  return Center(
   child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
     const Icon(
      Icons.error_outline,
      size: 64,
      color: Colors.red,
     ),
     const SizedBox(height: 16),
     Text(
      message,
      style: const TextStyle(
       fontSize: 16,
       color: AppColors.primaryText,
      ),
      textAlign: TextAlign.center,
     ),
    ],
   ),
  );
 }

 Widget _buildCartContent(BuildContext context, CartModel cart) {
  if (cart.items.isEmpty) {
   return _buildEmptyCart();
  }

  return Padding(
   padding: const EdgeInsets.symmetric(horizontal: 20.0),
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     _buildCartHeader(context, cart.items.length),
     const SizedBox(height: 20),
     Expanded(
      child: _buildCartList(cart),
     ),
     _buildPaymentSummary(context, cart),
    ],
   ),
  );
 }

 Widget _buildEmptyCart() {
  return const Center(
   child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
     Icon(
      Icons.shopping_cart_outlined,
      size: 80,
      color: AppColors.secondaryText,
     ),
     SizedBox(height: 16),
     Text(
      "Your cart is empty",
      style: TextStyle(
       fontSize: 18,
       color: AppColors.secondaryText,
      ),
     ),
    ],
   ),
  );
 }

 Widget _buildCartHeader(BuildContext context, int itemCount) {
  return Text(
   "You have $itemCount product${itemCount != 1 ? 's' : ''} in your cart",
   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    color: AppColors.secondaryText,
    fontSize: 14,
   ),
  );
 }

 Widget _buildCartList(CartModel cart) {
  return ListView.separated(
   itemCount: cart.items.length,
   separatorBuilder: (context, index) => const Divider(
    color: Color(0xFFD9D9D9),
    thickness: 1,
    height: 30,
   ),
   itemBuilder: (context, index) {
    return _CartItem(item: cart.items[index]);
   },
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
     _buildSummaryRow(
      context,
      "Subtotal",
      "${cart.total.toStringAsFixed(2)} EGP",
      isBold: true,
     ),
     const SizedBox(height: 10),
     _buildSummaryRow(
      context,
      "SHIPPING FEES",
      "TO BE CALCULATED",
      fontSize: 12,
     ),
     const SizedBox(height: 15),
     const Divider(color: Color(0xFF90B4B5), thickness: 1),
     const SizedBox(height: 15),
     _buildSummaryRow(
      context,
      "TOTAL + VAT",
      "${cart.total.toStringAsFixed(2)} EGP",
      isBold: true,
      fontSize: 12,
     ),
     const SizedBox(height: 25),
     _buildCheckoutButton(context, cart),
    ],
   ),
  );
 }

 Widget _buildSummaryRow(
     BuildContext context,
     String label,
     String value, {
      bool isBold = false,
      double fontSize = 14,
     }) {
  return Row(
   mainAxisAlignment: MainAxisAlignment.spaceBetween,
   children: [
    Text(
     label,
     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.primaryText,
      fontSize: fontSize,
     ),
    ),
    Text(
     value,
     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.primaryText,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontSize: fontSize,
     ),
    ),
   ],
  );
 }

 Widget _buildCheckoutButton(BuildContext context, CartModel cart) {
  return SizedBox(
   width: double.infinity,
   height: 50,
   child: ElevatedButton.icon(
    onPressed: () {
     goTo(
      page: CheckoutScreen(
       total: cart.total.toStringAsFixed(2),
      ),
      canPop: true,
     );
    },
    icon: const Icon(
     Icons.shopping_cart_checkout,
     color: Colors.white,
     size: 20,
    ),
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
    ),
   ),
  );
 }
}

// Extracted Cart Item Widget
class _CartItem extends StatelessWidget {
 final dynamic item; // Replace with your CartItem model type

 const _CartItem({required this.item});

 @override
 Widget build(BuildContext context) {
  return Row(
   crossAxisAlignment: CrossAxisAlignment.start,
   children: [
    _buildProductImage(context),
    const SizedBox(width: 15),
    Expanded(
     child: _buildProductDetails(context),
    ),
   ],
  );
 }

 Widget _buildProductImage(BuildContext context) {
  return Stack(
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
      child: Container(
       padding: const EdgeInsets.all(4),
       decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
       ),
       child: const Icon(
        Icons.delete,
        color: Color(0xFFB00020),
        size: 20,
       ),
      ),
     ),
    ),
   ],
  );
 }

 Widget _buildProductDetails(BuildContext context) {
  return Column(
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
    const SizedBox(height: 8),
    _buildQuantitySelector(context),
   ],
  );
 }

 Widget _buildQuantitySelector(BuildContext context) {
  return Align(
   alignment: Alignment.centerRight,
   child: Container(
    decoration: BoxDecoration(
     border: Border.all(color: const Color(0xFFB3B3C1)),
     borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
     mainAxisSize: MainAxisSize.min,
     children: [
      _buildQuantityButton(
       context,
       Icons.remove,
           () => context.read<CartCubit>().updateCartItem(
        item.productId,
        item.quantity - 1,
       ),
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
      _buildQuantityButton(
       context,
       Icons.add,
           () => context.read<CartCubit>().updateCartItem(
        item.productId,
        item.quantity + 1,
       ),
      ),
     ],
    ),
   ),
  );
 }

 Widget _buildQuantityButton(
     BuildContext context,
     IconData icon,
     VoidCallback onPressed,
     ) {
  return IconButton(
   onPressed: onPressed,
   icon: Icon(icon, color: AppColors.primaryText),
   padding: EdgeInsets.zero,
   constraints: const BoxConstraints(),
   iconSize: 20,
  );
 }
}