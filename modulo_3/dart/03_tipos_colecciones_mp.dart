void main() {
  List<String> vocabulario = ['Konnichiwa', 'Sayonara', 'Arigatou'];
  var puntajes = [85, 90, 75, 100];

  print(vocabulario[0]);
  print(vocabulario.length);
  vocabulario.add('Onegai');
  vocabulario.remove('Sayonara');

  Map<String, int> rachaEstudiantes = {
    'Henry': 15,
    'Maria': 30,
    'Pedro': 5,
  };

  print(rachaEstudiantes['Henry']);
  rachaEstudiantes['Ana'] = 45;

  Set<String> idiomasDisponibles = {'Ingles', 'Frances', 'Japones'};
  idiomasDisponibles.add('Ingles');
  print(idiomasDisponibles.length);

  var palabrasBasicas = ['Sol', 'Luna'];
  var palabrasAvanzadas = ['Galaxia', 'Nebulosa'];
  var todoElVocabulario = [...palabrasBasicas, ...palabrasAvanzadas];
  print(todoElVocabulario);

  bool suscripcionPremium = true;
  var beneficios = [
    'Lecciones basicas',
    'Examenes de nivel',
    if (suscripcionPremium) 'Clases en vivo',
  ];

  var nivelesXP = [for (var i = 1; i <= 5; i++) i * 1000];
  print(nivelesXP);
}
