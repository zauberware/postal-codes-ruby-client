# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [v0.1.5] - 2026-04-08

### Added

- Add RuboCop configuration for code style enforcement

### Changed

- Untrack Gemfile.lock from git (recommended for gems)
- Add Gemfile.lock to .gitignore

## [v0.1.4] - 2026-04-08

### Changed

- Add `bundler/gem_tasks` to Rakefile to enable `rake release`
- Update GitHub Actions release workflow

## [v0.1.3] - 2026-04-08

### Changed

- Rename gem from `postal_codes_client` to `postal_codes_ruby_client`
- Restructure lib directory to match new gem name
- Remove auth resource references and related specs
- Update README and gemspec accordingly

## [v0.1.2] - 2026-04-08

### Fixed

- Remove stale auth reference from main require file

## [v0.1.1] - 2026-04-08

### Added

- Add GitHub Actions workflow for automated gem releases to RubyGems.org

## [v0.1.0] - 2026-04-08

### Added

- Initial release
- Ruby client for the PLZ (Postleitzahlen) API
- Support for postal code search across 100+ countries
- Authentication support
- Configurable base URL and timeout
- RSpec test suite

[Unreleased]: https://github.com/zauberware/postal-codes-ruby-client/compare/v0.1.5...HEAD
[v0.1.5]: https://github.com/zauberware/postal-codes-ruby-client/compare/v0.1.4...v0.1.5
[v0.1.4]: https://github.com/zauberware/postal-codes-ruby-client/compare/v0.1.3...v0.1.4
[v0.1.3]: https://github.com/zauberware/postal-codes-ruby-client/compare/v0.1.2...v0.1.3
[v0.1.2]: https://github.com/zauberware/postal-codes-ruby-client/compare/v0.1.1...v0.1.2
[v0.1.1]: https://github.com/zauberware/postal-codes-ruby-client/compare/v0.1.0...v0.1.1
[v0.1.0]: https://github.com/zauberware/postal-codes-ruby-client/releases/tag/v0.1.0
