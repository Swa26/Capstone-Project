import 'package:capstoneproject/cart.screen.dart';
import 'package:capstoneproject/components.dart';
import 'package:capstoneproject/main.dart';
import 'package:capstoneproject/orders.dart';
import 'package:capstoneproject/productsWidget.dart';
import 'package:capstoneproject/user_profile.dart';
import 'package:capstoneproject/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

String capitalizeS(str) {
  return '${str[0].toUpperCase()}${str.substring(1)}';
}

class CakeHomeView extends HookConsumerWidget {
  final List<Widget> screens = [ProductsWidget(), UserProfile()];
  final _page = useState(0);
  final ss = username.split('@')[0];

//String uname = ss.toString().capitalizeS();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final provider = ref.watch(stateProvider);
    final viewModelProvider = ref.watch(viewModel);
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
      //extendBody: true,
      backgroundColor: Color(0xffcceeed),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DrawerHeader(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset('assets/images/bolo.svg'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              elevation: 20.0,
              height: 50.0,
              minWidth: 200.0,
              color: Colors.yellowAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Orders(),
                ));
              },
              child: OpenSans(
                text: "Orders",
                color: Colors.black,
                size: 20.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              elevation: 20.0,
              height: 50.0,
              minWidth: 200.0,
              color: Colors.pink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () async {
                await viewModelProvider.logout();
              },
              child: OpenSans(
                text: "Logout",
                color: Colors.black,
                size: 20.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    launchUrl(
                      Uri.parse('https://www.instagram.com/swanand_joshi_/'),
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/images/icons8-instagram.svg',
                    width: 50.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    launchUrl(
                      Uri.parse('www.linkedin.com/in/swanand-joshi26'),
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/images/icons8-linkedin.svg',
                    width: 50.0,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Hello $ss'),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20.0,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                // builder: (context) => CartScreen(),
                builder: (context) => CartScreen(),
              ));
            },
            icon: Icon(Icons.shopping_cart),
            color: Colors.black,
          ),
        ],
        centerTitle: true,
      ),
      body: screens[_page.value],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _page.value,
        onTap: (index) {
          _page.value = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_max_outlined,
              color: Colors.black,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box,
              color: Colors.black,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final List<Widget> screen;
  final page;
  HomeScreen({super.key, required this.page, required this.screen});
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.pinkAccent,
            Colors.lightGreenAccent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: widget.screen[widget.page],
    );
  }
}
