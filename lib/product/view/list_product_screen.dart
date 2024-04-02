import 'package:contactapp/core/helper/price_converter.dart';
import 'package:contactapp/core/shared_components/bloc/theme_bloc.dart';
import 'package:contactapp/product/bloc/product_bloc.dart';
import 'package:contactapp/product/model/product_model.dart';
import 'package:contactapp/product/view/detail_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key? key}) : super(key: key);

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  late ProductBloc _productBloc;
  late ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();

    _productBloc = BlocProvider.of<ProductBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _productBloc.add(const ProductGetAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Products",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductSuccess) {
              return GridView.count(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 9 / 11,
                clipBehavior: Clip.antiAlias,
                children: List.generate(state.products.length, (index) {
                  Product product = state.products[index];
                  return Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _themeBloc.state is ThemeDark
                            ? Colors.white
                            : Colors.black38,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(
                          product.imageUrl,
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.topCenter,
                          height: 100,
                        ),
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                        Text(
                          priceConverter(product.price),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailProduct(product: product)),
                            );
                          },
                          style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(0),
                            minimumSize: MaterialStatePropertyAll(
                              Size.fromHeight(36),
                            ),
                            padding: MaterialStatePropertyAll(
                              EdgeInsets.all(8),
                            ),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                            ),
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.black,
                            ),
                          ),
                          child: const Text(
                            "Detail",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              );
            }

            if (state is ProductFailed) {
              return const Text("Failed");
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
