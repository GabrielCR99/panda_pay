import 'package:flutter/material.dart';
import 'package:pandapay/models/business_type_model.dart';

class BusinessButtons extends StatelessWidget {
  final OrderBy initialValue;
  final FormFieldSetter<OrderBy> onSaved;

  BusinessButtons({this.initialValue, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return FormField<OrderBy>(
      initialValue: initialValue,
      onSaved: onSaved,
      builder: (FormFieldState state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                state.didChange(OrderBy.TO_ME);
              },
              child: Container(
                child: Text(
                  'PARA MIM',
                  style: TextStyle(
                    color: state.value == OrderBy.TO_ME
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
                alignment: Alignment.center,
                width: 160,
                height: 50,
                decoration: BoxDecoration(
                  color: state.value == OrderBy.TO_ME
                      ? Color(0xFF13CE66)
                      : Colors.white,
                  border: Border.all(
                      color: state.value == OrderBy.TO_ME
                          ? Colors.transparent
                          : Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 40.0),
            GestureDetector(
              onTap: () {
                state.didChange(OrderBy.TO_MY_BUSINESS);
              },
              child: Container(
                child: Text(
                  'PARA MEU NEGÓCIO',
                  style: TextStyle(
                    color: state.value == OrderBy.TO_MY_BUSINESS
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
                alignment: Alignment.center,
                width: 160,
                height: 50,
                decoration: BoxDecoration(
                  color: state.value == OrderBy.TO_MY_BUSINESS
                      ? Color(0xFF13CE66)
                      : Colors.white,
                  border: Border.all(
                      color: state.value == OrderBy.TO_MY_BUSINESS
                          ? Colors.transparent
                          : Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
