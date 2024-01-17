class Model {
  final int id;
  final String imagePath;
  final String name;

  Model({
    required this.id,
    required this.imagePath,
    required this.name,
  });
}

List<Model> navBtn = [
  Model(id: 0, imagePath: 'assets/assets/position.png', name: 'Home'),
  Model(id: 1, imagePath: 'assets/assets/delivery.png', name: 'Search'),
  Model(id: 2, imagePath: 'assets/assets/img.png', name: 'Like'),
  Model(id: 3, imagePath: 'assets/assets/warning.png', name: 'notification'),
  Model(id: 4, imagePath: 'assets/assets/service.png', name: 'Profile'),
];