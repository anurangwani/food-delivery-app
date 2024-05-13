import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:user/assistantMethods/assistant_methods.dart';
import 'package:user/global/global.dart';
import 'package:user/models/menus.dart';
import 'package:user/models/sellers.dart';
import 'package:user/splashScreen/splash_screen.dart';
import 'package:user/widgets/menus_design.dart';
import 'package:user/widgets/sellers_design.dart';
import 'package:user/widgets/my_drawer.dart';
import 'package:user/widgets/progress_bar.dart';
import 'package:user/widgets/text_widget_header.dart';


class MenusScreen extends StatefulWidget
{
  final Sellers? model;
  MenusScreen({this.model});

  @override
  _MenusScreenState createState() => _MenusScreenState();
}



class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.cyan,
                  Colors.amber,
                ],
                begin:  FractionalOffset(0.0, 0.0),
                end:  FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: ()
          {
            clearCartNow(context);

            Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
          },
        ),
        title: const Text(
          "iFood",
          style: TextStyle(fontSize: 45, fontFamily: "Signatra"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "${widget.model!.sellerName} Menus")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellerUID)
                .collection("menus")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
               return !snapshot.hasData
      ? SliverToBoxAdapter(
          child: Center(child: circularProgress(),),
        )
      : SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              Menus model = Menus.fromJson(
                snapshot.data!.docs[index].data()! as Map<String, dynamic>,
              );
              return MenusDesignWidget(
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
