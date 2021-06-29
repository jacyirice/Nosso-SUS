class Ubs {
  final String id;
  final String nome;
  final String cidade;
  final String servico;
  final String link;
  final String loc_lat;
  final String loc_long;

  Ubs({
    required this.id,
    required this.nome,
    required this.cidade,
    required this.servico,
    required this.link,
    required this.loc_lat,
    required this.loc_long,
  });

  Ubs.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          nome: json['nome'],
          cidade: json['cidade'],
          servico: json['servico'],
          link: json['link'],
          loc_lat: json['loc_lat'],
          loc_long: json['loc_long'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cidade': cidade,
      'servico': servico,
      'link': link,
      'loc_lat': loc_lat,
      'loc_long': loc_long,
    };
  }
}
