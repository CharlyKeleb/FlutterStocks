import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_stocks/components/navigate.dart';
import 'package:flutter_stocks/view_models/trades_provider.dart';
import 'package:flutter_stocks/views/stock_details.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class StockTile extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final company;
  // ignore: prefer_typing_uninitialized_variables
  final index;
  const StockTile({Key? key, required this.company, required this.index})
      : super(key: key);

  @override
  State<StockTile> createState() => _StockTileState();
}

class _StockTileState extends State<StockTile> {
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
          ? const Text('')
          : ListTile(
              onTap: () => Navigate.pushPage(
                context,
                StockDetails(
                  trades: viewModel.trades,
                  company: widget.company.companies[widget.index],
                  index: widget.index,
                  // prices: viewModel.prices,
                ),
              ),
              leading: CircleAvatar(
                radius: 20.0,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Center(
                  child: Text(
                    widget.company.companies[widget.index].symbol!
                        .toString()
                        .substring(0, 2),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Text(
                widget.company.companies[widget.index].name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                widget.company.companies[widget.index].symbol!,
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: viewModel.loading
                  ? const Text('Loading')
                  : Column(
                      children: [
                        Text(
                          '\$${viewModel.trades[widget.index].open!}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                              getPercentage(viewModel)
                            ],
                          ),
                        )
                      ],
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
