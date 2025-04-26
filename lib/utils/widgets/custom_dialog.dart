import 'package:flutter/material.dart';
import 'package:quicknsol_assignment/utils/config/app_colors.dart';

class CutomDialog extends StatelessWidget {
  final VoidCallback tapy;
  final VoidCallback tapn;
  CutomDialog({
    super.key,
    required this.tapy,
    required this.tapn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Icon(
                      Icons.error,
                      size: 50,
                    ),
                    const Text(
                      "Are You sure?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Do you really want to delete this user? You will not to be undo this action.",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    //Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              child: const Text(
                                'NO',
                              ),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(0, 40),
                                shape: StadiumBorder(
                                    side: BorderSide(color: lightPrimaryColor)),
                              ),
                              onPressed: tapn),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: ElevatedButton(
                                child: const Text(
                                  'YES',
                                ),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: const Color(0xFFFFFFFF),
                                  backgroundColor: lightPrimaryColor,
                                  minimumSize: const Size(0, 40),
                                  shape: StadiumBorder(),
                                ),
                                onPressed: tapy)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
