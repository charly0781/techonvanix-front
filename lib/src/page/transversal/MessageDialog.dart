
import 'package:flutter/material.dart';

import '../../dto/library/ApiResponse.dart';


class MessageDialog {

  static Future<void> showMessage(
      BuildContext context, {
        required String title,
        required String message,
        String? confirmButtonText,
        String? cancelButtonText,
        Function()? onConfirm,
        Function()? onCancel,
      }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            if (cancelButtonText != null)
              TextButton(
                onPressed: onCancel ??
                        () {
                      Navigator.of(context).pop();
                    },
                child: Text(cancelButtonText),
              ),
            if (confirmButtonText != null)
              TextButton(
                onPressed: onConfirm ??
                        () {
                      Navigator.of(context).pop();
                    },
                child: Text(confirmButtonText),
              ),
          ],
        );
      },
    );
  }

  /// Método para manejar respuesta de API (éxito o error) con botones personalizados
  static Future<void> handleApiResponse(
      BuildContext context,
      ApiResponse apiResponse, {
        String? successButtonText,
        String? errorConfirmButtonText,
        String? errorCancelButtonText,
        Function()? onSuccess,
        Function()? onFailure,
      }) {
    if (apiResponse.code == 200) {
      // Si la respuesta es exitosa
      return showMessage(
        context,
        title: "Éxito",
        message: apiResponse.message,
        confirmButtonText: successButtonText ?? "Aceptar",
        onConfirm: onSuccess,
      );
    } else {
      // Si hubo un error
      return showMessage(
        context,
        title: "Error",
        message: apiResponse.message,
        confirmButtonText: errorConfirmButtonText ?? "Aceptar",
        cancelButtonText: errorCancelButtonText ?? "Cancelar",
        onConfirm: onFailure,
      );
    }
  }
}
