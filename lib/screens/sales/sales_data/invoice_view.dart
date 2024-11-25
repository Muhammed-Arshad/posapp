import 'package:flutter/material.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Supermart",
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text("Kochi"),
                            Text("987654321"),
                            Text("khadeejakp529@gmail.com"),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(thickness: 2),
                      // Invoice Details
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("25-11-2024 11:44 PM"),
                          Text("Invoice: 5"),
                        ],
                      ),
                      Divider(thickness: 2),
                      SizedBox(height: 16),

                      // Items Table
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                        },
                        border: TableBorder(
                          horizontalInside: BorderSide(color: Colors.black26),
                        ),
                        children: [
                          TableRow(children: [
                            Text("Item", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Qty", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Mrp", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                          TableRow(children: [
                            Text("Dummy Item 3"),
                            Text("1"),
                            Text("500"),
                            Text("450"),
                          ]),
                        ],
                      ),
                      Divider(thickness: 2),

                      // Subtotal
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Items: 1"),
                          Text("Sub Total: AED 450.00"),
                        ],
                      ),
                      Divider(thickness: 2),

                      // Total
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Total : 450.00",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("You saved AED 50.00 on this purchase"),
                          ],
                        ),
                      ),
                      Divider(thickness: 2),

                      // Payment Mode
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Payment Mode"),
                          Text("Online : AED 450.00"),
                        ],
                      ),
                      Divider(thickness: 2),

                      // Footer
                      Center(
                        child: Text("Thank You", style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(height: 16),
                      // Buttons

                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(int i=0;i<20;i++)
                  ClipPath(
                    clipper: TriangleClipper(),
                    child: Container(
                      color: Colors.white,
                      height: 10,
                      width: 20,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.home),
                    label: Text("New Sale"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.share),
                    label: Text("Share"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.print),
                    label: Text("Print Bill"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}








