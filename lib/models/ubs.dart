class Ubs {
  final String id;
  final String nome;
  final String cidade;
  final String servico;
  final String link;
  final String locLat;
  final String locLong;

  Ubs({
    required this.id,
    required this.nome,
    required this.cidade,
    required this.servico,
    required this.link,
    required this.locLat,
    required this.locLong,
  });

  Ubs.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          nome: json['nome'],
          cidade: json['cidade'],
          servico: json['servico'],
          link: json['link'],
          locLat: json['loc_lat'],
          locLong: json['loc_long'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cidade': cidade,
      'servico': servico,
      'link': link,
      'loc_lat': locLat,
      'loc_long': locLong,
    };
  }
}
