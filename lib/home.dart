import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animationCard;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationCard =
        Tween<double>(begin: 0, end: 100).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _onTap() {
    if (_animationController.value > 0) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  _onTap2() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Widget _buttonAnimated() {
    return GestureDetector(
      onTap: _onTap2,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isLoading ? 50 : 10),
          color: Colors.blue,
        ),
        width: isLoading ? 50 : 250,
        height: 50,
        alignment: Alignment.center,
        child: AnimatedCrossFade(
          crossFadeState:
              isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 600),
          firstChild: Text(
            'Button',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          secondChild: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _column() {
    return GestureDetector(
      onTap: _onTap,
      child: Column(
        children: <Widget>[
          _animatedCard(),
          SizedBox(height: 10),
          _buttonAnimated(),
        ],
      ),
    );
  }

  Widget _card() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 80,
      color: Colors.blue,
      child: Text(
        'Card',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _animatedCard() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.green,
              ),
              onPressed: () {},
            ),
          ],
        ),
        AnimatedBuilder(
          animation: _animationCard,
          child: _card(),
          builder: (BuildContext context, Widget child) {
            return Transform.translate(
              offset: Offset(_animationCard.value, 0.0),
              child: child,
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Animated Widgets Example'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _column(),
          ],
        ),
      ),
    );
  }
}
