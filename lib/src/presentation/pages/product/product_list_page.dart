import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class ProductListPage extends StatefulWidget {
  final Function(String productId) onSelectProduct;
  const ProductListPage({super.key, required this.onSelectProduct});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Product List', style: Theme.of(context).textTheme.titleMedium),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: 20),
            ConstrainedBox(constraints: BoxConstraints(maxWidth: 400), child: TextFieldWidget(label: 'Search')),
            SizedBox(width: 20),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              showCheckboxColumn: false,
              columns: <DataColumn>[
                DataColumn(
                  columnWidth: IntrinsicColumnWidth(flex: 3),
                  label: Expanded(child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                DataColumn(
                  columnWidth: IntrinsicColumnWidth(flex: 3),
                  label: Expanded(child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                DataColumn(
                  columnWidth: IntrinsicColumnWidth(flex: 1),
                  label: Text('', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
              rows: <DataRow>[
                for (int i = 0; i < 40; i++)
                  DataRow(
                    onSelectChanged: (val) {
                      widget.onSelectProduct('');
                    },
                    cells: <DataCell>[
                      DataCell(Text('泥濘鳴鳴')),
                      DataCell(Text('Keychain / Music')),
                      DataCell(IconButton(icon: Icon(Icons.more_vert), onPressed: () {})),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
