enum Flavor {
  PRODUCTION,
  STAGING,
}

class F {
  static Flavor? appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'Flutter Survey';
      default:
        return 'Flutter Survey - Staging';
    }
  }

  static String get restApiEndpoint {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'https://survey-api.nimblehq.co/api/';
      default:
        return 'https://nimble-survey-web-staging.herokuapp.com/api/';
    }
  }

  static String get basicAuthClientId {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return '6GbE8dhoz519l2N_F99StqoOs6Tcmm1rXgda4q__rIw';
      default:
        return 'z9iUamZLvRgtVVtRJ8UqItg2vmncGyEi30p1eWEddnA';
    }
  }

  static String get basicAuthClientSecret {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return '_ayfIm7BeUAhx2W1OUqi20fwO3uNxfo1QstyKlFCgHw';
      default:
        return '1vqRNMxq-Yx83A61GNjLb17qxCGKxHDb8EmB3MKdxqA';
    }
  }
}
