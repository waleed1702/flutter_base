import 'package:flutter_riverpod_base/src/feature/login/controller/login_controller.dart';
import 'package:flutter_riverpod_base/src/feature/details/details_view.dart';
import 'package:flutter_riverpod_base/src/feature/home/c_home.dart';
import 'package:flutter_riverpod_base/src/models/m_products.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routePath = "/home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productProvider);
    final controller = ref.read(productProvider.notifier);
    final user = ref.read(loginViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(AppStrings.appName),
            const Spacer(),
            TextButton(
              onPressed: () {
                context.go(DetailsView.routePath);
              },
              child: const Text(AppStrings.profile),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              return productTile(
                controller: controller,
                context: context,
                product: state[index],
                userId: user.user!.id,
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _showAddProductBottomSheet(context, controller, user.user!.id),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditProductBottomSheet(
      BuildContext context, controller, String userid, DbProducts product) {
    final nameController = TextEditingController(text: product.name);
    final priceController = TextEditingController(text: product.price);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Product Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  final price = priceController.text;
                  if (name.isNotEmpty && price.isNotEmpty) {
                    controller.updateProduct(product.id, name, price, userid);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update Product'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddProductBottomSheet(
      BuildContext context, controller, String userid) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Product Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  final price = priceController.text;
                  if (name.isNotEmpty && price.isNotEmpty) {
                    controller.addProduct(name, price, userid);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Product'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget productTile({
    required ControllerHome controller,
    required BuildContext context,
    required DbProducts product,
    required String userId,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(product.name),
          Text(product.price),
          IconButton(
              onPressed: () => _showEditProductBottomSheet(
                  context, controller, userId, product),
              icon: const Icon(Icons.edit)),
          IconButton(
            onPressed: () => controller.removeProduct(product),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
