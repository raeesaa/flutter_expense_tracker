import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state.toString());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void _addTransaction(String title, double amount, DateTime txDate) {
    Transaction newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: txDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where(
            (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (BuildContext bCtx) {
          return NewTransaction(_addTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _onChangeShowChart(val) {
    setState(() {
      _showChart = val;
    });
  }

  PreferredSizeWidget _buildiOSAppBar() {
    return CupertinoNavigationBar(
      middle: const Text(
        'Personal Expenses',
      ),
      trailing: GestureDetector(
        onTap: () => _startAddNewTransaction(context),
        child: const Icon(
          CupertinoIcons.add,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAndroidAppBar() {
    return AppBar(
      title: const Text(
        'Personal Expenses',
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
  }

  List<Widget> _buildLandscapeContent(
    double actualHeight,
    Widget txListWidget,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: _onChangeShowChart,
          ),
        ],
      ),
      _showChart
          ? Container(
              width: double.infinity,
              height: actualHeight * 0.7,
              child: Chart(_recentTransactions),
            )
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(double actualHeight, Widget txListWidget) {
    return [
      Container(
        width: double.infinity,
        height: actualHeight * 0.3,
        child: Chart(_recentTransactions),
      ),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar =
        Platform.isIOS ? _buildiOSAppBar() : _buildAndroidAppBar();

    var actualHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final txListWidget = Container(
      height: actualHeight * 0.65,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: Column(
        children: [
          if (isLandscape)
            ..._buildLandscapeContent(actualHeight, txListWidget),
          if (!isLandscape)
            ..._buildPortraitContent(actualHeight, txListWidget),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? null
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
  }
}
