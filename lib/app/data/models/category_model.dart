class CategoryModel {
  final int? id;
  final String? destination;
  final String? name;
  final String? minPrice;
  CategoryModel({
    this.id,
    this.minPrice,
    this.destination,
    this.name,
  });

  factory CategoryModel.fromJson(Map<dynamic, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      minPrice: json['min_price'].toString(),
      destination: json['destination'] ?? '',
    );
  }
}

class GetCategorySpec {
  int? _id;
  bool? _isMultiple;
  bool? _isRequired;
  bool? _onlyNumber;
  String? _name;
  int? _type;
  List<Values>? _values;

  GetCategorySpec({int? id, bool? isMultiple, bool? isRequired, bool? onlyNumber, String? name, int? type, List<Values>? values}) {
    if (id != null) {
      this._id = id;
    }
    if (isMultiple != null) {
      this._isMultiple = isMultiple;
    }
    if (isRequired != null) {
      this._isRequired = isRequired;
    }
    if (onlyNumber != null) {
      this._onlyNumber = onlyNumber;
    }
    if (name != null) {
      this._name = name;
    }
    if (type != null) {
      this._type = type;
    }
    if (values != null) {
      this._values = values;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  bool? get isMultiple => _isMultiple;
  set isMultiple(bool? isMultiple) => _isMultiple = isMultiple;
  bool? get isRequired => _isRequired;
  set isRequired(bool? isRequired) => _isRequired = isRequired;
  bool? get onlyNumber => _onlyNumber;
  set onlyNumber(bool? onlyNumber) => _onlyNumber = onlyNumber;
  String? get name => _name;
  set name(String? name) => _name = name;
  int? get type => _type;
  set type(int? type) => _type = type;
  List<Values>? get values => _values;
  set values(List<Values>? values) => _values = values;

  GetCategorySpec.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _isMultiple = json['is_multiple'];
    _isRequired = json['is_required'];
    _onlyNumber = json['only_number'];
    _name = json['name'];
    _type = json['type'];
    if (json['values'] != null) {
      _values = <Values>[];
      json['values'].forEach((v) {
        _values!.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['is_multiple'] = this._isMultiple;
    data['is_required'] = this._isRequired;
    data['only_number'] = this._onlyNumber;
    data['name'] = this._name;
    data['type'] = this._type;
    if (this._values != null) {
      data['values'] = this._values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  int? _id;
  String? _name;
  Values({int? id, String? name}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;

  Values.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    return data;
  }
}
