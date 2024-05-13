import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:seller/authentication/auth_screen.dart';
import 'package:seller/global/global.dart';
import 'package:seller/model/menus.dart';
import 'package:seller/uploadScreens/menus_upload_screen.dart';
import 'package:seller/widgets/info_design.dart';
import 'package:seller/widgets/my_drawer.dart';
import 'package:seller/widgets/progress_bar.dart';
import 'package:seller/widgets/text_widget_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
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
        title: Text(
          sharedPreferences!.getString("name")!,
          style: const TextStyle(fontSize: 30, fontFamily: "Lobster"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add, color: Colors.cyan,),
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const MenusUploadScreen()));
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "My Menus")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(sharedPreferences!.getString("uid"))
                .collection("menus")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
    ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
    : SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            Menus model = Menus.fromJson(
              snapshot.data!.docs[index].data()! as Map<String, dynamic>,
            );
            return InfoDesignWidget(
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
