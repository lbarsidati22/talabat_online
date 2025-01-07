class LoactionItemModel {
  final String id;
  final String city;
  final String country;
  final String imgUrl;
  final bool isChosen;

  LoactionItemModel({
    this.isChosen = false,
    required this.id,
    required this.city,
    required this.country,
    this.imgUrl =
        'https://previews.123rf.com/images/emojoez/emojoez1903/emojoez190300018/119684277-illustrations-design-concept-location-maps-with-road-follow-route-for-destination-drive-by-gps.jpg',
  });

  LoactionItemModel copyWith({
    String? id,
    String? city,
    String? country,
    String? imgUrl,
    bool? isChosen,
  }) {
    return LoactionItemModel(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      imgUrl: imgUrl ?? this.imgUrl,
      isChosen: isChosen ?? this.isChosen,
    );
  }
}

List<LoactionItemModel> dummyLocations = [
  LoactionItemModel(
    id: '1',
    city: 'Nouakchott',
    country: 'Mauritania',
  ),
  LoactionItemModel(
    id: '2',
    city: 'Nema',
    country: 'Mauritania',
  ),
  LoactionItemModel(
    id: '3',
    city: 'Trarza',
    country: 'Mauritania',
  ),
];
