class ApiUrl {
  //this is our base url
  static const String baseUrl = 'http://disease.sh/v3/covid-19/';

  //fetch world covid states
  static const String worldStateApi = baseUrl + 'all';
  static const String countriesApi = baseUrl + 'countries';
}
