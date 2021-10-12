![Lint & Test](https://github.com/luongvo/flutter-survey/actions/workflows/test.yml/badge.svg)

# flutter_survey

A new Flutter project.

## Prerequisite

- Flutter 2.2
- Flutter version manager (recommend): [fvm](https://fvm.app/)

## Getting Started

- Create these env files in the root directory according to the flavors and add the required
  environment variables into them. The example environment variable is in `.env.sample`.

  - Staging: `.env.staging`

  - Production: `.env`

- Generate project
  assets: `$ flutter packages pub run build_runner build --delete-conflicting-outputs`

- Run the app with the desire app flavor:

  - Staging: `$ fvm flutter run --flavor staging`

  - Production: `$ fvm flutter run --flavor production`

- Run unit testing:

  - `$ fvm flutter test .`

- Run integration testing:

  - // TODO
