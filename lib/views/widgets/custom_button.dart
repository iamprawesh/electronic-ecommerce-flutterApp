import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final double? width;
  final bool disable;

  CustomButtom({
    this.disable = false,
    @required this.onPressed,
    @required this.text,
    @required this.width,
  });

  Widget build(BuildContext context) {
    return InkWell(
      onTap: disable ? () {} : onPressed,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: disable ? Colors.grey : Theme.of(context).primaryColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 1,
                offset: Offset(1, 2), // Shadow position
              ),
            ],
          ),
          width: width,
          child: Center(
            child: Text(
              text ?? "",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: .7,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
    // return MaterialButton(
    //   onPressed: onPressed,
    //   height: 40.0,
    //   minWidth: 70.0,
    //   elevation: 3,
    //   child: Ink(
    //     width: double.infinity * .7,
    //     decoration: BoxDecoration(
    //       color: Theme.of(context).primaryColor,
    //       // gradient: gradient,
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //     child: Container(
    //         // constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
    //         alignment: Alignment.center,
    //         child: Text(text ?? "")),
    //   ),
    //   splashColor: Colors.black12,
    //   padding: EdgeInsets.all(0),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: new BorderRadius.circular(32.0),
    //   ),
    // );
  }
}
