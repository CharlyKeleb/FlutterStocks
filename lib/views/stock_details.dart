// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_stocks/utils/extension.dart';
import 'package:flutter_stocks/view_models/trades_provider.dart';
import 'package:flutter_stocks/widgets/line_chart_description.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class StockDetails extends StatefulWidget {
  final company;
  final trades;
  final index;
  const StockDetails(
      {Key? key,
      required this.company,
      required this.trades,
      required this.index})
      : super(key: key);

  @override
  State<StockDetails> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  List<double> prices = [];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<TradeProvider>(context, listen: false)
          .fetchAndSetTradeItems(widget.company.symbol),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.keyboard_backspace),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: const Center(
                  child: Text(
                    'NY',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Text(
                widget.company.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ).fadeInList(0, false),
              subtitle: Text(
                widget.company.symbol,
                style: const TextStyle(color: Colors.grey),
              ).fadeInList(1, false),
              trailing: Padding(
                padding: const EdgeInsets.all(10.0),
                child: const Icon(Iconsax.chart).fadeInList(2, false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SizedBox(
                  height: 500.0,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20.0),
                        Text(
                          '\$${widget.trades[widget.index].open}',
                          style: const TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            getIncrement(),
                            const SizedBox(width: 20.0),
                            widget.trades[widget.index].open! >
                                    widget.trades[widget.index].close!
                                ? Icon(
                                    Ionicons.caret_up,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  )
                                : const Icon(
                                    Ionicons.caret_down,
                                    color: Colors.red,
                                  ),
                            getPercentage(),
                            const SizedBox(width: 20.0),
                            const CircleAvatar(
                              radius: 2.0,
                              backgroundColor: Colors.grey,
                            ),
                            const SizedBox(width: 5.0),
                            const Text(
                              'Fast Month',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Text(
                                'Date: ${widget.trades[widget.index].date.toString().split("T")[0]}'),
                            const SizedBox(width: 5.0),
                            const CircleAvatar(
                              radius: 2.0,
                              backgroundColor: Colors.grey,
                            ),
                            const SizedBox(width: 5.0),
                            const Text(
                              'DISCLAIMER',
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 250.0,
                          child: LineChartDescriptionWidget(data: prices),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton.icon(
                                  onPressed: () {},
                                  icon: const Text(
                                    'Open',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  label: Text(
                                    widget.trades[widget.index].open.toString(),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () {},
                                  icon: const Text(
                                    'High',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  label: Text(
                                    widget.trades[widget.index].high.toString(),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          const  Padding(
                              padding:  EdgeInsets.only(top:15.0),
                              child:  SizedBox(
                                height: 70.0,
                                width: 3.0,
                                child: VerticalDivider(
                                  thickness: 2.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton.icon(
                                  onPressed: () {},
                                  icon: const Text(
                                    'Close',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  label: Text(
                                    widget.trades[widget.index].close
                                        .toString(),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () {},
                                  icon: const Text(
                                    'Volume',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  label: Text(
                                    widget.trades[widget.index].volume
                                        .toString(),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getIncrement() {
    for (var i = 0; i < widget.trades.length; i++) {
      prices.add(widget.trades[i].close);
    }
    var percentage =
        widget.trades[widget.index].high! - widget.trades[widget.index].low!;
    return Text(
      '+ ${percentage.toStringAsFixed(2)}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  getPercentage() {
    var percentage =
        widget.trades[widget.index].open! - widget.trades[widget.index].close!;
    return Text(
      '${percentage.toStringAsFixed(2)}%',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: percentage.toStringAsFixed(2).contains('-')
            ? Colors.red
            : Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
