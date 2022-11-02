import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stocks/components/error/error_widget.dart';
import 'package:flutter_stocks/components/loading_indicator.dart';
import 'package:flutter_stocks/components/stock_card.dart';
import 'package:flutter_stocks/components/stock_tile.dart';
import 'package:flutter_stocks/utils/api/endpoints.dart';
import 'package:flutter_stocks/utils/extension.dart';
import 'package:flutter_stocks/view_models/company_provider.dart';
import 'package:flutter_stocks/view_models/theme_provider.dart';
import 'package:flutter_stocks/views/screens/search.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<AppProvider>(
          builder: (context, notifier, child) => InkWell(
              onTap: () {
                notifier.toggleTheme();
              },
              child: notifier.dark
                  ? const Icon(Ionicons.sunny)
                  : const Icon(Ionicons.moon)),
        ),
        centerTitle: true,
        title: const Text('Flutter Stocks'),
        actions: [
          IconButton(
            onPressed: () async {
              List companies = [];
              final url = Endpoints.companyURL;
              final response = await http.get(Uri.parse(url));
              final responseData = jsonDecode(response.body);
              for (var compItem in responseData["data"]) {
                companies.add(compItem);
              }
              showSearch(
                context: context,
                delegate: StockSearch(all: companies),
              );
            },
            icon: const Icon(Iconsax.search_normal),
          ).fadeInList(0, false),
          const SizedBox(width: 20.0),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Text(
                'Highest Stocks',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ).fadeInList(0, true),
            ),
            SizedBox(
              height: 185.0,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                  future: Provider.of<CompanyProvider>(context, listen: false)
                      .fetchAndSetCompanyItems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return loadingIndicator(context);
                    } else if (snapshot.error == null) {
                      return Consumer<CompanyProvider>(
                          builder: (context, company, _) {
                        return ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          itemBuilder: (BuildContext context, int index) {
                            return StockCard(
                              index: index,
                              company: company.companies[index],
                            ).fadeInList(index, false);
                          },
                        );
                      });
                    }
                    return MyErrorWidget(
                      refreshCallBack: () =>
                          Provider.of<CompanyProvider>(context, listen: false)
                              .fetchAndSetCompanyItems(),
                    );
                  }),
            ),
            ListTile(
              leading: const Text(
                'All Stocks',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ).fadeInList(1, true),
            ),
            SizedBox(
              height: 500,
              child: FutureBuilder(
                  future: Provider.of<CompanyProvider>(context, listen: false)
                      .fetchAndSetCompanyItems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return loadingIndicator(context);
                    } else if (snapshot.error == null) {
                      return Consumer<CompanyProvider>(
                          builder: (context, company, _) {
                        return ListView.builder(
                          itemCount: 10,
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          itemBuilder: (BuildContext context, int index) {
                            return StockTile(
                              company: company,
                              index: index,
                            ).fadeInList(index, false);
                          },
                        );
                      });
                    }
                    return MyErrorWidget(
                      refreshCallBack: () =>
                          Provider.of<CompanyProvider>(context, listen: false)
                              .fetchAndSetCompanyItems(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
