class AboutUsModel {
  final String? phone1;
  final String? phone2;
  final String? aboutUs;
  AboutUsModel({
    this.phone1,
    this.phone2,
    this.aboutUs,
  });

  factory AboutUsModel.fromJson(Map<dynamic, dynamic> json) {
    return AboutUsModel(
      phone1: '+993${json['phone_1'] ?? ''}',
      phone2: '+993${json['phone_2'] ?? ''}',
      aboutUs: json['about_us'] ?? '',
    );
  }
}

class FaqModel {
  final int? id;
  final String? question;
  final String? answer;
  FaqModel({
    this.id,
    this.question,
    this.answer,
  });

  factory FaqModel.fromJson(Map<dynamic, dynamic> json) {
    return FaqModel(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }
}
