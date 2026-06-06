import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 6),
        TextFieldWidget(label: 'Picture'),
        SizedBox(height: 16),
        TextFieldWidget(label: 'Name'),
        SizedBox(height: 16),
        TextFieldWidget(label: 'Type'),
        SizedBox(height: 16),
      ],
    );
  }
}
