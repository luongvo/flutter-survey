![Lint & Test](https://github.com/luongvo/flutter-survey/actions/workflows/test.yml/badge.svg)
[![codecov](https://codecov.io/gh/luongvo/flutter-survey/branch/develop/graph/badge.svg?token=Q16QDY3936)](https://codecov.io/gh/luongvo/flutter-survey)

# flutter_survey

A new Flutter project.

## Prerequisite

- Flutter 2.2
- Flutter version manager (recommend): [fvm](https://fvm.app/)

## Getting Started

### Setup

- Create these `.env` files in the root directory according to the flavors and add the required environment variables
  into them. The example environment variable is in `.env.sample`.

  - Staging: `.env.staging`

  - Production: `.env`

- Run code generator

  - `$ fvm flutter packages pub run build_runner build --delete-conflicting-outputs`

### Run

- Run the app with the desire app flavor:

  - Staging: `$ fvm flutter run --flavor staging`

  - Production: `$ fvm flutter run --flavor production`

### Test

- Run unit testing:

  - `$ fvm flutter test .`

- Run integration testing with emulator:

  - `$ fvm flutter drive --driver=test_driver/integration_test_driver.dart --flavor staging --target=integration_test/{test_file}.dart`
