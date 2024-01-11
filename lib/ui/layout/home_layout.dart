import 'package:deepstatemanagment/provider/route_provider.dart';
import 'package:deepstatemanagment/ui/dialog/create_product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Clean layout implementation.
class HomeLayout extends ConsumerWidget {
  final Widget child;

  const HomeLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final routeP = ref.watch(routeProvider.notifier);

    return Scaffold(

      /// Probably to create a AppBar widget.
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('MOC APP',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ElevatedButton(
                child: const Text("New Product"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CreateProductForm();
                      });
                },
              ),
            )
          ],
        ),

      ),

      body: child,

      /// Simple bottom navigation bar implementation.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: routeP.route,
        onTap: (index) {
          routeP.setRoute(index);
          index == 0 ? context.push('/') : context.push('/trades');
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.store_outlined,
              ),
              label: 'Products',
              activeIcon: Icon(
                Icons.store,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.insert_chart_outlined,
              ),
              label: 'Trades',
              activeIcon: Icon(
                Icons.insert_chart,
              )),
        ],
      ),
    );
  }
}
