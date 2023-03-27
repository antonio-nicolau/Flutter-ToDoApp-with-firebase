import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoDatePicker {
  final BuildContext context;
  final GlobalKey<FormState>? formKey;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final Function(DateTime)? onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final TextEditingController? controller;
  final DateFormat? dateFormat;
  DateTime? initialDate;

  TodoDatePicker({
    required this.context,
    this.formKey,
    this.labelText = 'Select Date',
    this.hintText,
    this.validator,
    this.onChanged,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.controller,
    this.dateFormat,
  });

  Future<void> show() async {
    initialDate = initialDate ?? DateTime.now();

    if (controller?.text.isNotEmpty == true && dateFormat != null) {
      initialDate = dateFormat?.parse(controller!.text);
    }

    await _showDatePickerByPlatform();
  }

  /// This builds material date picker for Android
  Future<void> _buildMaterialDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate!,
      firstDate: firstDate!,
      lastDate: lastDate ?? DateTime(DateTime.now().year + 20),
    );
    if (picked != null) {
      if (onChanged != null) onChanged?.call(picked);
    }
  }

  /// This builds cupertino date picker for iOS
  void _buildCupertinoDatePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext builder) {
        return ColoredBox(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      if (controller?.text == '') {
                        controller?.text = dateFormat?.format(initialDate ?? DateTime.now()) ?? '';
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text('Done'),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3.5,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (picked) {
                    if (onChanged != null) onChanged?.call(picked);
                  },
                  initialDateTime: initialDate,
                  minimumYear: firstDate?.year ?? DateTime(1800).year,
                  maximumYear: lastDate?.year,
                  maximumDate: initialDate != null ? lastDate : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showDatePickerByPlatform() async {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return _buildMaterialDatePicker();
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return _buildCupertinoDatePicker();
    }
  }
}
