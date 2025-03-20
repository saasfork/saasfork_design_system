class DialogData {
  final String desactivateButton;
  final String activateButton;

  DialogData({required this.desactivateButton, required this.activateButton});

  Map<String, String> toMap() {
    return {
      'desactivate_button': desactivateButton,
      'activate_button': activateButton,
    };
  }
}
