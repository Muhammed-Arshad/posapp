import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/provider/sale_provider/sales_provider.dart';

class MenuModel {
  final String title;
  MenuModel({required this.title});
}

class Menu extends StatefulWidget {
  // final GlobalKey<ScaffoldState> scaffoldKey;

  // const Menu({super.key, required this.scaffoldKey});
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

//menu page widgets..
class _MenuState extends State<Menu> {
  List<MenuModel> menu = [
    MenuModel(title: "Sales"),
    MenuModel(title: "Add stocks"),
    MenuModel(title: "All Stocks"),
    MenuModel(title: "Settings"),
    MenuModel(title: "About"),
    MenuModel(title: "Exit"),
  ];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Colors.grey[800]!,
                width: 1,
              ),
            ),
            color: const Color(0xFF171821)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text('ARR -POS'.toUpperCase()),
                ),
              ),
              SizedBox(
                // height: Responsive.isMobile(context) ? 40 : 80,
                height: 80,
              ),
              for (var i = 0; i < menu.length; i++)
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final selected = ref.watch(selectedMenuProvider);

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                        color: selected == i
                            ? Theme.of(context).primaryColor.withOpacity(0.9)
                            : Colors.transparent,
                      ),
                      child: InkWell(
                        onTap: () {
                          ref.read(selectedMenuProvider.notifier).state = i;
                          // widget.scaffoldKey.currentState!.closeDrawer();
                        },
                        child: Row(
                          children: [
                            Text(
                              menu[i].title,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: selected == i
                                      ? Colors.black
                                      : Colors.grey,
                                  fontWeight: selected == i
                                      ? FontWeight.w600
                                      : FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          )),
        ),
      ),
    );
  }
}
