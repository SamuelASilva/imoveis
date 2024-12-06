class Imovel {
  final String tipo;
  final String localizacao;
  final int preco;
  final int quartos;

  Imovel({
    required this.tipo,
    required this.localizacao,
    required this.preco,
    required this.quartos,
  });

  factory Imovel.fromJson(Map<String, dynamic> json) {
    return Imovel(
      tipo: json['tipo'],
      localizacao: json['localizacao'],
      preco: json['preco'],
      quartos: json['quartos'],
    );
  }
}
