class Address {
  String city;
  String street;
  int number;
  int zipcode;
  Geolocation geolocation;
  Address(this.city, this.street, this.number, this.zipcode, this.geolocation);
}

class Geolocation {
  double lat;
  double long;
  Geolocation(this.lat, this.long);
}
