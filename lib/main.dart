import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarTablePage(),
    ));

class Car {
  final String make;
  final String model;
  final int price;

  const Car(this.make, this.model, this.price);
}

const List<Car> cars = [
  Car('Toyota', 'Corolla', 95000),
  Car('Honda', 'Civic', 110000),
  Car('Proton', 'Saga', 45000),
  Car('Perodua', 'Myvi', 62000),
  Car('Mazda', 'CX-5', 150000),
  Car('BMW', '320i', 240000),
];

class CarTablePage extends StatefulWidget {
  const CarTablePage({super.key});

  @override
  State<CarTablePage> createState() => _CarTablePageState();
}

class _CarTablePageState extends State<CarTablePage> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  late List<Car> _rows;

  @override
  void initState() {
    super.initState();
    _rows = List.of(cars);
  }

  void _sortBy(Comparable Function(Car) field, int columnIndex, bool ascending) {
    setState(() {
      _rows.sort((a, b) {
        final result = field(a).compareTo(field(b));
        return ascending ? result : -result;
      });
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Car List')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: [
            DataColumn(
              label: const Text('Car Make'),
              onSort: (i, asc) => _sortBy((c) => c.make, i, asc),
            ),
            DataColumn(
              label: const Text('Model'),
              onSort: (i, asc) => _sortBy((c) => c.model, i, asc),
            ),
            DataColumn(
              label: const Text('Price (RM)'),
              numeric: true,
              onSort: (i, asc) => _sortBy((c) => c.price, i, asc),
            ),
          ],
          rows: _rows
              .map((c) => DataRow(cells: [
                    DataCell(Text(c.make)),
                    DataCell(Text(c.model)),
                    DataCell(Text('${c.price}')),
                  ]))
              .toList(),
        ),
      ),
    );
  }
}