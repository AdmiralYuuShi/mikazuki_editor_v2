import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final String? label;
  final double value;
  final Function(double)? onChanged;
  const SliderWidget({super.key, required this.value, this.onChanged, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${label ?? 'Slider'}: ${(value * 100).round()}%'),
        SizedBox(height: 2),
        Slider(value: value, onChanged: onChanged),
      ],
    );
  }
}
