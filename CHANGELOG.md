# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Latest] - Unreleased

## [v0.2.2] - 2023-02-11

### Added

- Added scrollbar to update page and browse page.
- Added ability to download for offline reading.
  - Limitation: Does not run on the background.

### Changed

- Change all appbars to fixed mode.
- Added controller to history page.
- Override theme of `ListTile` instead of using a modified `ListTile` class.
- Increase `CustomBottomBar` width to 72.
- Animated description and tags expansion.
- Update expandable bottom sheet to be more faithful to m3.

### Fixed

- Set android compile target to 33.
- No longer set app to immersive mode in reader, due to some problems animation problems.
- Removed double scaffold from updates page.
- Fix color on novel card selection check mark and background.

## [v0.2.1] - 2022-12-29

### Added

- Added dynamic color support.

### Changed

- Delete novel history using 'IS IN' clause.
- Apply navigation transition to the whole view.
- Changed bottom bar to curved and to be bigger.
- Changed novel page appbar to fixed.

### Fixed

- Apply fixes from dart analysis.
- Fixed bottom bar animation.
- Show all ui overlays when exiting the reader.

## [v0.2.0] - 2022-10-25

This is the first stable release to the public. As such,
this changelog will be a bit different from the rest to come.

### Features

This section details all the features that are currently implemented that
I think is worth highlighting.

- Read from 3 novel sources with varying browse capability.
- Add novels to library and categorize them.
- Track your reading with history.
- Check for updates one at a time or all novels in library at once.
- Basic customizable novel reader
