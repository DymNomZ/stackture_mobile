import 'package:flutter/material.dart';

class ShakingTextField extends StatefulWidget {
  TextInputType? type;
  String label, hint, errorText;

  ShakingTextField({
    super.key, this.type, 
    required this.label, required this.hint, required this.errorText
  });

  @override
  ShakingTextFieldState createState() => ShakingTextFieldState();
}

class ShakingTextFieldState extends State<ShakingTextField>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  bool _isError = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticIn,
    ));

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      }
    });
  }

  String getText() => _controller.text;

  bool validateAndShake() {
    setState(() {
      if (_controller.text.isEmpty) {
        _isError = true;
        _animationController.forward();
      } else {
        _isError = false;
      }
    });
    return !_isError;
  }

  bool checkIfMatch(String password) {
    setState(() {
      if(password != _controller.text){
        _isError = true;
        _animationController.forward();
      } else {
        _isError = false;
      }
    });
    return !_isError;
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            double translateX = 0;
            if (_isError) {
              translateX = 20 *
                  (0.5 - _animation.value) *
                  (1 - (_animationController.value * 2).abs());
            }
            return Transform.translate(
              offset: Offset(translateX, 0),
              child: TextField(
                keyboardType: widget.type,
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: widget.hint,
                  hintStyle:  TextStyle(
                    fontSize: 15, color: Colors.black, letterSpacing: 1.5,
                    fontWeight: FontWeight.bold, fontFamily: 'VarelaRounded'
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                        color: _isError ? Colors.red : Colors.blue),
                  ),
                  errorText: _isError ? widget.errorText : null,
                  errorStyle: TextStyle(
                    fontSize: 13, color: Colors.red, letterSpacing: 1.5,
                    fontWeight: FontWeight.bold, fontFamily: 'VarelaRounded',
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                        color: _isError ? Colors.red : Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                        color: _isError ? Colors.red : Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                        color: _isError ? Colors.red : Colors.grey),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}