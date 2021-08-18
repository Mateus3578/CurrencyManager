/// Formata uma string(valor) para salvar no db.
String formatValue(String value) {
  // TODO: Fazer algo melhor aqui
  String formattedValue = value;
  formattedValue = formattedValue.replaceAll("R\$", "");
  formattedValue = formattedValue.replaceAll(" ", "");
  formattedValue = formattedValue.replaceAll(",", "x");
  formattedValue = formattedValue.replaceAll(".", "");
  formattedValue = formattedValue.replaceAll("x", ".");
  return formattedValue;
}
