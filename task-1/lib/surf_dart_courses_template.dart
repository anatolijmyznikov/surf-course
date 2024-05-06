enum Countries { brazil, russia, turkish, spain, japan }

class Territory {
  final int areaInHectare;
  final List<String> crops;
  final List<AgriculturalMachinery> machineries;

  Territory(
    this.areaInHectare,
    this.crops,
    this.machineries,
  );
}

class AgriculturalMachinery {
  final String id;
  final DateTime releaseDate;

  AgriculturalMachinery(
    this.id,
    this.releaseDate,
  );

  /// Переопределяем оператор "==", чтобы сравнивать объекты по значению.
  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        (other is AgriculturalMachinery &&
            other.id == id &&
            other.releaseDate == releaseDate);
  }

  @override
  int get hashCode => Object.hashAll([id, releaseDate]);
}

final mapBefore2010 = <Countries, List<Territory>>{
  Countries.brazil: [
    Territory(
      34,
      ['Кукуруза'],
      [
        AgriculturalMachinery(
          'Трактор Степан',
          DateTime(2001),
        ),
        AgriculturalMachinery(
          'Культиватор Сережа',
          DateTime(2007),
        ),
      ],
    ),
  ],
  Countries.russia: [
    Territory(
      14,
      ['Картофель'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Гранулятор Антон',
          DateTime(2009),
        ),
      ],
    ),
    Territory(
      19,
      ['Лук'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Дробилка Маша',
          DateTime(1990),
        ),
      ],
    ),
  ],
  Countries.turkish: [
    Territory(
      43,
      ['Хмель'],
      [
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
        AgriculturalMachinery(
          'Сепаратор Марк',
          DateTime(2005),
        ),
      ],
    ),
  ],
};

final mapAfter2010 = {
  Countries.turkish: [
    Territory(
      22,
      ['Чай'],
      [
        AgriculturalMachinery(
          'Каток Кирилл',
          DateTime(2018),
        ),
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
      ],
    ),
  ],
  Countries.japan: [
    Territory(
      3,
      ['Рис'],
      [
        AgriculturalMachinery(
          'Гидравлический молот Лена',
          DateTime(2014),
        ),
      ],
    ),
  ],
  Countries.spain: [
    Territory(
      29,
      ['Арбузы'],
      [
        AgriculturalMachinery(
          'Мини-погрузчик Максим',
          DateTime(2011),
        ),
      ],
    ),
    Territory(
      11,
      ['Табак'],
      [
        AgriculturalMachinery(
          'Окучник Саша',
          DateTime(2010),
        ),
      ],
    ),
  ],
};

void main() {
  // Объединяем данные из обоих хранилищ
  final allTerritories = [
    ...mapBefore2010.values.expand((territories) => territories),
    ...mapAfter2010.values.expand((territories) => territories)
  ];

  // Список для хранения всех единиц техники
  final allMachineries = <AgriculturalMachinery>[];

  // Добавляем все единицы техники в один список
  for (final territory in allTerritories) {
    allMachineries.addAll(territory.machineries);
  }

  // Создаем множество, чтобы убрать дубликаты
  Set<AgriculturalMachinery> allMachineriesSet = allMachineries.toSet();

  // Преобразуем множество в список перед передачей в функцию
  final allMachineriesList = allMachineriesSet.toList();

  // Вычисляем средний возраст всей техники
  final averageAge = _calculateAverageAge(allMachineriesList);
  print('Средний возраст всей техники: ${averageAge.toStringAsFixed(0)} лет');

  // Сортируем технику по возрасту
  allMachineriesList.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));

  // Находим средний возраст 50% самой старой техники
  final oldestMachineries =
      allMachineriesSet.take((allMachineriesSet.length * 0.5).ceil());
  final averageAgeOfOldestMachineries =
      _calculateAverageAge(oldestMachineries.toList());
  print(
      'Средний возраст 50% самой старой техники: ${averageAgeOfOldestMachineries.toStringAsFixed(0)} лет');
}

// Функция для вычисления среднего возраста техники
double _calculateAverageAge(List<AgriculturalMachinery> machineries) {
  final now = DateTime.now();
  final totalYears = machineries.fold<int>(
      0, (sum, machinery) => sum + (now.year - machinery.releaseDate.year));
  return totalYears / machineries.length;
}
