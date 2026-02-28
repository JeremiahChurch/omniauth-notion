# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2026-02-28

### Breaking Changes
- Requires OmniAuth 2.x (`~> 2.0`). Users on OmniAuth 1.x should pin `omniauth-notion ~> 0.0.3`.

### Fixed
- Declare `omniauth-oauth2 ~> 1.8` as an explicit dependency (it was previously undeclared but required at runtime).

### Security
- OmniAuth 2.x resolves [CVE-2015-9284](https://github.com/omniauth/omniauth/wiki/Resolving-CVE-2015-9284), a CSRF vulnerability present in OmniAuth 1.x.

Closes #7.

## [0.0.3] - 2022-02-09

- Update auth params to install at the user level (#6)

## [0.0.2] - 2021-06-01

- Initial public release
