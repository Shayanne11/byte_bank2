
class Contact{
  final int id;
  final String name;
  final int accountNumber;

  Contact(
      this.id, // estão sem chaves, então são obrigatórios ( para tornar opcional coloque chaves{} e coloque no final da lista de parametros.).
      this.name,
      this.accountNumber,
      );

  @override
  String toString() {
    return 'Contact { id: $id, name: $name, accountNumber: $accountNumber,}';
  }
}