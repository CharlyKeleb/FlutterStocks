import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_stocks/components/line_chart.dart';
import 'package:flutter_stocks/utils/constants.dart';
import 'package:flutter_stocks/view_models/trades_provider.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class StockCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final company;
  final int index;
  const StockCard({Key? key, required this.company, required this.index})
      : super(key: key);

  @override
  State<StockCard> createState() => _StockCardState();
}

class _StockCardState extends State<StockCard> {
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
    return Consumer<TradeProvider>(builder:
        (BuildContext context, TradeProvider viewModel, Widget? child) {
      return viewModel.loading
          ? const Center(child: Text(''))
          : Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SizedBox(
                height: 155.0,
                width: 200.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            child: Center(
                              child: Text(
                                widget.company.symbol!
                                    .toString()
                                    .substring(0, 2),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 20.0,
                            width: 100.0,
                            child: LineChartWidget(
                              data: Constants().demoGraphData,
                              color: viewModel.trades[widget.index].open! >
                                      viewModel.trades[widget.index].close!
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        widget.company.symbol,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        widget.company.name,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 20.0),
                      //trade and stocks section
                      viewModel.loading
                          ? const Text('Loading')
                          : Row(
                              children: [
                                Text(
                                  viewModel.trades[widget.index].open
                                      .toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                viewModel.trades[widget.index].open! >
                                        viewModel.trades[widget.index].close!
                                    ? Icon(
                                        Ionicons.caret_up,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      )
                                    : const Icon(
                                        Ionicons.caret_down,
                                        color: Colors.red,
                                      ),
                                getPercentage(viewModel),
                              ],
                            )
                    ],
                  ),
                ),
              ),
            );
    });
  }

  getPercentage(TradeProvider provider) {
    var percentage = provider.trades[widget.index].open! -
        provider.trades[widget.index].close!;
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
