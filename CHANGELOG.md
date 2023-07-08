# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Latest] - Unreleased

## [v0.2.3] - 2023-07-08

### Added

- Check for new releases from github when app is opened
  - Download and prompt to install in android systems
- Created an abstraction layer over background tasks and notifications.
  - This should make it easier to implement any functionality that require them in the future.
- Added more interactivity to webview
  - Added url below title
  - Added 'Refresh' button
  - Added 'Open in browser' button
  - Added 'Share' button
- Added 'Clear history' button to delete all history in history tab
- Draw app below android system bottom navigation bar
  - This removes the black bar at bottom in android 13
- Added popup menu button to novel page
  - Added 'Refresh' button
  - Added 'Edit categories' button

### Changed

- Migrate auto_route to v7
- Selection AppBar is now always elevated
- Changed custom bottom bar elevation from 4 to 3
- Bluetooth is no longer recognized as a valid data connection
- Record chapter to reading history only when chapter is loaded
  - This prevents app from recording your attempt to read a chapter even though no content might have been loaded (ex: no internet connection)
- Switch to using default bottom sheet with handle bar
- Chapter list text in reader drawer is now smaller to show more chapters
- Clicking on 'In libary' button in novel page will now remove novel from all categories
- When popping state, change navigation index to `initialIndex` if `currentIndex` is not `initialIndex`
  - This is done to be more faithful to material 3 navigation
- Don't show default category in novel category picker dialog unless it is selected
- Open edit categories dialog in novel page on long press to 'In library'

### Fixed

- Correct name of android keystore file in workflow file
- Fixed novelpub.net novel scraping
- Fixed constraint error when deleting chapter
  - This is achieved by deleting all associated data when deleting chapter
- At end callback to load more in browse will now only be called if there is data #50
- Preload reader font so that there is no text jump when reader is initially opened
- Set reader status bar color according to reader theme (ex: dark on sepia even if app theme is dark)
- Don't allow 'pull-to-refresh' in updates page when selection is active
- Novel description can now be expanded or collapsed by clicking on the background behind description

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
