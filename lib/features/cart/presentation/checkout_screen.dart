import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_image.dart';

class CheckoutScreen extends StatelessWidget {
  final String total;

  const CheckoutScreen({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3E0E0),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const AppImage(
                          "arrow_left_circle.svg",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Checkout",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Delivery to",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildDeliveryCard(),
                      const SizedBox(height: 25),
                      const Text(
                        "Payment Method",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildPaymentMethodCard(),
                      const SizedBox(height: 15),
                      _buildVoucherCard(),
                      const SizedBox(height: 30),
                      const _DashedLine(),
                      const SizedBox(height: 30),
                      _buildPaymentSummary(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF75B6B8), width: 1.5),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: const AppImage("location.png", width: 97, height: 60,)
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Mansoura, 14 Porsaid St",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.primaryButton,
            size: 30,
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF75B6B8), width: 1.5),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 35,
            child: Stack(
              children: [
                Positioned(
                  left: 12,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              "**** **** **** 0256",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.primaryButton,
            size: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherCard() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 8, top: 8, bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF75B6B8), width: 1.5),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_offer_outlined,
            color: AppColors.primaryText,
            size: 24,
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              "Add vaucher",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryButton,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "Apply",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "- REVIEW PAYMENT",
          style: TextStyle(
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
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Subtotal",
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 14,
              ),
            ),
            Text(
              "$total EGP",
              style: const TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "SHIPPING FEES",
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 12,
              ),
            ),
            Text(
              "TO BE CALCULATED",
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(color: Color(0xFF75B6B8), thickness: 1),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "TOTAL + VAT",
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 12,
              ),
            ),
            Text(
              "$total EGP",
              style: const TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 20),
          label: const Text(
            "ORDER",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryButton,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 18),
            minimumSize: const Size(double.infinity, 55),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class _DashedLine extends StatelessWidget {
  const _DashedLine();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 6.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFFB3B3C1)),
              ),
            );
          }),
        );
      },
    );
  }
}