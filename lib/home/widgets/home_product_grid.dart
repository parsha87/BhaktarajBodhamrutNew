
import 'package:bodhamrut/home/widgets/product_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/bhajans.dart';
import '../data/repository/home_repository.dart';

class HomeProductGrid extends StatelessWidget {
  const HomeProductGrid({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<Bhajans> data;
  //final VoidCallback notifyUpdateIsFavourite;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 0.7,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,'/bhajanplay',arguments: {'index': index, 'data': data[index]},
              );
            },
            child: SizedBox(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [     
                      ProductInfo(
                        productTitle: data[index].displayName,
                        productSubtitle: data[index].alternateName,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
