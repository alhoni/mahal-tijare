import 'package:flutter/material.dart';
import 'package:mahal_tijare/constants.dart';
import '../models/Product.dart';
//import '../models/Category.dart';
import 'widgets/categories.dart';
import 'widgets/new_arrival.dart';
import 'widgets/popular.dart';
import 'widgets/search_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String searchQuery = '';
  RangeValues _priceRange = const RangeValues(0, 1000);
  Category? _selectedCategory;
  //List<Category> _selectedCategories = [];

  void _onSearchQueryChanged(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  // void toggleCategory(Category category) {
  //   setState(() {
  //     if (_selectedCategories.contains(category)) {
  //       _selectedCategories.remove(category);
  //     } else {
  //       _selectedCategories.add(category);
  //     }
  //   });
  // }

  // void _onPriceRangeChanged(RangeValues values) {
  //   state(() {});
  //   setState(() {
  //     _priceRange = values;
  //   });
  // }

  void _clearFilters() {
    setState(() {
      _priceRange = const RangeValues(0, 1000);
      searchQuery = '';
      _selectedCategory = null;
    });
    Navigator.pop(context); // Close bottom sheet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.black,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.black,
            ),
            const SizedBox(
              width: defaultPadding / 2,
            ),
            Text(
              "شارع عمر المختار",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        actions: [
          Container(
            width: 50,
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.notifications,
          //     color: Colors.black,
          //   ),
          // ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('أكرم الهوني'),
              accountEmail: Text('akramhoni@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/premium-vector/young-smiling-man-avatar-man-with-brown-beard-mustache-hair-wearing-yellow-sweater-sweatshirt-3d-vector-people-character-illustration-cartoon-minimal-style_365941-860.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('المفضلة'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the settings screen.
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('تسجيل الخروج'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the help screen.
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "استكشف",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                    ),
                    const Text(
                      "أفضل الملابس التي تناسبك",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: SearchForm(
                onQueryChanged: _onSearchQueryChanged,
                onFilterPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'الفلتر',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: _clearFilters,
                                  child: const Text('الغاء'),
                                ),
                              ],
                            ),
                            const SizedBox(height: defaultPadding),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'الصنف',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                StatefulBuilder(builder: (context, state) {
                                  return DropdownButton<Category>(
                                    value: _selectedCategory,
                                    onChanged: (Category? newValue) {
                                      state(() {});
                                      setState(() {
                                        _selectedCategory = newValue;
                                      });
                                    },
                                    items: Category.values
                                        .map<DropdownMenuItem<Category>>(
                                            (Category value) {
                                      return DropdownMenuItem<Category>(
                                        value: value,
                                        child: Text(value.name
                                            .toString()
                                            .split('.')
                                            .last),
                                      );
                                    }).toList(),
                                  );
                                })
                              ],
                            ),
                            const SizedBox(height: defaultPadding * 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'السعر',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '0 - 1000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: defaultPadding),
                            StatefulBuilder(builder: (context, state) {
                              return RangeSlider(
                                values: _priceRange,
                                min: 0,
                                max: 1000,
                                divisions: 20,
                                labels: RangeLabels(
                                  _priceRange.start.round().toString(),
                                  _priceRange.end.round().toString(),
                                ),
                                onChanged: (RangeValues values) {
                                  state(() {});
                                  setState(() {
                                    _priceRange = values;
                                  });
                                },
                              );
                            }),
                            // const SizedBox(height: defaultPadding),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pop(context);
                            //   },
                            //   child: const Text('Apply'),
                            // ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            //const Categories(),
            // const SizedBox(
            //   height: defaultPadding,
            // ),
            //const NewArrival(),
            const SizedBox(
              height: defaultPadding,
            ),
            Expanded(
                child: Popular(
              searchQuery: searchQuery,
              priceRange: _priceRange,
              selectedCategory: _selectedCategory,
            )),
          ],
        ),
      ),
    );
  }
}
