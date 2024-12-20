import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'productdetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:superhomemart2/page2/decakila.dart';
import 'package:superhomemart2/page2/jadever.dart';
import 'package:superhomemart2/page2/total.dart';
import 'package:superhomemart2/page2/ricota.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  bool _isSearching = false;
  bool _isLoading = true;
  List<dynamic> products = [];
  List<dynamic> displayedProducts = [];
  List<dynamic> searchResults = []; // รายการค้นหาที่ตรงกัน
  String searchQuery = ""; // คำค้นหาที่ผู้ใช้พิมพ์

  double _lastHeight = 0;

  // ตัวแปรสำหรับความสูงสูงสุดและความสูงปัจจุบัน
  final double _maxHeight = 20000;
  double _currentHeight = 1450;

  Future<void> fetchUsers() async {
    final String url = "http://superhomemart.duckdns.org:80/product";
    final String apiKey = "WHt)m6gpqxkF1r(oDczv8mq%";

    // ตรวจสอบสถานะการเชื่อมต่อ
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isLoading = false; // ปิดการโหลด
      });
      return; // ออกจากฟังก์ชันถ้าออฟไลน์
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'x-api-key': apiKey},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        // กรองข้อมูลที่มีสถานะเป็น 'on'
        setState(() {
          products =
              jsonData.where((product) => product["status"] == "on").toList();
          _isLoading = false;
        });

        for (var product in products) {
          await Future.delayed(const Duration(milliseconds: 50));
          setState(() {
            displayedProducts.add(product);
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _loadMoreProducts() {
    if (!_isLoading && displayedProducts.length < products.length) {
      setState(() {
        _isLoading = true;
      });

      double height = _scrollController.position.pixels;
      if (height - _lastHeight >= 100) {
        _lastHeight = height;

        // เพิ่มความสูงทีละ 1450 จนกว่าจะถึงความสูงสูงสุด
        if (_currentHeight < _maxHeight) {
          _currentHeight += 1450;
          if (_currentHeight > _maxHeight) {
            _currentHeight = _maxHeight; // ป้องกันไม่ให้เกิน
          }
        }

        // ดีเลย์ 0.4 วินาทีก่อนโหลดข้อมูลใหม่
        Future.delayed(const Duration(milliseconds: 400), () {
          int nextProductCount = displayedProducts.length + 10;
          if (nextProductCount > products.length) {
            nextProductCount = products.length;
          }

          setState(() {
            displayedProducts.addAll(
                products.getRange(displayedProducts.length, nextProductCount));
          });

          setState(() {
            _isLoading = false;
          });
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _searchProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        displayedProducts =
            List.from(products); // แสดงผลิตภัณฑ์ทั้งหมดถ้าไม่มีการค้นหา
      });
    } else {
      setState(() {
        displayedProducts = products.where((product) {
          return product["name"].toLowerCase().contains(query.toLowerCase());
        }).toList(); // กรองผลิตภัณฑ์ตามคำค้นหา
      });
    }
  }

  final List<String> _adImages = [
    'assets/10.10 Shopee.jpg',
    'assets/LAZADA 10.10 KOSANALAND.jpg',
    'assets/LAZADA 10.10 SUPER.jpg',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _adImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
    fetchUsers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToProductDetails(BuildContext context, var product) {
    String name = product["name"] ?? "No name available";
    String image = product["photo"] ?? "default.jpg";
    double price = (product["price"] is int)
        ? (product["price"] as int).toDouble()
        : product["price"] ?? 0.0;
    String sku = product["sku"] ?? "N/A";

    // เพิ่มข้อมูลที่ต้องการ
    String description = product["description"] ?? "No description available";
    String category = product["category"] ?? "No category available";
    int stock = product["stock"] ?? 0;
    String photo_1 = product["photo_1"] ?? "default.jpg";
    String photo_2 = product["photo_2"] ?? "default.jpg";
    String photo_3 = product["photo_3"] ?? "default.jpg";
    String photo_4 = product["photo_4"] ?? "default.jpg";
    String photo_5 = product["photo_5"] ?? "default.jpg";
    String photo_6 = product["photo_6"] ?? "default.jpg";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetails(
          name: name,
          image: image,
          price: price,
          sku: sku,
          description: description, // เพิ่มข้อมูล description
          category: category, // เพิ่มข้อมูล category
          stock: stock, // เพิ่มข้อมูล stock
          photo_1: photo_1,
          photo_2: photo_2,
          photo_3: photo_3,
          photo_4: photo_4,
          photo_5: photo_5,
          photo_6: photo_6,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _isSearching
            ? GestureDetector(
                onTap: () {
                  // เมื่อกดที่ช่องค้นหา จะไม่ทำอะไร
                },
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'search...',
                    border: InputBorder.none,
                    hintStyle:
                        TextStyle(color: Colors.black, fontFamily: 'Kanit'),
                  ),
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  onChanged: (value) {
                    _searchProducts(
                        value); // เรียกใช้ฟังก์ชันค้นหาเมื่อมีการพิมพ์
                  },
                ),
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    _isSearching = true; // เปิดโหมดค้นหาเมื่อกดที่ช่องค้นหา
                  });
                },
                child: const Text(
                  'Search',
                  style: TextStyle(color: Colors.grey, fontFamily: 'Kanit'),
                ),
              ),
        actions: [
          if (_isSearching)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _isSearching = false; // ปิดโหมดค้นหา
                  displayedProducts = List.from(
                      products); // แสดงผลิตภัณฑ์ทั้งหมดเมื่อปิดการค้นหา
                });
              },
            ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 5,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _adImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(_adImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                _isLoading
                    ? Container()
                    : Container(
                        height: 100,
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing:
                                MediaQuery.of(context).size.width * 0.016,
                            mainAxisSpacing:
                                MediaQuery.of(context).size.width * 0.016,
                          ),
                          itemCount: displayedProducts.length,
                          itemBuilder: (context, index) {
                            final product = displayedProducts[index];
                            String imageAsset = [
                              'http://superhomemart.duckdns.org/upload/DECAKILA@2x.png',
                              'http://superhomemart.duckdns.org/upload/JADEVER@2x.png',
                              'http://superhomemart.duckdns.org/upload/TOTAL@2x.png',
                              'http://superhomemart.duckdns.org/upload/RICOTA_O.png'
                            ][index % 4];

                            return InkWell(
                              onTap: () {
                                // นำทางไปยังหน้าที่เหมาะสมตาม URL ของภาพ
                                switch (imageAsset) {
                                  case 'http://superhomemart.duckdns.org/upload/DECAKILA@2x.png':
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DecakilaCategoryPage()),
                                    );
                                    break;
                                  case 'http://superhomemart.duckdns.org/upload/JADEVER@2x.png':
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              JadeverCategoryPage()),
                                    );
                                    break;
                                  case 'http://superhomemart.duckdns.org/upload/TOTAL@2x.png':
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TotalCategoryPage()),
                                    );
                                    break;
                                  case 'http://superhomemart.duckdns.org/upload/RICOTA_O.png':
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RicotaCategoryPage()),
                                    );
                                    break;
                                  default:
                                    // คุณสามารถจัดการกรณีที่ไม่มี URL ที่ตรงกันได้ที่นี่
                                    print('Unknown image asset: $imageAsset');
                                    break;
                                }
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.23,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      imageAsset,
                                      height: 50,
                                    ),
                                    const SizedBox(height: 5),
                                    // แสดงชื่อแบรนด์
                                    Text(
                                      product["brand"] ?? '', // แสดงชื่อแบรนด์
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                Container(
                  height: _currentHeight, // ใช้ความสูงปัจจุบัน
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: displayedProducts.length,
                    itemBuilder: (context, index) {
                      final product = displayedProducts[index];
                      return InkWell(
                        onTap: () {
                          _navigateToProductDetails(context, product);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                "http://superhomemart.duckdns.org:80/upload/${product["photo"]}",
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product["name"],
                                style: const TextStyle(fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${product["price"]}฿', // แสดงราคาโดยไม่ใช้ $ และใช้เฉพาะ ฿
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
