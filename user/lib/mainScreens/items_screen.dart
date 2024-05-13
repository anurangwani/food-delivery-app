import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:user/global/global.dart';
import 'package:user/models/items.dart';
import 'package:user/models/menus.dart';
import 'package:user/widgets/app_bar.dart';
import 'package:user/widgets/items_design.dart';
import 'package:user/widgets/sellers_design.dart';
import 'package:user/widgets/my_drawer.dart';
import 'package:user/widgets/progress_bar.dart';
import 'package:user/widgets/text_widget_header.dart';


class ItemsScreen extends StatefulWidget
{
  final Menus? model;
  ItemsScreen({this.model});

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}



class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "Items of " + widget.model!.menuTitle.toString())),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellerUID)
                .collection("menus")
                .doc(widget.model!.menuID)
                .collection("items")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
    ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
    : SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            Items model = Items.fromJson(
              snapshot.data!.docs[index].data()! as Map<String, dynamic>,
            );
            return ItemsDesignWidget(
              model: model,
              context: context,
            );
          },
          childCount: snapshot.data!.docs.length,
        ),
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 1,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: [
            const QuiltedGridTile(1, 1),
          ],
        ),
      );
            },
          ),
        ],
      ),
    );
  }
}
