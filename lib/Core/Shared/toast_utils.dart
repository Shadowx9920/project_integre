import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class ToastUtils {
  static void showSuccessToast(String message, BuildContext context) =>
      MotionToast.success(
        description: Text(message),
      ).show(context);

  static void showErrorToast(String message, BuildContext context) =>
      MotionToast.error(
        description: Text(message),
      ).show(context);

  static void showInfoToast(String message, BuildContext context) =>
      MotionToast.info(
        description: Text(message),
      ).show(context);

  static void showWarningToast(String message, BuildContext context) =>
      MotionToast.warning(
        description: Text(message),
      ).show(context);

  static void showDeleteToast(String message, BuildContext context) =>
      MotionToast.delete(
        description: Text(message),
      ).show(context);
}
