import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    super.key,
    required Widget title,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    TextStyle? style,
    bool initialValue = false,
    ListTileControlAffinity? trailing,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                activeColor: Colors.purple[900],
                dense: state.hasError,
                title: title,
                value: state.value,
                onChanged: state.didChange,
                subtitle: state.hasError
                    ? Text(
                        Constants.errorText,
                        style: style,
                      )
                    : null,
                controlAffinity: trailing ?? ListTileControlAffinity.leading,
              );
            });
}
