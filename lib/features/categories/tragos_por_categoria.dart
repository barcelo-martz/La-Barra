import '../../models/trago_categoria.dart';

final Map<String, List<TragoCategoria>> tragosPorCategoria = {
  'Clásicos': [
    TragoCategoria(
      nombre: 'Mojito',
      descripcion: 'Refrescante con menta y lima',
      categoria: 'Clásicos',
      ingredientes: ['Ron', 'Menta', 'Azúcar', 'Lima'],
      preparacion: 'Machacar menta, añadir ron y hielo',
      herramientas: ['Vaso largo', 'Mortero'],
      imagen: 'assets/images/mojito.png',
    ),
    TragoCategoria(
      nombre: 'Old Fashioned',
      descripcion: 'Whiskey con azúcar y bitters',
      categoria: 'Clásicos',
      ingredientes: ['Whiskey', 'Azúcar', 'Angostura'],
      preparacion: 'Mezclar en vaso corto con hielo',
      herramientas: ['Vaso corto', 'Cuchara'],
      imagen: 'assets/images/old_fashioned.png',
    ),
  ],
  'Tropicales': [
    TragoCategoria(
      nombre: 'Piña Colada',
      descripcion: 'Dulce y cremoso con piña',
      categoria: 'Tropicales',
      ingredientes: ['Ron', 'Piña', 'Coco'],
      preparacion: 'Licuar todo con hielo',
      herramientas: ['Licuadora', 'Vaso tropical'],
      imagen: 'assets/images/pina_colada.png',
    ),
    TragoCategoria(
      nombre: 'Mai Tai',
      descripcion: 'Ron con cítricos y almendra',
      categoria: 'Tropicales',
      ingredientes: ['Ron', 'Lima', 'Orgeat', 'Triple sec'],
      preparacion: 'Agitar y servir con hielo',
      herramientas: ['Coctelera', 'Vaso tiki'],
      imagen: 'assets/images/mai_tai.png',
    ),
  ],
  // Agrega más categorías...
};