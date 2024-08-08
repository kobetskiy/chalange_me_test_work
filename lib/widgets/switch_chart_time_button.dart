import 'package:flutter/material.dart';
import 'package:test_work/model/coin_model.dart';

class SwitchChartTimeButton extends StatelessWidget {
  const SwitchChartTimeButton({
    super.key,
    required this.coin,
    required this.isSelected,
    required this.onPressed,
    required this.child,
  });

  final CoinModel coin;
  final bool isSelected;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[800],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: child,
    );
  }
}