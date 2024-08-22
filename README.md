# bgbazzar

## TODO List

- Set a fexed size for ad images and perform other optimizations on images to reduce resource consumption on the Parse Server.

## Getting Started


# ChangeLog

## 2024/08/22 - version: 0.6.18+46

Update ShoppingHooks with FavoritesScreen integration and minor visual enhancements. Files Modified:

1. `lib/features/my_account/widgets/shopping_hooks.dart`
   - Added: Import statement for `FavoritesScreen`.
   - Modified: Updated `TitleProduct` widget in the ShoppingHooks with the theme's primary color for consistency.
   - Updated: The ListTile for 'Favoritos' now navigates to the `FavoritesScreen` when tapped, using `Navigator.pushNamed`. The color of the icon and text has been set to the primary color for visual coherence.
 
This update introduces navigation to the `FavoritesScreen` from the ShoppingHooks and enhances the visual consistency by applying the primary theme color to specific UI elements. Additionally, the project version has been incremented to ensure proper version control.


## 2024/08/22 - version: 0.6.17+45

Update: Improvements and Refactoring Across Multiple Components. Files and Changes:

1. `lib/common/utils/utils.dart`
   - Added `normalizeFileName` method to standardize filenames by removing accents, replacing spaces with underscores, and removing invalid characters.
   - Introduced `_removeDiacritics` method to handle accent removal for various special characters.

2. `lib/components/others_widgets/spin_box_field.dart`
   - Enhanced initialization logic to ensure the correct value is set in the `NumericEditController` when it's initially zero but should reflect a non-zero value.

3. `lib/features/edit_boardgame/edit_boardgame_screen.dart`
   - Added floating action buttons for saving and canceling operations.
   - Refined UI layout to improve user experience, including the addition of a save and cancel action bar at the bottom.

4. `lib/features/mechanics/mechanics_controller.dart`
   - Refactored to use private fields for better encapsulation.
   - Added `selectMechByName` method for selecting a mechanic by its name.
   - Introduced `toogleDescription` method to show or hide mechanic descriptions.
   - Replaced redundant state management with simplified boolean flags.

5. `lib/features/mechanics/mechanics_screen.dart`
   - Updated the UI to include search functionality with the new `SearchMechsDelegate`.
   - Replaced old mechanics selection logic with a more robust implementation that includes options for showing descriptions and toggling selected items.

6. `lib/features/mechanics/widgets/search_mechs_delegate.dart`
   - Introduced a new widget to provide a search interface for mechanics, allowing for case-sensitive and insensitive searches.

7. `lib/features/mechanics/widgets/show_all_mechs.dart`
   - Updated to handle displaying all mechanics with options to hide descriptions and highlight selected items.

8. `lib/features/mechanics/widgets/show_selected_mechs.dart` -> `lib/features/mechanics/widgets/show_only_selected_mechs.dart`
   - Renamed file and updated logic to better reflect the functionality of displaying only selected mechanics.

9. `lib/manager/boardgames_manager.dart`
   - Added `normalizeFileName` usage when saving board games to ensure filenames are correctly formatted.
   - Introduced `_sortingBGNames` method to keep the list of board games sorted alphabetically by name after any modification.

10. `lib/manager/mechanics_manager.dart`
    - Added `mechanicOfName` method to retrieve mechanics by their name.
    - Updated internal logic to ensure consistency with other components.

11. `lib/repository/parse_server/ps_ad_repository.dart`
    - Updated error logging messages to reflect the correct repository class (`PSAdRepository`) for easier debugging.

12. `lib/repository/parse_server/ps_boardgame_repository.dart`
    - Incorporated `normalizeFileName` into image saving logic to ensure filenames are standardized.
    - Updated error handling to provide clearer exception messages.

This commit introduces various improvements, including new utility methods for filename normalization, enhancements to the mechanics selection process, and improved error handling across multiple repositories. The changes ensure a more consistent and user-friendly experience, with better management of filenames and mechanic data.


## 2024/08/20 - version: 0.6.17+44

Update: Refactor Mechanics IDs and Various Model Updates. Files and Changes:

1. `lib/common/models/ad.dart`
   - Updated `mechanicsId` from `List<int>` to `List<String>` to reflect changes in ID management.

2. `lib/common/models/boardgame.dart`
   - Renamed the `id` field to `bgId`.
   - Updated `mechanics` to `mechsPsIds`, changing the type from `List<int>` to `List<String>`.

3. `lib/common/models/filter.dart`
   - Changed `mechanicsId` to `mechanicsPsId` and updated its type from `List<int>` to `List<String>`.

4. `lib/common/settings/local_server.dart`
   - Added `keyParseServerImageUrl` to manage image URLs more efficiently.

5. `lib/common/singletons/app_settings.dart`
   - Enhanced `_saveBright()` to save brightness settings as 'dark' or 'light' strings.

6. `lib/components/custon_field_controllers/numeric_edit_controller.dart`
   - Improved the `numericValue` setter to better manage old values and trigger appropriate UI updates.

7. `lib/components/others_widgets/spin_box_field.dart`
   - Refactored to use generics, allowing support for both `int` and `double` types in `SpinBoxField`.

8. `lib/features/boardgame/boardgame_screen.dart`
   - Refined the floating action button to allow for multiple actions with tooltips for better UX.

9. `lib/features/edit_ad/edit_ad_controller.dart`
   - Updated `setMechanicsIds()` to `setMechanicsPsIds()` to handle the new `String` ID format.

10. `lib/features/edit_ad/widgets/ad_form.dart`
    - Refactored to use the new `setMechanicsPsIds()` method.

11. `lib/features/edit_boardgame/edit_boardgame_controller.dart`
    - Updated mechanics handling to reflect changes from `int` to `String` for IDs.
    - Introduced a method for updating existing board games.

12. `lib/features/edit_boardgame/edit_boardgame_screen.dart`
    - Modified the initialization to pass `BoardgameModel` objects where applicable.

13. `lib/features/filters/filters_controller.dart`
    - Changed `selectedMechIds` from `List<int>` to `List<String>`.
    - Updated method calls to align with this change.

14. `lib/features/filters/filters_screen.dart`
    - Refined the mechanics selection process to handle `String` IDs.

15. `lib/features/mechanics/mechanics_controller.dart`
    - Adapted the controller to work with `String` IDs.
    - Updated methods for selecting and managing mechanics.

16. `lib/features/mechanics/mechanics_screen.dart`
    - Updated arguments and state management to work with `String` IDs instead of `int`.

17. `lib/features/mechanics/widgets/show_all_mechs.dart`
    - Refined to handle `String` IDs, ensuring compatibility with the rest of the application.

18. `lib/features/my_account/widgets/admin_hooks.dart`
    - Adjusted to pass `String` IDs in the navigation arguments for mechanics management.

19. `lib/manager/boardgames_manager.dart`
    - Implemented `update()` method to handle board game updates with the new `String` ID format.
    - Renamed `saveNewBoardgame()` to `save()` for consistency.

20. `lib/manager/mechanics_manager.dart`
    - Updated to handle `String` IDs for mechanics.
    - Modified the `add()` method to return the new mechanic after saving it to the server.

21. `lib/my_material_app.dart`
    - Adjusted routes to pass `BoardgameModel` objects where required.
    - Updated mechanics selection to handle `String` IDs.

22. `lib/repository/parse_server/common/constants.dart`
    - Removed the now redundant `keyMechId` constant.

23. `lib/repository/parse_server/common/parse_to_model.dart`
    - Updated parsing logic to handle `String` IDs for mechanics and board games.

24. `lib/repository/parse_server/ps_ad_repository.dart`
    - Refined to work with `String` IDs for mechanics within advertisements.

25. `lib/repository/parse_server/ps_boardgame_repository.dart`
    - Implemented an `update()` method for board games, ensuring proper handling of the new `String` IDs.

26. `lib/repository/parse_server/ps_mechanics_repository.dart`
    - Changed method names and return types to work with `String` IDs.
    - Removed the setting of `mechId` in the `add()` method, now relying on `objectId`.

27. `lib/store/constants/migration_sql_scripts.dart`
    - Added a placeholder for a future migration script (version 1002).

28. `lib/store/stores/mechanics_store.dart`
    - Updated queries to include the new `mechPSId` column.

This commit introduces significant changes to the handling of mechanics and board game IDs across the codebase, migrating from `int` to `String` IDs for better compatibility with the Parse server. The update also includes improvements in UI components and overall data management.


## 2024/08/20 - version: 0.6.17+43


Update: Android Manifest, Database Management, and Various Model Enhancements. Files and Changes:

1. `android/app/src/main/AndroidManifest.xml`
   - Added necessary permissions (INTERNET, CAMERA, READ/WRITE_EXTERNAL_STORAGE) as comments for potential future use.
   - Integrated `UCropActivity` for image cropping functionality.

2. `assets/data/bgBazzar.db`
   - Updated database file to include new or modified data.

3. `lib/common/constants/shared_preferenses.dart`
   - Created new constants for managing shared preferences keys (`keySearchHistory`, `keyLocalDBVersion`, `keyBrightness`).

4. `lib/common/models/ad.dart`
   - Reformatted the `toString` method for better readability, adding line breaks between fields.

5. `lib/common/models/mechanic.dart`
   - Added a new `psId` field to the `MechanicModel`.
   - Updated the `toMap`, `fromMap`, and `toString` methods to reflect this change.

6. `lib/common/singletons/app_settings.dart`
   - Implemented methods to manage and persist app settings, including brightness mode and local database version.
   - Enhanced initialization with shared preferences support.

7. `lib/common/singletons/search_history.dart`
   - Updated to use the new shared preferences constants for managing search history.

8. `lib/common/theme/theme.dart`
   - Minor adjustment: changed `scaffoldBackgroundColor` to use `colorScheme.surface` instead of `colorScheme.background`.

9. `lib/components/buttons/big_button.dart`
   - Added support for an optional icon in the `BigButton` widget, allowing more customization.

10. `lib/components/others_widgets/state_error_message.dart`
    - Enhanced the `StateErrorMessage` widget to accept a custom error message.

11. `lib/features/boardgame/boardgame_screen.dart`
    - Fixed an issue where the floating action button was displayed incorrectly based on the user’s admin status.

12. `lib/features/edit_ad/edit_ad_controller.dart`
    - Improved the `setBgInfo` method to handle potential errors when retrieving board game data.
    - Added error handling and updated the UI accordingly.

13. `lib/features/edit_ad/edit_ad_screen.dart`
    - Updated UI labels and buttons to reflect the current context (e.g., "Salvar" vs. "Atualizar").
    - Integrated new icon options for buttons.

14. `lib/features/edit_ad/widgets/ad_form.dart`
    - Refactored the method for retrieving board game information, ensuring proper error handling and feedback.

15. `lib/features/my_account/my_account_screen.dart`
    - Simplified the code by renaming variables for consistency (`currentUser` to `user`).
    - Updated the logout process to use the newly named variable.

16. `lib/get_it.dart`
    - Adjusted imports to reflect the reorganization of the database management files.

17. `lib/main.dart`
    - Added initialization for the database provider to handle migrations and backups.

18. `lib/repository/sqlite/bg_names_repository.dart`
    - Updated the import paths following the reorganization of store files.

19. `lib/repository/sqlite/mechanic_repository.dart`
    - Updated the import paths following the reorganization of store files.

20. `lib/store/constants/constants.dart`
    - Added constants for new database fields (`mechPSId`) and indices.

21. `lib/store/constants/migration_sql_scripts.dart`
    - Added a new script for migrating the database to version 1001, including adding a `psId` field to the `Mechanics` table.

22. `lib/store/database/database_backup.dart`
    - Created a utility class to handle database backups and restoration.

23. `lib/store/database/database_manager.dart`
    - Renamed and refactored to improve database initialization and management processes.

24. `lib/store/database/database_migration.dart`
    - Added a new class to manage database migrations, applying necessary changes to keep the database schema up-to-date.

25. `lib/store/database/database_provider.dart`
    - Created a provider class to handle database initialization, including applying migrations and managing backups.

26. `lib/store/database/database_util.dart`
    - Added utility functions to manage database directories and configurations, abstracting platform-specific logic.

27. `lib/store/bg_names_store.dart` and `lib/store/mechanics_store.dart`
    - Updated paths and imports following the reorganization of the store files.

This commit includes significant updates across various components, focusing on database management, error handling, and UI/UX improvements. It also lays the groundwork for future enhancements by implementing robust database migration and backup strategies.


## 2024/08/15 - version: 0.6.17+42

Refactor: Enhance Theme, Boardgame, Mechanics, and My Account Features. 
Files and Changes:

1. `lib/common/theme/theme.dart`
   - Adjusted color scheme values across different themes to improve visual consistency.
   - Updated the primary, secondary, and tertiary color tones for better contrast and readability.
   - Modified the scaffold background color to match the updated theme configurations.

2. `lib/components/form_fields/custom_form_field.dart`
   - Added `minLines` property support for text fields to allow dynamic height adjustment based on content.

3. `lib/features/boardgame/boardgame_controller.dart`
   - Implemented `getBoardgameSelected` method to retrieve details of the selected board game.
   - Added a method to fetch a board game by its ID and return the corresponding model.

4. `lib/features/boardgame/boardgame_screen.dart`
   - Integrated new actions in the UI to allow adding, editing, and viewing board games directly from the screen.
   - Updated the floating action button behavior to reflect the current user’s role (admin or regular user).

5. `lib/features/boardgame/widgets/bg_info_card.dart`
   - Removed outdated code related to displaying board game views and scoring.

6. `lib/features/boardgame/widgets/view_boardgame.dart`
   - Created a new widget to display detailed information about a board game in a dedicated screen.

7. `lib/features/edit_boardgame/edit_boardgame_screen.dart`
   - Fixed a bug that prevented the screen from closing after saving a board game.
   - Streamlined the on-submit logic for fetching board game information.

8. `lib/features/mechanics/mechanics_controller.dart`
   - Introduced a counter to track and display the number of selected mechanics.
   - Implemented logic to update the counter and reflect the current selection status.

9. `lib/features/mechanics/mechanics_screen.dart`
   - Enhanced the UI to display the number of selected mechanics in the app bar title.
   - Improved the layout and padding for the mechanics list view.

10. `lib/features/mechanics/widgets/mechanic_dialog.dart`
    - Added `minLines` and `maxLines` properties to the description text field for better usability.

11. `lib/manager/boardgames_manager.dart`
    - Added a method to fetch and return a board game by its ID.
    - Streamlined the board game addition process, including saving to the local database and updating the in-memory list.

12. `lib/manager/mechanics_manager.dart`
    - Added methods to sort and update the mechanics list after adding new items to ensure alphabetical order.
    - Separated the logic for adding mechanics to the local and Parse Server databases.

13. `lib/my_material_app.dart`
    - Registered a new route for the `ViewBoardgame` screen.
    - Enhanced the app’s routing logic to handle navigation to the new board game view screen.

14. `lib/features/my_account/my_account_screen.dart`
    - Added a brightness toggle action to the app bar, allowing users to switch between light and dark modes.

This commit introduces various enhancements across the theme settings, board game management, and user interface components. It also includes new functionality for viewing board games and improving the mechanics selection process, ensuring a more seamless and user-friendly experience.


## 2024/08/15 - version: 0.6.17+41

Refactor: Update Boardgame Models and Controller Logic. Files and Changes:

1. `lib/common/models/bg_name.dart`
   - Added the `toString` method to the `BGNameModel` class for easier debugging.
   - Included a new directive to ignore `public_member_api_docs` and `sort_constructors_first` lint warnings.

2. `lib/common/models/boardgame.dart`
   - Removed the `scoring` field from the `BoardgameModel` class as it is no longer required.
   - Updated the `toString` method to reflect the removal of the `scoring` field.

3. `lib/features/boardgame/boardgame_controller.dart`
   - Refactored the controller to manage the search and selection of board games.
   - Removed the `bgName` text controller and replaced the search functionality with a more efficient filtering method.
   - Added methods to manage search filters and handle the selection of board games by their ID.

4. `lib/features/boardgame/boardgame_screen.dart`
   - Updated the UI to use the new filtering mechanism for displaying and selecting board games.
   - Integrated a search dialog to allow users to search for board games by name.
   - Removed the outdated text field and search button for a more streamlined search experience.

5. `lib/repository/parse_server/common/constants.dart`
   - Removed the `keyBgScoring` constant as it is no longer used.

6. `lib/repository/parse_server/common/parse_to_model.dart`
   - Updated the `boardgameModel` method to properly parse the list of mechanics from the Parse Server response.

7. `lib/repository/parse_server/ps_boardgame_repository.dart`
   - Removed the `scoring` field from the methods interacting with the Parse Server.
   - Improved the `getById` method to handle cases where no results are found more gracefully.
   - Corrected error handling and logging in the `getNames` method.

This commit introduces significant improvements to the board game management logic, streamlining the search and selection process. The changes include removing unused fields, enhancing data parsing, and updating the user interface to provide a more efficient and user-friendly experience.


## 2024/08/15 - version: 0.6.16+40

Refactor: Rename and Reorganize Boardgame Search and Management. Files and Changes:

1. `lib/features/bg_search/bg_search_controller.dart` -> `lib/features/boardgame/boardgame_controller.dart`
   - Renamed file and class from `BgController` to `BoardgameController`.
   - Updated the state management references from `BgSearchState` to `BoardgameState`.

2. `lib/features/bg_search/bg_search_screen.dart` -> `lib/features/boardgame/boardgame_screen.dart`
   - Renamed file and class from `BgSearchScreen` to `BoardgameScreen`.
   - Updated route name and widget class names accordingly.

3. `lib/features/boardgames/boardgame_state.dart` -> `lib/features/boardgame/boardgame_state.dart`
   - Renamed file to reflect the updated naming conventions.

4. `lib/features/bg_search/widgets/bg_info_card.dart` -> `lib/features/boardgame/widgets/bg_info_card.dart`
   - Moved the `bg_info_card.dart` widget to the `boardgame` directory.

5. `lib/features/bg_search/widgets/search_card.dart` -> `lib/features/boardgame/widgets/search_card.dart`
   - Moved the `search_card.dart` widget to the `boardgame` directory.

6. `lib/features/edit_ad/widgets/ad_form.dart`
   - Updated imports to reflect the renaming from `BgSearchScreen` to `BoardgameScreen`.

7. `lib/features/boardgames/boardgame_controller.dart` -> `lib/features/edit_boardgame/edit_boardgame_controller.dart`
   - Renamed file and class from `BoardgameController` to `EditBoardgameController`.
   - Updated the state management references from `BoardgameState` to `EditBoardgameState`.

8. `lib/features/boardgames/boardgame_screen.dart` -> `lib/features/edit_boardgame/edit_boardgame_screen.dart`
   - Renamed file and class from `BoardgamesScreen` to `EditBoardgamesScreen`.
   - Updated route name and widget class names accordingly.

9. `lib/features/bg_search/bg_search_state.dart` -> `lib/features/edit_boardgame/edit_boardgame_state.dart`
   - Renamed file and class from `BgSearchState` to `EditBoardgameState`.
   - Updated the state management classes to reflect the new context.

10. `lib/features/my_account/widgets/admin_hooks.dart`
    - Updated import and navigation references from `BgSearchScreen` to `BoardgameScreen`.

11. `lib/my_material_app.dart`
    - Updated route mappings to reflect the renaming from `BgSearchScreen` to `BoardgameScreen` and from `BoardgamesScreen` to `EditBoardgamesScreen`.

This commit refactors and reorganizes the boardgame search and management components, aligning file and class names with their functionalities. The changes enhance code clarity and maintain consistency throughout the project.


## 2024/08/15 - version: 0.6.16+39

Refactor: Rename and Update Boardgame and Mechanics Management. Files and Changes:

1. `lib/common/models/bg_name.dart`
   - Modified `BGNameModel` to use non-final fields.
   - Added `toMap` and `fromMap` methods for easier conversion between `BGNameModel` and `Map<String, dynamic>`.

2. `lib/features/bg_search/bg_search_controller.dart`
   - Renamed the `BgNamesManager` to `BoardgamesManager`.
   - Updated method names to reflect this change.
   - Refactored method `searchBgg` to `searchBg`.

3. `lib/features/bg_search/bg_search_screen.dart`
   - Renamed `BggSearchScreen` to `BgSearchScreen`.
   - Updated the route name and widget class names accordingly.

4. `lib/features/boardgames/boardgame_controller.dart`
   - Renamed `BgNamesManager` to `BoardgamesManager`.
   - Commented out the initialization of BGG rank to focus on the new board game management approach.

5. `lib/features/edit_ad/edit_ad_controller.dart`
   - Removed the unused import of `BgNamesManager`.

6. `lib/features/edit_ad/widgets/ad_form.dart`
   - Updated the route name from `BggSearchScreen.routeName` to `BgSearchScreen.routeName`.

7. `lib/features/my_account/widgets/admin_hooks.dart`
   - Updated the `Boardgames` list tile to navigate to the updated `BgSearchScreen`.

8. `lib/get_it.dart`
   - Replaced `BgNamesManager` with `BoardgamesManager` in the dependency injection setup.

9. `lib/main.dart`
   - Replaced `BgNamesManager` with `BoardgamesManager` during initialization.

10. `lib/manager/bg_names_manager.dart` -> `lib/manager/boardgames_manager.dart`
    - Renamed the file and class from `BgNamesManager` to `BoardgamesManager`.
    - Added logic to manage board games both locally and from the Parse Server.
    - Included methods for fetching and updating board game names.

11. `lib/my_material_app.dart`
    - Updated routes to reflect the renaming from `BggSearchScreen` to `BgSearchScreen`.

12. `lib/repository/sqlite/bg_names_repository.dart`
    - Created a new repository to handle SQLite operations related to board game names.

13. `lib/repository/sqlite/mechanic_repository.dart`
    - Renamed import from `mechanics.dart` to `mechanics_store.dart`.
    - Improved error handling and logging.

14. `lib/store/bg_names.dart` -> `lib/store/bg_names_store.dart`
    - Renamed the file to follow the updated naming conventions.
    - Enhanced methods for adding and updating board game names in the local SQLite database.

15. `lib/store/mechanics.dart` -> `lib/store/mechanics_store.dart`
    - Renamed the file for consistency with the new naming conventions.

This commit refactors the codebase to rename and update the management of board games and mechanics. It introduces a consistent naming convention across files and classes, while also enhancing the integration between local storage and the Parse Server.


## 2024/08/14 - version: 0.6.15+38

Documentation and Code Refactor: Update README and Mechanics Features. Files and Changes:

1. `README.md`
   - Updated the changelog with the latest version `0.6.13+37`, detailing refactoring changes and new features.

2. `lib/common/models/mechanic.dart`
   - Refactored the `MechanicModel` constructor to make the `id` field optional.
   - Simplified the `fromMap` method to remove backward compatibility checks for older field names (`nome` and `descricao`).

3. `lib/features/mechanics/mechanics_controller.dart`
   - Converted `MechanicsController` into a `ChangeNotifier` to manage UI states.
   - Added methods for handling mechanics state (`MechanicsStateLoading`, `MechanicsStateSuccess`, etc.).
   - Improved resource disposal management within the `dispose()` method.

4. `lib/features/mechanics/mechanics_screen.dart`
   - Refactored the mechanics screen to use the new `MechanicDialog` for adding mechanics.
   - Modularized the UI components into separate widgets (`ShowSelectedMechs`, `ShowAllMechs`).
   - Integrated state management for loading and error states.

5. `lib/features/mechanics/mechanics_state.dart`
   - Created a new state management file to handle different states within the mechanics screen (`MechanicsStateInitial`, `MechanicsStateLoading`, etc.).

6. `lib/features/mechanics/widgets/mechanic_dialog.dart`
   - Added a new widget for the mechanics dialog, allowing users to add new mechanics with name and description fields.

7. `lib/features/mechanics/widgets/show_all_mechs.dart`
   - Created a widget to display all mechanics with selection capability.

8. `lib/features/mechanics/widgets/show_selected_mechs.dart`
   - Created a widget to display selected mechanics.

9. `lib/manager/mechanics_manager.dart`
   - Added new methods to fetch mechanics from both local storage and Parse Server.
   - Enhanced mechanics addition logic by integrating local and server-side additions.
   - Implemented `_localAdd` and `_psAdd` methods for better separation of concerns.

10. `lib/repository/parse_server/common/constants.dart`
    - Added constants for mechanics table in the Parse Server (`keyMechTable`, `keyMechObjectId`, `keyMechId`, etc.).

11. `lib/repository/parse_server/common/parse_to_model.dart`
    - Added a new method `mechanic` to parse `ParseObject` into `MechanicModel`.

12. `lib/repository/parse_server/ps_ad_repository.dart`
    - Introduced a private constructor to prevent instantiation of `PSAdRepository`.

13. `lib/repository/parse_server/ps_boardgame_repository.dart`
    - Refined the method to fetch board game names by removing unnecessary null checks.

14. `lib/repository/parse_server/ps_mechanics_repository.dart`
    - Added methods to add and retrieve mechanics from the Parse Server.
    - Implemented error handling and logging for database operations.

15. `lib/repository/sqlite/mechanic_repository.dart`
    - Renamed `getList` to `get` for consistency.
    - Improved error handling and logging within the `get` method.

16. `lib/store/constants/constants.dart`
    - Standardized table names and column names to use consistent casing (`Mechanics`, `mechName`, `mechDescription`).

17. `lib/store/database_manager.dart`
    - Removed obsolete code related to database versioning.
    - Simplified the database initialization logic.

18. `lib/store/mechanics.dart`
    - Renamed `queryMechs` to `get` for better clarity.
    - Improved error logging in the database operations.

19. `pubspec.yaml`
    - Updated the project version to `0.6.15+38` to reflect the latest changes.

This commit includes updates to the documentation, refactors mechanics management, and enhances state management across the mechanics-related features. The codebase is now more modular and maintains better consistency across different components.


## 2024/08/14 - version: 0.6.13+37

Refactor: Update Parse Server Repositories and Add New Features. Files and Changes:

1. `assets/data/bgBazzar.db`
   - Updated the database file.

2. `assets/old/bgBazzar.db`
   - Added an old backup of the `bgBazzar.db` file.

3. `lib/common/singletons/current_user.dart`
   - Replaced `UserRepository` with `PSUserRepository` in methods `init` and `logout`.

4. `lib/features/address/address_controller.dart`
   - Replaced `AdRepository` with `PSAdRepository` in method to move advertisements.

5. `lib/features/address/address_screen.dart`
   - Replaced `AdRepository` with `PSAdRepository`.

6. `lib/features/bg_search/bg_search_controller.dart`
   - Replaced `BoardgameRepository` with `PSBoardgameRepository` in method `getBoardInfo`.

7. `lib/features/boardgames/boardgame_controller.dart`
   - Replaced `BoardgameRepository` with `PSBoardgameRepository` in methods fetching and saving board game data.

8. `lib/features/edit_ad/edit_ad_controller.dart`
   - Replaced `AdRepository` with `PSAdRepository` in methods to save and update advertisements.

9. `lib/features/login/login_controller.dart`
   - Replaced `UserRepository` with `PSUserRepository` in login method.

10. `lib/features/mechanics/mechanics_screen.dart`
    - Added functionality for adding a new mechanic with input fields for name and description.
    - Implemented a floating action button for admin users to add new mechanics.

11. `lib/features/my_account/my_account_screen.dart`
    - Refactored `MyAccountScreen` to use separate widgets for different sections (`AdminHooks`, `ShoppingHooks`, `SalesHooks`, `ConfigHooks`).

12. `lib/features/my_account/widgets/admin_hooks.dart`
    - Created a new widget to handle admin-related actions such as managing mechanics and board games.

13. `lib/features/my_account/widgets/config_hooks.dart`
    - Created a new widget to handle user configuration options such as managing personal data and addresses.

14. `lib/features/my_account/widgets/sales_hooks.dart`
    - Created a new widget to handle sales-related actions such as viewing summaries and managing ads.

15. `lib/features/my_account/widgets/shopping_hooks.dart`
    - Created a new widget to handle shopping-related actions such as managing favorites and purchases.

16. `lib/features/my_ads/my_ads_controller.dart`
    - Replaced `AdRepository` with `PSAdRepository` in methods to fetch and update ads.

17. `lib/features/my_data/my_data_controller.dart`
    - Replaced `UserRepository` with `PSUserRepository` in method to save user data.

18. `lib/features/shop/shop_controller.dart`
    - Replaced `AdRepository` with `PSAdRepository` in methods to fetch ads.

19. `lib/features/signup/signup_controller.dart`
    - Replaced `UserRepository` with `PSUserRepository` in signup method.

20. `lib/manager/address_manager.dart`
    - Replaced `AddressRepository` with `PSAddressRepository` in methods for managing addresses.

21. `lib/manager/bg_names_manager.dart`
    - Replaced `BoardgameRepository` with `PSBoardgameRepository` in methods for managing board game names.

22. `lib/manager/favorites_manager.dart`
    - Replaced `FavoriteRepository` with `PSFavoriteRepository` in methods for managing favorites.

23. `lib/manager/mechanics_manager.dart`
    - Added new methods to add and update mechanics.
    - Implemented `ManagerStatus` enum to manage mechanic status.

24. `lib/repository/parse_server/ad_repository.dart` -> `lib/repository/parse_server/ps_ad_repository.dart`
    - Renamed file and refactored class to `PSAdRepository`.

25. `lib/repository/parse_server/address_repository.dart` -> `lib/repository/parse_server/ps_address_repository.dart`
    - Renamed file and refactored class to `PSAddressRepository`.

26. `lib/repository/parse_server/boardgame_repository.dart` -> `lib/repository/parse_server/ps_boardgame_repository.dart`
    - Renamed file and refactored class to `PSBoardgameRepository`.

27. `lib/repository/parse_server/favorite_repository.dart` -> `lib/repository/parse_server/ps_favorite_repository.dart`
    - Renamed file and refactored class to `PSFavoriteRepository`.

28. `lib/repository/parse_server/user_repository.dart` -> `lib/repository/parse_server/ps_user_repository.dart`
    - Renamed file and refactored class to `PSUserRepository`.

29. `lib/repository/sqlite/mechanic_repository.dart`
    - Added new methods to add and update mechanics in the database.
    - Updated queries to match the new schema.

30. `lib/store/constants/constants.dart`
    - Removed unused columns `mechIndexNome` and `mechDescricao`.
    - Updated constants related to the mechanics table.

31. `lib/store/constants/sql_create_table.dart`
    - Added SQL scripts to create tables for BG names, DB version, and mechanics.

32. `lib/store/database_manager.dart`
    - Updated database manager to handle the creation of new tables and database versions.

33. `lib/store/mechanics.dart`
    - Added new methods to insert, update, and delete mechanics in the SQLite database.

This commit refactors the codebase to adopt a consistent naming convention for Parse Server repositories, introduces new widgets for modularization in the `MyAccountScreen`, and enhances mechanics management features. The database schema and initialization logic have also been updated to support new features.


## 2024/08/13 - version: 0.6.13+36

Update database file name and refactor project components for better organization and functionality.


1. assets/data/bgg.db
   - Renamed to `assets/data/bgBazzar.db`.
   - Binary content of the file has changed.

2. lib/common/models/bg_name.dart
   - Updated `BGNameModel`:
     - Changed `id` type from `String?` to `int?`.
     - Added `bgId` field of type `String?`.

3. lib/common/models/boardgame.dart
   - Updated `BoardgameModel`:
     - Replaced `weight` field with `views` of type `int` and set default value to `0`.
     - Adjusted `toString` method to reflect these changes.

4. lib/common/singletons/current_user.dart
   - Added `isAdmin` getter to return whether the current user is an admin.

5. lib/components/custon_field_controllers/numeric_edit_controller.dart
   - Modified `NumericEditController`:
     - Made it generic to support both `int` and `double` types.
     - Improved validation and handling of numeric input based on the type.
     - Refactored `_validateNumber` method for better clarity.

6. lib/components/form_fields/custom_form_field.dart
   - Added `labelStyle` parameter for customizing the text style of the label.

7. lib/components/form_fields/custom_long_form_field.dart
   - Introduced a new `CustomLongFormField` widget to handle multi-line text input with various customization options.

8. lib/components/form_fields/custom_names_form_field.dart
   - Added `labelStyle` parameter for text style customization of the label.

9. lib/components/others_widgets/spin_box_field.dart
   - Refactored the widget:
     - Removed redundant `SizedBox` wrappers.
     - Replaced `TextField` with `ListenableBuilder` to dynamically display numeric values.

10. lib/features/bg_search/bg_search_controller.dart
    - Updated to include `CurrentUser` for checking admin rights.
    - Adjusted methods to match updated data models.

11. lib/features/bg_search/bg_search_screen.dart
    - Updated UI to support admin functionality:
      - Added FAB to add a new board game if the user is an admin.
      - Refactored padding and UI components for better spacing.

12. lib/features/bg_search/widgets/bg_info_card.dart
    - Commented out the display of `views` and `scoring` for further adjustments.

13. lib/features/bg_search/widgets/search_card.dart
    - Replaced `getBoardInfo` parameter from `id` to `bgId` to reflect updated data model.

14. lib/features/boardgames/boardgame_controller.dart
    - Refactored to use updated `NumericEditController` for various integer-based inputs.
    - Added methods to save board games and handle mechanics more effectively.

15. lib/features/boardgames/boardgame_screen.dart
    - Updated UI components:
      - Added fields for image upload and mechanic selection.
      - Implemented save functionality with data validation.

16. lib/manager/bg_names_manager.dart
    - Refactored to handle image conversion and saving of new board games.
    - Adjusted methods to support new data model changes.

17. lib/repository/parse_server/boardgame_repository.dart
    - Replaced `weight` field with `views` in Parse Server operations.

18. lib/repository/parse_server/common/constants.dart
    - Updated database constants to reflect the change from `weight` to `views`.

19. lib/repository/parse_server/common/parse_to_model.dart
    - Adjusted model parsing to reflect changes in the data model.

20. lib/repository/sqlite/mechanic_repository.dart
    - Updated to use `MechanicsStore` for querying mechanics.

21. lib/store/mech_store.dart
    - Renamed to `bg_names.dart` and refactored to better align with its purpose.

22. lib/store/constants/constants.dart
    - Updated database configuration:
      - Renamed `dbName` to `bgBazzar.db`.
      - Updated constants related to database structure and schema.

23. lib/store/database_manager.dart
    - Enhanced initialization process to support different platforms and configurations.
    - Included the setup for a new directory structure on desktop platforms.

24. lib/store/mechanics.dart
    - Added new store class `MechanicsStore` to handle mechanic-related database operations.

25. pubspec.yaml & pubspec.lock
    - Added dependencies:
      - `sqflite_common_ffi`
      - `sqflite_common_ffi_web`
      - `image`
    - Updated assets path to reflect the renamed database file.

26. web/index.html
    - Included cropper.js library for handling image cropping functionality.

This commit reorganizes and enhances the project by renaming and refactoring several components. It includes updates to the database file and structure, introduces new dependencies, and enhances user interface elements to better support functionality, particularly for board game management and image handling.


## 2024/08/12 - version: 0.6.12+35

Refactor project structure by organizing repositories into more descriptive directories

1. lib/repository/bgg_rank_repository.dart
   - Renamed and moved to `lib/repository/bgg_xml/bgg_rank_repository.dart` to better reflect its association with BGG XML API.

2. lib/repository/bgg_xmlapi_repository.dart
   - Renamed and moved to `lib/repository/bgg_xml/bgg_xmlapi_repository.dart` to align with other BGG-related repositories.

3. lib/repository/ibge_repository.dart
   - Renamed and moved to `lib/repository/gov_api/ibge_repository.dart` to categorize it under government APIs.

4. lib/repository/viacep_repository.dart
   - Renamed and moved to `lib/repository/gov_api/viacep_repository.dart` to keep it alongside other government-related APIs.

5. lib/repository/ad_repository.dart
   - Renamed and moved to `lib/repository/parse_server/ad_repository.dart` to clearly indicate its reliance on Parse Server.

6. lib/repository/address_repository.dart
   - Renamed and moved to `lib/repository/parse_server/address_repository.dart` for better organization under Parse Server.

7. lib/repository/boardgame_repository.dart
   - Renamed and moved to `lib/repository/parse_server/boardgame_repository.dart` to group all Parse Server-related repositories together.

8. lib/repository/common/constants.dart
   - Renamed and moved to `lib/repository/parse_server/common/constants.dart` to keep constants within the Parse Server directory.

9. lib/repository/common/parse_to_model.dart
   - Renamed and moved to `lib/repository/parse_server/common/parse_to_model.dart` to keep model parsing logic within Parse Server.

10. lib/repository/favorite_repository.dart
    - Renamed and moved to `lib/repository/parse_server/favorite_repository.dart` to be consistent with other Parse Server repositories.

11. lib/repository/user_repository.dart
    - Renamed and moved to `lib/repository/parse_server/user_repository.dart` to maintain consistency in the Parse Server directory.

12. lib/repository/mechanic_repository.dart
    - Renamed and moved to `lib/repository/sqlite/mechanic_repository.dart` to clarify its use of SQLite.

13. lib/store/bgg_rank_store.dart
    - Renamed and moved to `lib/repository/sqlite/store/bgg_rank_store.dart` to better categorize store-related files under SQLite.

14. lib/store/constants/constants.dart
    - Renamed and moved to `lib/repository/sqlite/store/constants/constants.dart` to align with SQLite-related stores.

15. lib/store/database_manager.dart
    - Renamed and moved to `lib/repository/sqlite/store/database_manager.dart` to centralize database management under SQLite.

16. lib/store/mech_store.dart
    - Renamed and moved to `lib/repository/sqlite/store/mech_store.dart` to group all mechanic-related stores within SQLite.

This commit reorganizes the project structure by categorizing repositories and stores into more descriptive directories, improving the clarity and maintainability of the codebase.


## 2024/08/12 - version: 0.6.11+34

Refactor project to rename from `xlo_parse_server` to `bgbazzar` and update related files

1. README.md
   - Renamed project title from `xlo_parse_server` to `bgbazzar`.
   - Updated references in the TODO list and project description.

2. android/app/build.gradle
   - Changed `namespace` from `br.dev.rralves.xlo_parse_server` to `br.dev.rralves.bgbazzar`.
   - Updated `applicationId` to `br.dev.rralves.bgbazzar`.

3. android/app/src/main/AndroidManifest.xml
   - Updated `package` attribute to `br.dev.rralves.bgbazzar`.
   - Changed `android:label` to `bgbazzar`.

4. android/app/src/main/kotlin/br/dev/rralves/bgbazzar/MainActivity.kt
   - Renamed package from `br.dev.rralves.xlo_parse_server` to `br.dev.rralves.bgbazzar`.

5. ios/Runner.xcodeproj/project.pbxproj
   - Updated `PRODUCT_BUNDLE_IDENTIFIER` references from `com.example.xloParseServer` to `br.dev.rralves.xloParseServer`.

6. ios/Runner/AppDelegate.swift
   - Changed the annotation from `@UIApplicationMain` to `@main`.

7. lib/common/abstracts/data_result.dart
   - Added a new abstract class `DataResult` for handling either success or failure outcomes, inspired by Swift and Dart implementations.
   - Introduced `Failure`, `GenericFailure`, `APIFailure`, `_SuccessResult`, and `_FailureResult` classes.

8. lib/common/models/ad.dart
   - Removed `bggId` property from `AdModel`.
   - Reorganized `toString` method to include new properties like `yearpublished`, `minplayers`, `maxplayers`, `minplaytime`, `maxplaytime`, `age`, `designer`, and `artist`.

9. lib/common/models/boardgame.dart
   - Refactored properties: replaced `id`, `name`, `yearpublished`, `minplayers`, `maxplayers`, `minplaytime`, `maxplaytime`, `age`, `designer`, `artist` with new names and types for better clarity.
   - Updated `toString` method to reflect these changes.

10. lib/components/others_widgets/ad_list_view/widgets/dismissible_ad.dart
    - Added a `FIXME` comment to indicate the need to select direction to disable unnecessary shifts.

11. lib/features/bgg_search/bgg_search_screen.dart
    - Replaced `BigButton` with `OverflowBar` to allow more granular control of buttons like `Selecionar` and `Cancelar`.

12. lib/features/bgg_search/widgets/bg_info_card.dart
    - Reorganized UI layout in `BGInfoCard`, added image display, and adjusted text fields with new board game properties.
    - Improved layout responsiveness and added `TextOverflow.ellipsis` to designer and artist fields.

13. lib/features/boardgames/boardgame_controller.dart
    - Updated method `loadBoardInfo` to accommodate new property names for board game details.

14. lib/features/edit_ad/edit_ad_controller.dart
    - Removed `bggId` handling from the ad editing logic.
    - Updated properties to use new naming conventions like `publishYear`, `minPlayers`, `maxPlayers`, etc.

15. lib/repository/ad_repository.dart
    - Removed deprecated `bggId` from the ad repository.
    - Added logic to save additional properties such as `yearpublished`, `minplayers`, `maxplayers`, `minplaytime`, `maxplaytime`, `age`, `designer`, and `artist`.

16. lib/repository/bgg_xmlapi_repository.dart
    - Included `image` property in the parsing logic.
    - Removed unnecessary properties and refined model creation logic for `BoardgameModel`.

17. lib/repository/boardgame_repository.dart
    - Added new repository class `BoardgameRepository` to handle CRUD operations for board games.

18. lib/repository/common/constants.dart
    - Added constants related to `BoardgameModel` to handle new properties.

19. lib/repository/common/parse_to_model.dart
    - Added parsing logic for `BoardgameModel`.
    - Removed `bggId` related parsing from ad model creation.

20. pubspec.yaml
    - Renamed project from `xlo_mobx` to `bgbazzar`.
    - Added `equatable` package dependency.

21. test/common/abstracts/data_result_test.dart
    - Added test cases for `DataResult` class, including success, failure, and edge cases.

22. test/repository/ibge_repository_test.dart
    - Updated import path from `xlo_mobx` to `bgbazzar`.

23. web/index.html
    - Renamed project references from `xlo_parse_server` to `bgbazzar`.

24. web/manifest.json
    - Updated `name` and `short_name` from `xlo_parse_server` to `bgbazzar`.

The project has been successfully refactored to transition from `xlo_parse_server` to `bgbazzar`, with corresponding updates across all relevant files.

## 2024/08/09 - version: 0.6.9+32

Integrated Boardgame Functionality and Enhanced AdModel Structure

1. lib/common/models/ad.dart
   - Imported `boardgame.dart`.
   - Updated `AdModel`:
     - Changed `owner` to be nullable.
     - Added `boardgame`, `yearpublished`, `minplayers`, `maxplayers`, `minplaytime`, `maxplaytime`, `age`, `designer`, and `artist` fields.
     - Modified the constructor to initialize the new fields.
     - Updated `toString` method to include the new fields.

2. lib/common/models/bgg_boards.dart
   - Created `BGGBoardsModel` class with `objectid`, `name`, and `yearpublished` fields.

3. lib/common/models/boardgame.dart
   - Updated `BoardgameModel`:
     - Added new nullable fields `id`, `designer`, and `artist`.
     - Renamed `boardgamemechanic` to `mechanics`.
     - Renamed `boardgamecategory` to `categories`.
     - Removed `toMap` and `fromMap` methods.

4. lib/components/others_widgets/ad_list_view/widgets/ad_card_view.dart
   - Updated `AdCardView`:
     - Made `address` fields nullable when accessing `city` and `state`.

5. lib/components/others_widgets/shop_grid_view/widgets/ad_shop_view.dart
   - Updated `AdShopView`:
     - Made `owner` nullable when accessing `name`.

6. lib/features/bgg_search/bgg_search_controller.dart
   - Created `BggController`:
     - Added state management for BGG search and selection.
     - Implemented search functionality using `BggXMLApiRepository`.
     - Added methods to handle errors and fetch board game details.

7. lib/features/bgg_search/bgg_search_screen.dart
   - Created `BggSearchScreen`:
     - Implemented UI for searching and displaying BGG board games.
     - Integrated `BggController` for state management and data handling.

8. lib/features/bgg_search/bgg_search_state.dart
   - Created state classes for BGG search:
     - Added `BggSearchStateInitial`, `BggSearchStateLoading`, `BggSearchStateSuccess`, and `BggSearchStateError`.

9. lib/features/bgg_search/widgets/bg_info_card.dart
   - Created `BGInfoCard` widget:
     - Displays detailed information about a selected board game.

10. lib/features/bgg_search/widgets/search_card.dart
    - Created `SearchCard` widget:
      - Displays a list of search results from BGG.

11. lib/features/boardgames/boardgame_controller.dart
    - Updated `BoardgameController`:
      - Added disposal for additional controllers.
      - Adjusted `getBggInfo` to handle new mechanics field in `BoardgameModel`.

12. lib/features/boardgames/boardgame_screen.dart
    - Updated `BoardgamesScreen`:
      - Added BGG search button and navigation to `BggSearchScreen`.
      - Disposed of `BoardgameController` properly.

13. lib/features/edit_ad/edit_ad_controller.dart
    - Updated `EditAdController`:
      - Integrated `BoardgameModel` data into Ad creation and editing.
      - Added `setBggInfo` method to apply board game information to an ad.

14. lib/features/edit_ad/widgets/ad_form.dart
    - Updated `AdForm`:
      - Added functionality to fetch and apply BGG information using the new BGG search feature.

15. lib/features/product/product_screen.dart
    - Updated `ProductScreen`:
      - Made `owner` and `address` fields nullable when accessed.

16. lib/features/product/widgets/description_product.dart
    - Updated `DescriptionProduct`:
      - Changed subtitle text to "Descrição:".

17. lib/features/product/widgets/sub_title_product.dart
    - Updated `SubTitleProduct`:
      - Adjusted the font size and style for subtitles.

18. lib/my_material_app.dart
    - Added route for `BggSearchScreen`.

19. lib/repository/ad_repository.dart
    - Updated `AdRepository`:
      - Made `address` fields nullable when saving and updating ads.

20. lib/repository/bgg_xmlapi_repository.dart
    - Updated `BggXMLApiRepository`:
      - Added methods to fetch and parse board game data from BGG XML API.
      - Created a search method to retrieve board games by name.

This commit enhances the application by integrating Boardgame functionality into the Ad model, allowing for more detailed and relevant data management.



## 2024/08/09 - version: 0.6.8+31

Refactor `AdvertModel` to `AdModel` Across Project Files

This commit refactors the codebase by renaming `AdvertModel` to `AdModel`, ensuring consistency and clarity in the model naming convention throughout the project. Modified Files and Changes:

1. `lib/common/basic_controller/basic_controller.dart`
   - Renamed `AdvertModel` references to `AdModel`.

2. `lib/common/models/advert.dart` → `lib/common/models/ad.dart`
   - Renamed the file from `advert.dart` to `ad.dart`.
   - Updated class name from `AdvertModel` to `AdModel`.
   - Renamed `AdvertStatus` to `AdStatus`.

3. `lib/common/models/filter.dart`
   - Updated import statement from `advert.dart` to `ad.dart`.

4. `lib/components/custom_drawer/custom_drawer.dart`
   - Renamed navigation functions from `EditAdvertScreen` to `EditAdScreen`.

5. `lib/components/others_widgets/ad_list_view/ad_list_view.dart`
   - Updated all references of `AdvertModel` to `AdModel`.
   - Updated status references from `AdvertStatus` to `AdStatus`.

6. `lib/features/address/address_controller.dart`
   - Updated repository references from `AdvertRepository` to `AdRepository`.

7. `lib/features/address/address_screen.dart`
   - Updated repository references from `AdvertRepository` to `AdRepository`.

8. `lib/features/edit_advert/edit_advert_controller.dart` → `lib/features/edit_ad/edit_ad_controller.dart`
   - Renamed file and updated references from `AdvertModel` to `AdModel`.
   - Updated repository references from `AdvertRepository` to `AdRepository`.

9. `lib/features/edit_advert/edit_advert_screen.dart` → `lib/features/edit_ad/edit_ad_screen.dart`
   - Renamed file and updated references from `AdvertModel` to `AdModel`.

10. `lib/features/edit_advert/edit_advert_state.dart` → `lib/features/edit_ad/edit_ad_state.dart`
    - Renamed file and updated references from `EditAdvertState` to `EditAdState`.

11. `lib/features/edit_advert/widgets/advert_form.dart` → `lib/features/edit_ad/widgets/ad_form.dart`
    - Renamed file and updated form references from `AdvertForm` to `AdForm`.

12. `lib/features/favorites/favorites_controller.dart`
    - Updated model references from `AdvertModel` to `AdModel`.

13. `lib/features/filters/filters_controller.dart`
    - Updated import statements and model references.

14. `lib/features/my_ads/my_ads_controller.dart`
    - Updated model and repository references to `AdModel` and `AdRepository`.

15. `lib/features/my_ads/my_ads_screen.dart`
    - Updated navigation and model references to `EditAdScreen` and `AdModel`.

16. `lib/features/product/product_screen.dart`
    - Updated model references from `AdvertModel` to `AdModel`.

17. `lib/features/shop/shop_controller.dart`
    - Updated repository and model references to `AdRepository` and `AdModel`.

18. `lib/my_material_app.dart`
    - Updated routing references from `EditAdvertScreen` to `EditAdScreen`.
    - Updated model references from `AdvertModel` to `AdModel`.

19. `lib/repository/advert_repository.dart` → `lib/repository/ad_repository.dart`
    - Renamed file and updated all function references from `AdvertModel` to `AdModel`.

20. `lib/repository/common/constants.dart`
    - Updated constants related to `Advert` to reflect the `Ad` naming convention.

21. `lib/repository/common/parse_to_model.dart`
    - Updated parsing functions to reference `AdModel` instead of `AdvertModel`.

22. `lib/repository/favorite_repository.dart`
    - Updated repository and model references to `AdModel` and `AdRepository`.

This commit is part of the ongoing effort to maintain consistency in the codebase by standardizing model naming conventions.

Note: This refactor only changes the naming conventions and does not introduce any new features or functionality.


The changes introduced in this commit ensure a consistent naming convention across the codebase, improving code readability and maintainability. The model `AdvertModel` is now consistently referred to as `AdModel`, and related classes, files, and references have been updated accordingly. This refactor is crucial for future scalability and ease of understanding for developers working on the project.


## 2024/08/08 - version: 0.6.7+30

Refactor and Add New Features

1. assets/data/bgg.db
   - Updated the database binary file with new data.

2. lib/common/models/boardgame.dart
   - Changed `description` from `final` to a mutable field.
   - Updated `fromMap` method to use `cleanDescription` for `description` field.
   - Added `cleanDescription` method to sanitize and format the description text.

3. lib/components/buttons/big_button.dart
   - Renamed `onPress` callback to `onPressed` for consistency.

4. lib/components/custon_field_controllers/numeric_edit_controller.dart
   - Created a new `NumericEditController` class to manage numeric input with validation.

5. lib/components/form_fields/custom_names_form_field.dart
   - Added `onSubmitted` callback to handle form submission events.

6. lib/components/others_widgets/spin_box_field.dart
   - Created a new `SpinBoxField` widget for numeric input with increment and decrement functionality.

7. lib/features/boardgames/boardgame_controller.dart
   - Refactored to replace `bggName` with `nameController`.
   - Added controllers for various board game properties (`minPlayersController`, `maxPlayersController`, etc.).
   - Implemented `loadBoardInfo` method to populate controllers from `BoardgameModel`.
   - Adjusted `getBggInfo` to load board game information into the controller.

8. lib/features/boardgames/boardgame_screen.dart
   - Integrated new controllers and widgets (`SpinBoxField`, `SubTitleProduct`) for enhanced UI and interaction.
   - Refactored `AppBar` to include a back button.

9. lib/features/edit_advert/edit_advert_screen.dart
   - Renamed `onPress` to `onPressed` for consistency in `BigButton` usage.
   - Adjusted button labels for better clarity.

10. lib/features/edit_advert/widgets/advert_form.dart
    - Integrated `BigButton` for navigation to `BoardgamesScreen`.
    - Updated label text to clarify the input fields.

11. lib/features/filters/filters_screen.dart
    - Renamed `onPress` to `onPressed` for consistency in `BigButton` usage.

12. lib/features/login/login_screen.dart
    - Renamed `onPress` to `onPressed` for consistency in `BigButton` usage.

13. lib/features/login/widgets/login_form.dart
    - Renamed `onPress` to `onPressed` for consistency in `BigButton` usage.

14. lib/features/my_data/my_data_screen.dart
    - Renamed `onPress` to `onPressed` for consistency in `BigButton` usage.

15. lib/features/product/widgets/sub_title_product.dart
    - Added support for custom colors and padding in `SubTitleProduct`.

16. lib/features/signup/signup_screen.dart
    - Renamed `onPress` to `onPressed` for consistency in `BigButton` usage.

17. lib/features/signup/widgets/signup_form.dart
    - Renamed `onPress` to `onPressed` for consistency in `BigButton` usage.

18. lib/manager/mechanics_manager.dart
    - Added `namesFromIdListString` method to convert list of mechanic IDs to a comma-separated string.

19. lib/repository/bgg_rank_repository.dart
    - Removed instance of `BggRankStore` and used static methods instead.

20. lib/repository/bgg_xmlapi_repository.dart
    - Used `BoardgameModel.cleanDescription` to sanitize the description text from the XML API.

21. lib/repository/common/constants.dart
    - Corrected table names from `AdSale` to `AdsSale` and from `Favorite` to `Favorites`.
    - Added constants for database version management.

22. lib/repository/common/parse_to_model.dart
    - Cleaned up commented-out code related to mechanics parsing.

23. lib/repository/mechanic_repository.dart
    - Removed instance of `MechStore` and used static methods instead.

24. lib/store/bgg_rank_store.dart
    - Changed all methods to static and updated method signatures accordingly.

25. lib/store/constants/constants.dart
    - Added constants related to database versioning.

26. lib/store/database_manager.dart
    - Refactored to include database version checking and copying logic.
    - Introduced `_copyBggDb` and `getDBVerion` methods for better database management.

27. lib/store/mech_store.dart
    - Changed all methods to static and updated method signatures accordingly.

This commit includes multiple refactors and feature additions, particularly focused on improving the consistency of the codebase and adding new UI components.


2024/08/08 - version: 0.6.6+29

This commit introduces significant enhancements and new functionalities related to BGG ranks and board games, improving the overall functionality and user experience.


1. Makefile
   - Added `git add .` to `git_diff` target.
   - Modified `git_push` to include `git add .` and changed commit file from `commit.txt` to `commit`.

2. lib/common/models/advert.dart
   - Imported `foundation.dart`.
   - Added `bggId` field to `AdvertModel`.
   - Modified constructor to include `bggId`.
   - Updated `toString` method to include `bggId`.

3. lib/common/models/bgg_rank.dart
   - Created new model `BggRankModel` with fields `id`, `gameName`, `yearPublished`, `rank`, `bayesAverage`, `average`, `usersRated`, `isExpansion`, `abstractsRank`, `cgsRank`, `childrensGamesrank`, `familyGamesRank`, `partyGamesRank`, `strategyGamesRank`, `thematicRank`, `warGamesRank`.
   - Added factory methods `fromMap` and `toMap`.
   - Implemented `toString` method.

4. lib/common/models/boardgame.dart
   - Created new model `BoardgameModel` with fields `name`, `yearpublished`, `minplayers`, `maxplayers`, `minplaytime`, `maxplaytime`, `age`, `description`, `average`, `bayesaverage`, `averageweight`, `boardgamemechanic`, `boardgamecategory`.
   - Added factory methods `fromMap` and `toMap`.
   - Implemented `toString` method.

5. lib/components/form_fields/custom_form_field.dart
   - Added `suffixText` and `prefixText` parameters.
   - Updated constructor to include `suffixText` and `prefixText`.
   - Modified `build` method to use `suffixText` and `prefixText`.

6. lib/components/form_fields/custom_names_form_field.dart
   - Created new widget `CustomNamesFormField`.
   - Added fields `labelText`, `hintText`, `controller`, `names`, `validator`, `keyboardType`, `textInputAction`, `textCapitalization`, `nextFocusNode`, `fullBorder`, `maxLines`, `floatingLabelBehavior`, `readOnly`, `suffixIcon`, `errorText`.
   - Implemented `StatefulWidget` logic to show suggestions based on input.

7. lib/components/others_widgets/state_error_message.dart
   - Added `closeDialog` callback to `StateErrorMessage`.
   - Updated constructor to include `closeDialog`.
   - Added a button to close the dialog.

8. lib/features/address/address_controller.dart
   - Added `closeErroMessage` method to change state to `AddressStateSuccess`.

9. lib/features/address/address_screen.dart
   - Replaced `ButtonBar` with `OverflowBar`.
   - Updated to use `StateErrorMessage` with `closeDialog` callback.

10. lib/features/address/widgets/destiny_address_dialog.dart
    - Replaced `ButtonBar` with `OverflowBar`.

11. lib/features/boardgames/boardgame_controller.dart
    - Created `BoardgameController` with `BoardgameState`, `rankManager`, and `bggName`.
    - Added methods to handle BGG rank initialization and fetching.

12. lib/features/boardgames/boardgame_screen.dart
    - Created `BoardgamesScreen` to display board game details.
    - Integrated `BoardgameController` for managing state and interactions.

13. lib/features/boardgames/boardgame_state.dart
    - Created `BoardgameState` abstract class with `BoardgameStateInitial`, `BoardgameStateLoading`, `BoardgameStateSuccess`, and `BoardgameStateError`.

14. lib/features/edit_advert/edit_advert_controller.dart
    - Added `bggName` and `rankManager` fields.
    - Modified `init` method to include `bggName`.
    - Updated methods to handle `bggId`.

15. lib/features/edit_advert/edit_advert_screen.dart
    - Replaced `ButtonBar` with `OverflowBar`.
    - Added navigation to `BoardgamesScreen`.

16. lib/features/edit_advert/widgets/advert_form.dart
    - Added `CustomFormField` for board game name.
    - Added button to navigate to `BoardgamesScreen`.

17. lib/features/login/login_controller.dart
    - Added `closeErroMessage` method to change state to `LoginStateSuccess`.

18. lib/features/login/login_screen.dart
    - Updated controller usage to match naming conventions.

19. lib/features/mecanics/mecanics_screen.dart
    - Replaced `ButtonBar` with `OverflowBar`.

20. lib/features/my_ads/my_ads_controller.dart
    - Added `closeErroMessage` method to change state to `BasicStateSuccess`.

21. lib/features/my_ads/my_ads_screen.dart
    - Updated to use `StateErrorMessage` with `closeDialog` callback.

22. lib/features/new_address/new_address_screen.dart
    - Replaced `ButtonBar` with `OverflowBar`.

23. lib/features/shop/shop_controller.dart
    - Added `closeErroMessage` method to change state to `BasicStateSuccess`.

24. lib/features/shop/shop_screen.dart
    - Updated to use `StateErrorMessage` with `closeDialog` callback.

25. lib/get_it.dart
    - Registered `BggRankManager` in dependency injection.

26. lib/manager/bgg_rank_manager.dart
    - Created `BggRankManager` to handle BGG rank data fetching and management.

27. lib/my_material_app.dart
    - Added route for `BoardgamesScreen`.

28. lib/repository/advert_repository.dart
    - Updated to set `bggId` in `AdvertRepository`.

29. lib/repository/bgg_rank_repository.dart
    - Created `BggRankRepository` for interacting with BGG rank data.

30. lib/repository/bgg_xmlapi_repository.dart
    - Created `BggXMLApiRepository` to fetch and parse BGG XML API data.

31. lib/repository/common/constants.dart
    - Added `keyAdvertBggId`.

32. lib/repository/common/parse_to_model.dart
    - Updated to parse `bggId` in `AdvertModel`.

33. lib/store/bgg_rank_store.dart
    - Created `BggRankStore` for database interactions related to BGG ranks.

34. lib/store/constants/constants.dart
    - Updated constant `rankGameName`.

35. lib/store/mech_store.dart
    - Added spacing for readability.

36. pubspec.yaml
    - Added `xml` dependency for XML parsing.

37. lib/common/models/advert.dart
    - Added import for `foundation.dart` to support `listEquals`.

38. lib/features/address/widgets/destiny_address_dialog.dart
    - Replaced `ButtonBar` with `OverflowBar` for consistent UI.

39. lib/features/boardgames/boardgame_screen.dart
    - Improved layout and added detailed fields for board game information.

40. lib/features/edit_advert/edit_advert_screen.dart
    - Enhanced form validation and user feedback for better user experience.

41. lib/features/my_ads/my_ads_screen.dart
    - Added proper handling of error messages using `StateErrorMessage`.

42. lib/features/new_address/new_address_screen.dart
    - Updated UI components for better usability.

43. lib/repository/advert_repository.dart
    - Improved error handling and added support for `bggId`.

44. lib/repository/bgg_xmlapi_repository.dart
    - Added comprehensive error logging to facilitate debugging.

45. lib/store/bgg_rank_store.dart
    - Optimized database queries for better performance.

These changes ensure a more robust and user-friendly application, addressing several pain points and enhancing the overall functionality.

Additionally, several improvements and bug fixes have been made across various files to enhance code quality and maintainability.


## 2024/08/06 - version: 0.6.5+28

Implement Favorite Button and User-Specific Features, Improve Scrolling and Mechanics Handling

The favorite button now appears only for logged-in users and is positioned over the product images in the current layout. On the "My Ads" page, buttons to edit and delete an ad are available, but only for ads with a pending or sold status. Active products cannot be edited or deleted. In the ShopScreen, reactivity has been added to adjust the display of favorites and the page header name based on whether the user is logged in or not.

Scrolling adjustments have been made to the ShopGridView and AdListView widgets to ensure smoother scrolling when loading new ads. The control of mechanics has been migrated from the Parse server to a local SQLite database. These mechanics consist of relatively static information that does not change frequently, hence they have been incorporated into the app. Data from BGG and the annual ranking table have also been integrated into the application.

These changes enhance user-specific features and optimize the handling of mechanics by migrating data control to a local SQLite database. The integration of user-specific features and the optimization of mechanics handling ensure a more efficient and user-friendly experience. This set of changes introduces significant improvements to user interactions, performance enhancements, and the transition to local storage for mechanics, providing a more robust and efficient application experience.

Deletions primarily focus on removing configuration files and setups specific to Flutter's macOS, windows and Linux descktop implementations, cleaning up the project and reducing dependencies. Additional deletions continue the clean-up process by removing configuration files and assets specific to the macOS platform, further simplifying the project and focusing on the core Flutter application. The final batch of deletions completes the removal of configuration files, scripts, and assets specific to the macOS and Windows platforms. This clean-up aligns the project with the focus on core Flutter application development, eliminating unnecessary platform-specific files.

Below is a breakdown of the changes:

1. .env
   - Added environment variables for Parse Server configuration:
     - `PARSE_SERVER_DATABASE_URI`
     - `PARSE_SERVER_APPLICATION_ID`
     - `PARSE_SERVER_MASTER_KEY`
     - `PARSE_SERVER_CLIENT_KEY`
     - `PARSE_SERVER_JAVASCRIPT_KEY`
     - `PARSE_SERVER_REST_API_KEY`
     - `PARSE_SERVER_FILE_KEY`
     - `PARSE_SERVER_URL`
     - `PARSE_SERVER_MASTER_KEY_IPS`
     - `PARSE_PORT`

2. assets/data/bgg.db
   - Added SQLite database file for mechanics and rank data.

3. docker-compose.yml
   - Updated Parse Server configuration to use environment variables.

4. lib/common/models/advert.dart
   - Changed `mechanicsId` type from `List<String>` to `List<int>`.

5. lib/common/models/filter.dart
   - Changed `mechanicsId` type from `List<String>` to `List<int>`.

6. lib/common/models/mechanic.dart
   - Updated `MechanicModel` class:
     - Changed `id` type from `String?` to `int?`.
     - Changed `name` type from `String?` to `String`.
     - Added methods `toMap` and `fromMap`.

7. lib/common/settings/local_server.dart
   - Updated Parse Server URL and keys for back4app.com.

8. lib/components/others_widgets/ad_list_view/ad_list_view.dart
   - Removed `ButtonBehavior` enum.
   - Updated item button logic for ads:
     - Added `_editButton` and `_deleteButton` methods.
     - Added `_showAd` method for navigation.
     - Added logic to show buttons based on `buttonBehavior` flag.
   - Improved scrolling behavior:
     - Renamed `_scrollListener2` to `_scrollListener`.
     - Added `_isScrolling` flag to prevent multiple requests.

9. lib/components/others_widgets/shop_grid_view/shop_grid_view.dart
   - Improved scrolling behavior:
     - Renamed `_scrollListener2` to `_scrollListener`.
     - Added `_isScrolling` flag to prevent multiple requests.

10. lib/components/others_widgets/shop_grid_view/widgets/ad_shop_view.dart
    - Display favorite button for logged-in users only:
      - Added `isLogged` getter.
      - Used `FavStackButton` if user is logged in.

11. lib/features/edit_advert/edit_advert_controller.dart
    - Changed `selectedMechIds` type from `List<String>` to `List<int>`.

12. lib/features/edit_advert/widgets/advert_form.dart
    - Updated mechanics ID handling.

13. lib/features/filters/filters_controller.dart
    - Changed `selectedMechIds` type from `List<String>` to `List<int>`.

14. lib/features/filters/filters_screen.dart
    - Updated mechanics ID handling.

15. lib/features/mecanics/mecanics_screen.dart
    - Changed `selectedIds` type from `List<String>` to `List<int>`.

16. lib/features/my_account/my_account_screen.dart
    - Fixed logout behavior:
      - Moved `currentUser.logout()` to after `Navigator.pop`.

17. lib/features/my_ads/my_ads_screen.dart
    - Added loading and error states:
      - Used `StateLoadingMessage` and `StateErrorMessage` components.

18. lib/features/my_ads/widgets/my_tab_bar_view.dart
    - Simplified item button logic:
      - Removed `getItemButton` method.
      - Used boolean flag for `buttonBehavior`.

19. lib/features/product/product_screen.dart
    - Display favorite button in product images for logged-in users:
      - Added `isLogged` getter.
      - Used `FavStackButton` in `Stack`.

20. lib/features/shop/shop_controller.dart
    - Added listeners for user login status to update ads and page title.

21. lib/get_it.dart
    - Registered `DatabaseManager` singleton.

22. lib/manager/mechanics_manager.dart
    - Changed `mechanicsId` type from `List<String>` to `List<int>`.
    - Updated `nameFromId` method to use `int` type.

23. lib/repository/advert_repository.dart
    - Changed `mechanicsId` type from `List<String>` to `List<int>` in ad saving methods.

24. lib/repository/common/constants.dart
    - Increased `maxAdsPerList` from 6 to 20.

25. lib/repository/common/parse_to_model.dart
    - Changed `mechanicsId` type from `List<String>` to `List<int>` in ad parsing method.

26. lib/repository/mechanic_repository.dart
    - Refactored to use local SQLite database for mechanics data:
      - Used `MechStore` for querying mechanics.

27. lib/store/constants/constants.dart
    - Added constants for SQLite database handling:
      - Database name, version, and table/column names.

28. lib/store/database_manager.dart
    - Implemented database manager for initializing and handling SQLite database.

29. lib/store/mech_store.dart
    - Implemented mechanics store for querying mechanics data from SQLite database.

30. lib/components/others_widgets/fav_button.dart
    - Created `FavStackButton` widget to handle favorite actions:
      - Displays favorite icon based on whether the ad is favorited.
      - Toggles favorite status on button press.

31. lib/repository/mechanic_repository.dart.parse
    - Added legacy Parse Server mechanic repository code for reference:
      - Fetches mechanics from Parse Server.
      - Logs errors if the query fails.

32. linux/.gitignore
    - Removed unused Linux build directory from version control.

33. linux/CMakeLists.txt
    - Removed unused Linux build configuration file.

34. lib/common/settings/local_server.dart
    - Commented out back4app.com configuration details:
      - Removed hard-coded application ID and client key.
      - Defined new application ID and client key for back4app.com.
      - Set Parse Server URL to back4app.com.

35. lib/components/others_widgets/ad_list_view/ad_list_view.dart
    - Updated `AdListView` to include new button behavior:
      - Added `_editButton` and `_deleteButton` methods.
      - Modified `_scrollListener` for smoother scrolling.
      - Updated layout to include edit and delete buttons for ads.

36. lib/components/others_widgets/shop_grid_view/shop_grid_view.dart
    - Updated `ShopGridView` for better scrolling performance:
      - Modified `_scrollListener` for smoother scrolling.
      - Added `_isScrolling` to prevent duplicate load calls.

37. lib/features/my_ads/my_ads_screen.dart
    - Enhanced `MyAdsScreen` to display loading and error messages:
      - Added `StateLoadingMessage` and `StateErrorMessage` for better state handling.

38. lib/features/product/product_screen.dart
    - Improved `ProductScreen` to include favorite button for logged-in users:
      - Added `FavStackButton` to the `ImageCarousel` stack.

39. lib/repository/common/constants.dart
    - Increased `maxAdsPerList` from 6 to 20 to display more ads per load.

40. lib/store/database_manager.dart
    - Created `DatabaseManager` to handle local SQLite database:
      - Initializes database from assets if not found.
      - Provides methods to access and close the database.

41. lib/store/mech_store.dart
    - Created `MechStore` to handle mechanics storage:
      - Queries mechanics from local SQLite database.
      - Fetches mechanic descriptions based on language code.

42. linux/*
    - Removed linux desktop support.

43. macos/*
    - Removed macOS descktop support.
      
44. windows/*
    - Removed Windows desktop support.
      
45. pubspec.yaml
    - Modified file.
      - Added `sqflite` and `path_provider` to dependencies.
      - Included assets for the project.

These changes enhance user-specific features and optimize the handling of mechanics by migrating data control to a local SQLite database. This set of changes introduces significant improvements to user interactions and performance, ensuring a more efficient and user-friendly experience. The transition to local storage for mechanics provides a more robust and efficient application experience.

Deletions primarily focus on removing configuration files and setup specific to Flutter's macOS and Linux implementations, cleaning up the project and reducing dependencies. Remaining deletions continue the clean-up process by removing additional configuration files and assets specific to the macOS platform, further simplifying the project and focusing on the core Flutter application. The final batch of deletions completes the removal of configuration files, scripts, and assets specific to the macOS and Windows platforms, aligning the project with the focus on core Flutter application development and eliminating unnecessary platform-specific files.


## 2024/08/01 - version: 0.6.2+27

This commit introduces multiple enhancements and fixes across various components of the project:

1. **`Makefile`**
   - Added a new `build_profile` target for running the Flutter app in profile mode.

2. **`README.md`**
   - Updated the TODO list and removed unnecessary sections to streamline the document.

3. **`analysis_options.yaml`**
   - Configured the analyzer to treat deprecated member use as an error.

4. **`android/app/build.gradle`**
   - Updated `compileSdk`, `minSdk`, and `targetSdk` versions to 34 and 21 respectively.
   
5. **`android/app/src/main/AndroidManifest.xml`**
   - Added necessary permissions for internet, camera, and external storage access.

6. **`android/build.gradle`**
   - Updated the Gradle plugin version to 8.5.0.

7. **`android/gradle/wrapper/gradle-wrapper.properties`**
   - Updated the Gradle distribution URL to use version 8.5.

8. **`flutter_01.png`**
   - Added a new image resource.

9. **`lib/common/app_constants.dart`**
   - Introduced a new constant `appTitle` with the value 'BGBazzar'.

10. **`lib/common/singletons/search_filter.dart`**
    - Refactored the `SearchFilter` class, removing redundant code and adding a `haveFilter` getter.

11. **`lib/common/singletons/search_history.dart`**
    - Refactored the `SearchHistory` class, removing redundant code and optimizing methods.

12. **`lib/components/custom_drawer/custom_drawer.dart`**
    - Added navigation methods and refactored the code to improve readability and functionality.

13. **`lib/components/others_widgets/shop_grid_view/widgets/ad_shop_view.dart`**
    - Adjusted the image size calculation for better UI consistency.

14. **`lib/features/base/base_controller.dart`, `lib/features/base/base_screen.dart`, `lib/features/base/base_state.dart`, `lib/features/base/widgets/old/search_dialog_bar.dart`, `lib/features/base/widgets/old/search_dialog_search_bar.dart`, `lib/features/base/widgets/search_controller.dart`**
    - Deleted obsolete files related to the base controller and screen.

15. **`lib/features/favorites/favorites_controller.dart`**
    - Removed TODO comments and unimplemented methods.

16. **`lib/features/login/login_screen.dart`**
    - Added a back button to the app bar.

17. **`lib/features/my_account/my_account_screen.dart`**
    - Refactored the logout method and fixed a comment for the logout feature.

18. **`lib/features/product/product_screen.dart`**
    - Added a comment for the favorite button functionality.

19. **`lib/features/shop/shop_controller.dart`**
    - Major refactor, including new methods for setting the page title, cleaning search, and handling ads retrieval.

20. **`lib/features/shop/shop_screen.dart`**
    - Refactored the shop screen, including the app bar, floating action button, and the main content area for better UX and code maintainability.

21. **`lib/features/shop/shop_state.dart`**
    - Deleted the redundant shop state file.

22. **`lib/features/base/widgets/search_dialog.dart` -> `lib/features/shop/widgets/search/search_dialog.dart`**
    - Renamed and refactored the search dialog for better modularity.

23. **`lib/features/signup/signup_screen.dart`**
    - Added a back button to the app bar.

24. **`lib/get_it.dart`**
    - Updated dependency registration, replacing `BaseController` with `ShopController`.

25. **`lib/my_material_app.dart`**
    - Changed the initial route to `ShopScreen`.

26. **`pubspec.lock`, `pubspec.yaml`**
    - Updated `shared_preferences` package to version 2.3.0.

These changes collectively improve the project’s structure, enhance user experience, and maintain code consistency.


## 2024/08/01 - version: 0.6.1+25

This commit introduces the Favorites feature and refactors various components to enhance functionality and code organization:

1. **`lib/components/custom_drawer/custom_drawer.dart`**
   - Imported `FavoritesScreen` to enable navigation.
   - Updated the "Favoritos" list tile to use `Navigator.pushNamed` for navigation.

2. **`lib/features/base/base_controller.dart`**
   - Removed "Favoritos" from the `titles` list.

3. **`lib/features/base/base_screen.dart`**
   - Removed the `FavoritesScreen` from the list of screens managed by `BaseScreen`.

4. **`lib/features/favorites/favorites_controller.dart`**
   - New file: Added `FavoritesController` to manage the state and data of the Favorites feature.

5. **`lib/features/favorites/favorites_screen.dart`**
   - Implemented the `FavoritesScreen` with state management and display logic using `FavoritesController` and `ShopGridView`.

6. **`lib/features/shop/shop_screen.dart`**
   - Removed the `showImage` method as it is now redundant with the `ShopGridView` implementation.

7. **`lib/get_it.dart`**
   - Added disposal of `FavoritesManager` in the `disposeDependencies` method.

8. **`lib/manager/favorites_manager.dart`**
   - Added the `ads` getter to expose the list of favorite ads.
   - Added a `dispose` method to properly clean up the `favNotifier`.

9. **`lib/my_material_app.dart`**
   - Added a route for `FavoritesScreen` in the route table.

10. **`pubspec.yaml`**
    - Updated the version from `0.6.1+26` to `0.6.2+27`.

These changes collectively add the Favorites feature, allowing users to manage and view their favorite ads. The code refactoring improves maintainability and clarity.


## 2024/07/31 - version: 0.6.1+25

This commit introduces updates, new functionalities, and refactorings across multiple files to improve user management and advertisement features:

1. `lib/common/singletons/current_user.dart`
   - Added `FavoritesManager` integration for managing user favorites.
   - Renamed `isLoged` to `isLogged`.
   - Added `login` method for handling user login logic.
   - Updated `logout` method to clear user favorites and addresses.

2. `lib/components/custom_drawer/custom_drawer.dart`
   - Renamed `isLoged` to `isLogged` to ensure consistent naming.
   - Updated button interactions based on user login status.

3. `lib/components/custom_drawer/widgets/custom_drawer_header.dart`
   - Renamed `isLoged` to `isLogged` for consistency.

4. `lib/components/others_widgets/shop_grid_view/shop_grid_view.dart`
   - New file: Added `ShopGridView` widget for displaying advertisements in a grid view.

5. `lib/components/others_widgets/shop_grid_view/widgets/ad_shop_view.dart`
   - New file: Added `AdShopView` widget for displaying individual advertisements.

6. `lib/components/others_widgets/shop_grid_view/widgets/owner_rating.dart`
   - New file: Added `OwnerRating` widget to display owner ratings.

7. `lib/components/others_widgets/shop_grid_view/widgets/shop_text_price.dart`
   - New file: Added `ShopTextPrice` widget to display advertisement prices.

8. `lib/components/others_widgets/shop_grid_view/widgets/shop_text_title.dart`
   - New file: Added `ShopTextTitle` widget to display advertisement titles.

9. `lib/components/others_widgets/shop_grid_view/widgets/show_image.dart`
   - New file: Added `ShowImage` widget to handle image display.

10. `lib/features/base/base_screen.dart`
    - Renamed `isLoged` to `isLogged` to ensure consistent naming.

11. `lib/features/edit_advert/edit_advert_screen.dart`
    - Updated title to reflect editing state.
    - Added `StateLoadingMessage` and `StateErrorMessage` for better state handling.
    - Fixed controller reference in `ImagesListView`.

12. `lib/features/edit_advert/widgets/image_list_view.dart`
    - Fixed controller reference to `ctrl` for consistency.

13. `lib/features/shop/shop_screen.dart`
    - Replaced `AdListView` with `ShopGridView` for better advertisement display.

14. `lib/get_it.dart`
    - Registered `FavoritesManager` for dependency injection.

15. `lib/manager/address_manager.dart`
    - Added methods `login` and `logout` to manage user login state.

16. `lib/manager/favorites_manager.dart`
    - New file: Added `FavoritesManager` to manage user favorites, including methods to add, remove, and fetch favorites.

17. `lib/repository/constants.dart`
    - Updated `maxAdsPerList` to 6 for better pagination.

18. `lib/repository/favorite_repository.dart`
    - Updated `add` method to use `adId` directly.
    - Added `getFavorites` method to fetch user's favorite advertisements.

19. `lib/repository/parse_to_model.dart`
    - Renamed `favotire` to `favorite` for correct spelling.
    - Added type annotation for `mechanic` method.

These changes collectively enhance user management, improve advertisement handling, and introduce a new favorites feature.


## 2024/07/31 - version: 0.6.0+24

This commit introduces several updates, new functionalities, and refactorings across multiple files:

1. `lib/common/models/favorite.dart`
   - New file: Added `FavoriteModel` class to represent favorite advertisements with attributes `id` and `adId`.

2. `lib/features/address/address_controller.dart`
   - Removed unnecessary delay after deleting an address in the `moveAdsAddressAndRemove` method.

3. `lib/features/base/widgets/search_dialog_bar.dart`
   - Renamed and moved to `lib/features/base/widgets/old/search_dialog_bar.dart` for better organization.

4. `lib/features/base/widgets/search_dialog_search_bar.dart`
   - Renamed and moved to `lib/features/base/widgets/old/search_dialog_search_bar.dart` for better organization.

5. `lib/features/edit_advert/edit_advert_controller.dart`
   - Updated `mechanicsManager` to use the instance from `getIt` for dependency injection.

6. `lib/features/filters/filters_controller.dart`
   - Updated `mechManager` to use the instance from `getIt` for dependency injection.

7. `lib/features/filters/filters_screen.dart`
   - Fixed typo in the hint text from 'Cidate' to 'Cidade'.

8. `lib/features/mecanics/mecanics_screen.dart`
   - Updated `mechanics` to use the instance from `getIt` for dependency injection.

9. `lib/features/my_account/my_account_screen.dart`
   - Refactored `onPressed` method of the logout button to be asynchronous.

10. `lib/features/product/product_screen.dart`
    - Added a favorite button to the app bar for product screens.

11. `lib/features/product/widgets/image_carousel.dart`
    - Replaced `carousel_slider` with `flutter_carousel_slider` for better functionality.
    - Updated the layout and behavior of the image carousel.

12. `lib/get_it.dart`
    - Registered `MechanicsManager` as a lazy singleton for dependency injection.

13. `lib/main.dart`
    - Updated initialization process to include `MechanicsManager`.

14. `lib/manager/mechanics_manager.dart`
    - Removed singleton pattern in favor of dependency injection using `getIt`.

15. `lib/repository/constants.dart`
    - Added constants for the `Favorite` table and its fields.

16. `lib/repository/favorite_repository.dart`
    - New file: Added `FavoriteRepository` with methods to add and delete favorites.

17. `lib/repository/parse_to_model.dart`
    - Added method `favorite` to convert ParseObject to `FavoriteModel`.

18. `lib/repository/user_repository.dart`
    - Updated `update` method to handle user password changes more effectively.
    - Improved logout method to be asynchronous.

19. `pubspec.lock`
    - Removed `carousel_slider` package.
    - Added `flutter_carousel_slider` package.

20. `pubspec.yaml`
    - Removed `carousel_slider` dependency.
    - Added `flutter_carousel_slider` dependency.

These changes collectively enhance the functionality and organization of the application, improve dependency management, and introduce the capability to handle favorite advertisements.


## 2024/07/30 - version: 0.5.3+23

This commit introduces a range of updates and new functionalities across multiple files:

1. `lib/components/dialogs/simple_question.dart`
   - New file: Added `SimpleQuestionDialog` widget for displaying simple question dialogs with Yes/No or Confirm/Cancel options.

2. `lib/features/address/address_controller.dart`
   - Imported `dart:developer`.
   - Added `AddressState` management.
   - Introduced `selectesAddresId`, `_changeState`, and `moveAdsAddressAndRemove` methods for better address handling.

3. `lib/features/address/address_screen.dart`
   - Imported `dart:developer` and `state_error_message.dart`.
   - Updated `_removeAddress` to handle advertisements associated with the address.
   - Added `AnimatedBuilder` for managing loading and error states.
   - Included `DestinyAddressDialog` for handling the destination address when removing an address.

4. `lib/features/my_data/my_data_state.dart`
   - Renamed file to `lib/features/address/address_state.dart` to be consistent with the new address state management.

5. `lib/features/address/widgets/destiny_address_dialog.dart`
   - New file: Added `DestinyAddressDialog` widget for selecting a destination address when removing an address with associated advertisements.

6. `lib/features/my_ads/my_ads_screen.dart`
   - Added `floatingActionButton` for adding new advertisements.
   - Introduced `_addNewAdvert` method to navigate to the `EditAdvertScreen`.

7. `lib/features/my_data/my_data_controller.dart`
   - Removed `MyDataState` management to simplify the controller.
   - Removed `_changeState` method.

8. `lib/features/my_data/my_data_screen.dart`
   - Added `backScreen` method to handle unsaved changes.
   - Refactored the screen layout to include `SimpleQuestionDialog` for unsaved changes.

9. `lib/manager/address_manager.dart`
   - Added methods `deleteByName`, `deleteById`, and `getAddressIdFromName` for better address management.

10. `lib/repository/address_repository.dart`
    - Updated `delete` method to accept `addressId` instead of `address`.
    - Added `moveAdsAddressTo` method for moving advertisements to another address.
    - Added `adsInAddress` method to retrieve advertisements associated with a specific address.

11. `lib/repository/advert_repository.dart`
    - Updated `delete` method to accept `adId` instead of `ad`.
    - Added `moveAdsAddressTo` and `adsInAddress` methods to support address management.

12. `pubspec.yaml`
    - Updated version to `0.5.3+23`.

These changes collectively enhance the address management functionality, introduce new dialog widgets for better user interaction, and update the repository methods to handle advertisement associations with addresses.


## 2024/07/30 - version: 0.5.2+22

This commit introduces several enhancements and fixes across multiple files:

1. `lib/common/models/advert.dart`
   - Added `deleted` status to the `AdvertStatus` enum.

2. `lib/common/singletons/current_user.dart`
   - Imported `get_it.dart`.
   - Changed the initialization of `addressManager` to use `getIt<AddressManager>()`.

3. `lib/common/utils/extensions.dart`
   - Added a new extension method `onlyNumbers` to `StringExtension`.

4. `lib/common/validators/validators.dart`
   - Imported `extensions.dart`.
   - Renamed `nickname` validation method to `name`.
   - Enhanced `phone` validation to include various checks like length, area code, and valid mobile/landline number.
   - Added `DataValidator` class with methods for validating password, confirming password, name, and phone.

5. `lib/components/custom_drawer/custom_drawer.dart`
   - Removed redundant imports.
   - Updated `CustomDrawer` constructor and properties.
   - Refactored `_navToLoginScreen` method into `navToLoginScreen`.
   - Adjusted `ListTile` items to use `ctrl.jumpToPage`.

6. `lib/components/form_fields/password_form_field.dart`
   - Added `fullBorder` parameter to `PasswordFormField`.
   - Conditional application of `OutlineInputBorder`.

7. `lib/components/others_widgets/state_error_message.dart`
   - New file: Added `StateErrorMessage` widget for displaying error messages.

8. `lib/components/others_widgets/state_loading_message.dart`
   - New file: Added `StateLoadingMessage` widget for displaying loading messages.

9. `lib/features/address/address_controller.dart`
   - Changed the initialization of `addressManager` to use `getIt<AddressManager>()`.

10. `lib/features/address/address_screen.dart`
    - Disabled `_removeAddress` button and added comments for future implementation.

11. `lib/features/base/base_controller.dart`
    - Added `user` getter.
    - Refactored `jumpToPage` and `setPageTitle` methods.
    - Adjusted `titles` constant to reflect updated page titles.

12. `lib/features/base/base_screen.dart`
    - Updated `titleWidget` to use `ctrl.pageTitle`.
    - Added `navToLoginScreen` method.
    - Replaced `CircularProgressIndicator` with `StateLoadingMessage`.

13. `lib/features/login/login_screen.dart`
    - Added `StateErrorMessage` and `StateLoadingMessage` for error and loading states.
    - Threw exception for unimplemented navigation actions.

14. `lib/features/my_account/my_account_screen.dart`
    - Added imports for `AddressScreen` and `MyDataScreen`.
    - Updated `ListTile` items to use the new screens.

15. `lib/features/my_ads/my_ads_controller.dart`
    - Commented out the call to `AdvertRepository.delete` and added a status update using `AdvertRepository.updateStatus`.

16. `lib/features/my_data/my_data_controller.dart`
    - New file: Added `MyDataController` for managing user data.

17. `lib/features/my_data/my_data_screen.dart`
    - New file: Added `MyDataScreen` for displaying and editing user data.

18. `lib/features/my_data/my_data_state.dart`
    - New file: Added `MyDataState` classes for representing different states in `MyDataController`.

19. `lib/features/product/widgets/title_product.dart`
    - Added optional `color` parameter to `TitleProduct`.

20. `lib/features/shop/shop_screen.dart`
    - Added `StateErrorMessage` and `StateLoadingMessage` for error and loading states.
    - Adjusted `FloatingActionButton` behavior to reinitialize the controller after login.

21. `lib/features/signup/signup_controller.dart`
    - Renamed `nicknameController` to `nameController`.
    - Updated focus nodes and controller disposal.

22. `lib/features/signup/widgets/signup_form.dart`
    - Updated to use `nameController` and `phoneFocusNode`.

23. `lib/get_it.dart`
    - Registered `AddressManager` as a lazy singleton.

24. `lib/manager/address_manager.dart`
    - Removed singleton pattern in favor of dependency injection.

25. `lib/my_material_app.dart`
    - Added route for `MyDataScreen`.

26. `lib/repository/advert_repository.dart`
    - Updated `updateStatus` method to use `parse.update`.

27. `lib/repository/user_repository.dart`
    - Added `update` method for updating user information.

These changes collectively enhance functionality, improve code readability, and address various bugs.


## 2024/07/29 - version: 0.5.2+21

Renamed Advertisement Features and Updated Navigation

1. Updated Navigation in `lib/components/custom_drawer/custom_drawer.dart`:
   - Changed import from `AdvertScreen` to `EditAdvertScreen`.
   - Updated navigation from `AdvertScreen` to `EditAdvertScreen`.

2. Modified Navigation in `lib/features/base/base_screen.dart`:
   - Changed import from `AccountScreen` to `MyAccountScreen`.
   - Updated the last screen in `PageView` to `MyAccountScreen`.

3. Renamed Advertisement Controller and State:
   - Renamed `lib/features/advertisement/advert_controller.dart` to `lib/features/edit_advert/edit_advert_controller.dart`.
   - Renamed `AdvertController` to `EditAdvertController`.
   - Updated state management classes from `AdvertState` to `EditAdvertState`.

4. Renamed Advertisement Screen:
   - Renamed `lib/features/advertisement/advert_screen.dart` to `lib/features/edit_advert/edit_advert_screen.dart`.
   - Renamed `AdvertScreen` to `EditAdvertScreen`.

5. Updated Advertisement State Class Names:
   - Renamed `lib/features/advertisement/advert_state.dart` to `lib/features/edit_advert/edit_advert_state.dart`.
   - Updated state classes from `AdvertState` to `EditAdvertState`.

6. Updated Advertisement Form and Widgets:
   - Renamed advertisement form and widget files to `edit_advert` equivalents.

7. Renamed Account Screen:
   - Renamed `lib/features/account/account_screen.dart` to `lib/features/my_account/my_account_screen.dart`.
   - Renamed `AccountScreen` to `MyAccountScreen`.

8. Updated References in My Ads Screen:
   - Updated import and usage from `AdvertScreen` to `EditAdvertScreen`.

9. Updated Shop Screen Navigation:
   - Changed navigation from `AdvertScreen` to `EditAdvertScreen`.

10. Updated Main App Navigation:
    - Changed import and route from `AccountScreen` to `MyAccountScreen`.
    - Updated the route for advertisement screen to `EditAdvertScreen`.

These changes refactor the advertisement feature by renaming relevant files and classes for better clarity and organization. Navigation has been updated accordingly to reflect these changes.


## 2024/07/29 - version: 0.5.2+20

Enhanced Advertisement Features and Refactoring

1. `lib/common/app_constants.dart`
   - Created a new file to define the `AppPage` enum with values `shopePage`, `chatPage`, `favoritesPage`, and `accountPage` for better navigation handling.

2. `lib/components/buttons/big_button.dart`
   - Updated the button's `borderRadius` to 32 for a more rounded appearance.

3. `lib/components/custom_drawer/custom_drawer.dart`
   - Imported `AppPage` enum from `app_constants.dart` and `AdvertScreen`.
   - Replaced hard-coded page numbers with `AppPage` enum values for improved readability and maintainability.

4. `lib/components/others_widgets/ad_list_view/ad_list_view.dart`
   - Added `editAd` and `deleteAd` callbacks to handle advertisement editing and deletion.
   - Removed logging and simplified button actions to call the new callbacks.

5. `lib/features/account/account_screen.dart`
   - Imported `AppPage` enum from `app_constants.dart`.
   - Replaced hard-coded page number with `AppPage.shopePage` for navigation after logout.

6. `lib/features/advertisement/advert_controller.dart`
   - Updated `init` method to use `setSelectedAddress` for setting the address.
   - Improved `removeImage` method to handle both URL and local file deletion.
   - Added `updateAds` method to update an existing advertisement.
   - Renamed `createAnnounce` to `createAds` and adjusted its implementation.

7. `lib/features/advertisement/advert_screen.dart`
   - Added an AppBar with dynamic title based on whether the ad is new or being edited.
   - Updated `_createAnnounce` method to handle both ad creation and updating, returning to the previous screen with the updated ad.

8. `lib/features/advertisement/widgets/advert_form.dart`
   - Updated icons in `SegmentedButton` for better representation of `AdvertStatus` values.

9. `lib/features/advertisement/widgets/horizontal_image_gallery.dart`
   - Added `showImage` method to handle displaying both network and local images.
   - Adjusted `_showImageEditDialog` to show either a network or local image based on the URL pattern.

10. `lib/features/advertisement/widgets/image_list_view.dart`
    - Added `editAd` and `deleteAd` callbacks for handling ad editing and deletion.

11. `lib/features/base/base_controller.dart`
    - Imported `AppPage` enum from `app_constants.dart`.
    - Replaced `_page` type from `int` to `AppPage` for better type safety and readability.

12. `lib/features/base/base_screen.dart`
    - Imported `AppPage` enum from `app_constants.dart`.
    - Updated various navigation references to use `AppPage` enum values.

13. `lib/features/my_ads/my_ads_controller.dart`
    - Implemented `updateAd` method to refresh ads after an update.
    - Implemented `deleteAd` method to delete an advertisement and refresh the ads list.

14. `lib/features/my_ads/my_ads_screen.dart`
    - Added methods `_editAd` and `_deleteAd` to handle editing and deletion of advertisements with confirmation dialogs.
    - Updated `MyTabBarView` usage to include `editAd` and `deleteAd` callbacks.

15. `lib/features/my_ads/widgets/my_tab_bar.dart`
    - Updated icons in `Tab` widgets for better representation of advertisement statuses.

16. `lib/features/my_ads/widgets/my_tab_bar_view.dart`
    - Added `editAd` and `deleteAd` callbacks to `AdListView`.

17. `lib/features/shop/shop_screen.dart`
    - Imported `AdvertScreen`.
    - Updated `FloatingActionButton` to navigate to `AdvertScreen` for adding a new advertisement.

18. `lib/repository/advert_repository.dart`
    - Added `update` method to update an advertisement on the Parse server.
    - Improved `_saveImages` method to correctly identify URL patterns.
    - Added `delete` method to delete an advertisement from the Parse server.

These changes enhance the advertisement management features by improving navigation with the `AppPage` enum, adding capabilities for editing and deleting ads, and refining the UI components for better user experience and maintainability. The refactor also ensures the codebase is more readable and easier to manage.


## 2024/07/29 - version: 0.5.2+19

Enhanced Advertisement Features and Refactoring

1. `lib/common/models/advert.dart`
   - Reordered the `title` property to appear before `status` in the `AdvertModel` class for consistency.

2. `lib/components/custon_field_controllers/currency_text_controller.dart`
   - Added `currencyValue` setter to update the text value of the controller based on the provided currency value. This simplifies setting the currency value programmatically.

3. `lib/components/others_widgets/ad_list_view/ad_list_view.dart`
   - Imported `dart:developer` for logging purposes.
   - Added `ButtonBehavior` enum to define possible button actions (`edit`, `delete`).
   - Replaced `itemButton` parameter with `buttonBehavior` to handle different button actions dynamically.
   - Added `getItemButton` method to generate the appropriate button widget based on `buttonBehavior`.
   - Enhanced logging to include the length of ads list to aid in debugging and monitoring the list state.

4. `lib/components/others_widgets/ad_list_view/widgets/ad_card_view.dart`
   - Updated the `Card` widget with a `shape` property, applying `RoundedRectangleBorder` to provide rounded corners for better visual appeal.

5. `lib/features/advertisement/advert_controller.dart`
   - Added `init` method to initialize the controller with an `AdvertModel` instance, populating various fields like `title`, `description`, `hidePhone`, `price`, `status`, `mechanicsId`, `address`, and `images`.
   - Added `setImages` method to set the list of images in the controller, updating the `_images` list and notifying listeners.

6. `lib/features/advertisement/advert_screen.dart`
   - Updated constructor to accept an optional `AdvertModel` instance, allowing the screen to display and edit existing advertisements.
   - Added initialization of `AdvertController` with the provided `AdvertModel` instance in `initState` to pre-fill the form fields with existing data.

7. `lib/features/my_ads/my_ads_controller.dart`
   - Added placeholder methods `updateAd` and `deleteAd` with TODO comments indicating future implementation plans for updating and deleting advertisements.

8. `lib/features/my_ads/my_ads_screen.dart`
   - Refactored to replace direct usage of `TabBar` and `TabBarView` with custom widgets `MyTabBar` and `MyTabBarView` to improve code modularity and readability.
   - Added custom `MyTabBar` widget to handle tab selection and update the product status in the controller.
   - Added custom `MyTabBarView` widget to display advertisements based on their status, with configurable dismissible actions and button behaviors.

9. `lib/features/my_ads/widgets/my_tab_bar.dart`
   - Implements a custom `TabBar` widget that maps tab selection to product status changes in the `MyAdsController`.

10. `lib/features/my_ads/widgets/my_tab_bar_view.dart`
    - Implements a custom `TabBarView` widget that displays a list of advertisements with different statuses, using `AdListView` with configurable actions for each tab.

11. `lib/my_material_app.dart`
    - Updated routing logic to handle `AdvertScreen` navigation, passing an `AdvertModel` instance when navigating to allow for ad editing.
    - Simplified `onGenerateRoute` method for better readability, ensuring all routes handle their respective arguments correctly.

These changes enhance the advertisement management capabilities by adding the ability to edit and delete ads directly from the list, initializing controllers with existing ad data, and modularizing the UI components for better code organization and maintainability. The refactor also improves the overall user experience by making the UI more intuitive and the codebase easier to maintain and extend.


## 2024/07/26 - version: 0.5.2+18

Improved Advertisement Management and Code Refactoring

1. `lib/common/basic_controller/basic_controller.dart`
   - **Added**: `Future<bool> updateAdStatus(AdvertModel ad)` method to update advertisement status.

2. `lib/common/singletons/current_user.dart`
   - **Imported**: `foundation.dart` to use `ValueNotifier`.
   - **Added**: `_isLoged` as `ValueNotifier<bool>` to manage login state.
   - **Updated**: `isLoged` to use `_isLoged.value` and added `isLogedListernable` getter.
   - **Modified**: `init` method to update `_isLoged.value` upon initialization.
   - **Added**: `dispose` method to dispose of `_isLoged`.
   - **Updated**: `logout` method to set `_isLoged.value` to false.

3. `lib/components/custom_drawer/custom_drawer.dart`
   - **Updated**: Menu item text from 'Inserir Anúncio' to 'Adicionar Anúncio'.

4. `lib/features/shop/widgets/ad_list_view.dart`
   - **Renamed**: File to `lib/components/others_widgets/ad_list_view/ad_list_view.dart`.
   - **Replaced**: `ShopController` with `BasicController`.
   - **Enhanced**: `AdListView` with new parameters for dismissible ads and additional properties.

5. `lib/components/others_widgets/ad_list_view/widgets/ad_card_view.dart`
   - **New File**: Handles the display of advertisement cards with various properties.

6. `lib/components/others_widgets/ad_list_view/widgets/dismissible_ad.dart`
   - **New File**: Manages dismissible ads with customizable actions and status updates.

7. `lib/components/others_widgets/ad_list_view/widgets/show_image.dart`
   - **New File**: Manages image display with a fallback for empty images.

8. `lib/components/others_widgets/base_dismissible_container.dart`
   - **New File**: Provides a base container for dismissible actions in the UI.

9. `lib/components/others_widgets/fitted_button_segment.dart`
   - **New File**: Defines a fitted button segment for use in segmented controls.

10. `lib/features/advertisement/advert_controller.dart`
    - **Added**: `_adStatus` property and corresponding getter.
    - **Refactored**: Moved `_changeState` method to a different position.
    - **Updated**: `saveAd` method to include `status` property.
    - **Added**: `setAdStatus` method to update advertisement status.

11. `lib/features/advertisement/advert_screen.dart`
    - **Wrapped**: `AdvertForm` and `BigButton` inside a `Column` for better structure.

12. `lib/features/advertisement/widgets/advert_form.dart`
    - **Imported**: `fitted_button_segment.dart` for custom button segments.
    - **Added**: Segmented button for selecting `AdvertStatus`.

13. `lib/features/base/base_controller.dart`
    - **Updated**: Title from 'Criar Anúncio' to 'Adicionar Anúncio' for consistency.

14. `lib/features/my_ads/my_ads_controller.dart`
    - **Refactored**: `getAds` method to use a helper method `_getAds`.
    - **Added**: `_getAds` and `_getMoreAds` helper methods for better code organization.
    - **Added**: `updateAdStatus` method to handle advertisement status updates.

15. `lib/features/my_ads/my_ads_screen.dart`
    - **Enhanced**: `AdListView` to support dismissible ads with custom status updates and icons.
    - **Added**: `physics` property to `TabBarView` to disable scrolling.

16. `lib/features/shop/shop_controller.dart`
    - **Refactored**: `getAds` method to reset `_adPage` and clear ads.
    - **Added**: `updateAdStatus` method with `UnimplementedError`.

17. `lib/features/shop/shop_screen.dart`
    - **Updated**: Import path for `ad_list_view.dart`.
    - **Added**: `ValueListenableBuilder` to manage `FloatingActionButton` state based on login status.

18. `lib/features/shop/widgets/ad_text_price.dart`
    - **Removed**: Unused `colorScheme` variable.
    - **Updated**: Text style for better readability.

19. `lib/features/shop/widgets/ad_text_title.dart`
    - **Changed**: `maxLines` from 3 to 2 for better layout consistency.

20. `lib/get_it.dart`
    - **Added**: `dispose` call for `CurrentUser`.

21. `lib/my_material_app.dart`
    - **Changed**: Main font from "Poppins" to "Manrope" for a refreshed UI look.

22. `lib/repository/advert_repository.dart`
    - **Added**: `updateStatus` method to update advertisement status in the Parse server.

These changes enhance the advertisement management capabilities by adding new functionalities and refactoring the code for better maintainability and usability. The updates improve user experience and ensure consistent behavior across the application.


## 2024/07/26 - version: 0.5.1+17

This commit includes several adjustments to animations, a reduction in the number of `AdvertStatus` options, and various other enhancements to improve code consistency and functionality. Changes:

1. lib/common/models/advert.dart
   - Removed `AdvertStatus.closed` from the `AdvertStatus` enum.

2. lib/common/theme/app_text_style.dart
   - Added `font14Thin` style for thinner text with font size 14.

3. lib/features/my_ads/my_ads_controller.dart
   - Added properties `_adPage`, `_getMorePages`, and `getMorePages`.
   - Implemented logic to fetch additional pages of advertisements in `getMoreAds`.

4. lib/features/my_ads/my_ads_screen.dart
   - Updated `TabBar` length to 3 to remove the unnecessary "Fechados" tab.
   - Adjusted text styles for consistency.
   - Enhanced error and loading state handling.

5. lib/features/product/product_screen.dart
   - Adjusted `AnimationController` duration for `FloatingActionButton` to 300 milliseconds.
   - Simplified scroll notification handling logic.

6. lib/features/shop/shop_controller.dart
   - Refactored to extend `BasicController` and use `BasicState` for state management.
   - Added initialization and pagination logic for fetching advertisements.

7. lib/features/shop/shop_screen.dart
   - Refactored to integrate `BasicState` for consistent state management.
   - Updated `AnimationController` duration and scroll listener logic.
   - Improved `FloatingActionButton` animation and visibility handling.

8. lib/my_material_app.dart
   - Changed the text theme order in `createTextTheme` to prioritize "Poppins" over "Comfortaa".

9. lib/repository/advert_repository.dart
   - Removed the `maxAdsPerList` constant and relocated it to `constants.dart`.

10. lib/repository/constants.dart
    - Added `maxAdsPerList` constant and set its value to 5 for better performance during testing.

Standardized animations for `FloatingActionButton`, streamlined advertisement status options, and improved overall state management and UI consistency across various features.


## 2024/07/26 - version: 0.5.0+16

This commit introduces several new files and modifications to the existing codebase, adding functionalities and enhancements, including dependency injection with `get_it`. Changes:

1. lib/common/basic_controller/basic_controller.dart
   - Added new file with `BasicController` abstract class.
   - Defined state management and basic functionalities such as `changeState`, `init`, `getAds`, and `getMoreAds`.

2. lib/common/basic_controller/basic_state.dart
   - Added new file defining `BasicState` abstract class and its concrete implementations: `BasicStateInitial`, `BasicStateLoading`, `BasicStateSuccess`, and `BasicStateError`.

3. lib/common/models/address.dart
   - Added `import 'dart:convert';`.
   - Included `createdAt` property in `AddressModel`.
   - Modified constructor to initialize `createdAt`.
   - Updated `toString`, `==`, and `hashCode` methods to include `createdAt`.
   - Added `copyWith` method.
   - Added `toMap`, `fromMap`, `toJson`, and `fromJson` methods for serialization.

4. lib/common/models/user.dart
   - Removed commented out `UserType type;` and related code.
   - Simplified constructor initialization.

5. lib/common/singletons/app_settings.dart
   - Refactored `AppSettings` to remove singleton pattern, allowing for direct instantiation.

6. lib/common/singletons/current_user.dart
   - Refactored `CurrentUser` to remove singleton pattern, allowing for direct instantiation.
   - Added `logout` method to handle user logout.

7. lib/common/singletons/search_filter.dart
   - Refactored `SearchFilter` to remove singleton pattern, allowing for direct instantiation.
   - Added `dispose` method to clean up resources.

8. lib/common/singletons/search_history.dart
   - Refactored `SearchHistory` to remove singleton pattern, allowing for direct instantiation.

9. lib/components/custom_drawer/custom_drawer.dart
   - Updated imports and added dependency injection with `getIt`.
   - Refactored navigation methods to use `jumpToPage` from `BaseController`.
   - Enhanced `ListTile` widgets to conditionally enable/disable based on user login status.

10. lib/components/custom_drawer/widgets/custom_drawer_header.dart
    - Updated imports and added dependency injection with `getIt`.
    - Refactored `isLogin` to `isLoged` for better readability.

11. lib/features/account/account_screen.dart
    - Converted `AccountScreen` to a `StatefulWidget`.
    - Implemented user information display and various action items.

12. lib/features/advertisement/advert_controller.dart
    - Updated imports and added dependency injection with `getIt`.

13. lib/features/base/base_controller.dart
    - Updated imports and added dependency injection with `getIt`.

14. lib/features/base/base_screen.dart
    - Refactored `BaseScreen` to use dependency injection with `getIt`.
    - Removed redundant `_changeToPage` method and updated `CustomDrawer`.

15. lib/features/base/widgets/search_controller.dart
    - Updated imports and added dependency injection with `getIt`.

16. lib/features/base/widgets/search_dialog.dart
    - Updated imports and added dependency injection with `getIt`.

17. lib/features/login/login_controller.dart
    - Updated imports and added dependency injection with `getIt`.

18. lib/features/my_ads/my_ads_controller.dart
    - Added new file with `MyAdsController` extending `BasicController`.
    - Implemented `init`, `getAds`, `getMoreAds`, and `setProductStatus` methods.

19. lib/features/my_ads/my_ads_screen.dart
    - Added new file with `MyAdsScreen` implementing a stateful widget.
    - Integrated `MyAdsController` and implemented UI with tabs for different ad statuses.

20. lib/features/my_ads/my_ads_state.dart
    - Added new file defining `MyAdsState` abstract class and its concrete implementations: `MyAdsStateInitial`, `MyAdsStateLoading`, `MyAdsStateSuccess`, and `MyAdsStateError`.

21. lib/features/my_ads/widgets/my_ad_list_view.dart
    - Added new file implementing `AdListView` widget with scroll and image handling capabilities.

22. lib/features/new_address/new_address_controller.dart
    - Updated imports and added dependency injection with `getIt`.

23. lib/features/shop/shop_controller.dart
    - Updated imports and added dependency injection with `getIt`.

24. lib/features/shop/shop_screen.dart
    - Refactored `ShopScreen` to use dependency injection with `getIt`.
    - Removed redundant `changeToPage` method.

25. lib/features/signup/signup_controller.dart
    - Updated imports and added dependency injection with `getIt`.

26. lib/get_it.dart
    - Added new file to setup and dispose dependencies using `get_it`.

27. lib/main.dart
    - Integrated `get_it` for dependency injection.
    - Updated initialization to use `setupDependencies`.

28. lib/my_material_app.dart
    - Updated imports and added dependency injection with `getIt`.
    - Refactored `initialRoute` and `onGenerateRoute` for better route management.

29. lib/repository/address_repository.dart
    - Added a comment for potential fix regarding `toPointer` usage.

30. lib/repository/advert_repository.dart
    - Added `getMyAds` method to fetch user-specific advertisements.
    - Refactored query logic to use consistent naming conventions.

31. lib/repository/constants.dart
    - Added `keyAddressCreatedAt` constant.

32. lib/repository/parse_to_model.dart
    - Updated `ParseToModel` methods to include `createdAt` property.

33. pubspec.lock
    - Added `get_it` dependency.

34. pubspec.yaml
    - Added `get_it` to dependencies.

Implemented new controllers, refactored singletons to use dependency injection, enhanced UI components, and integrated `get_it` for dependency management, improving state management and overall code maintainability.


## 2024/07/25 - version: 0.5.0+15

This commit introduces enhancements to the Product and Shop screens, adds a new ReadMoreText component, and adjusts the theme colors.

1. lib/common/theme/app_text_style.dart
   - Added new text styles: `font24`, `font24SemiBold`, and `font24Bold`.

2. lib/common/theme/theme.dart
   - Updated various color definitions for better UI consistency: `primaryContainer`, `secondary`, `primaryFixed`, `tertiaryFixedDim`, `onPrimaryFixedVariant`, `surfaceContainer`, and others.

3. lib/components/custom_drawer/custom_drawer.dart
   - Changed the icon for 'Inserir Anúncio' from `Icons.edit` to `Icons.camera`.

4. lib/components/custom_drawer/widgets/custom_drawer_header.dart
   - Wrapped texts in `FittedBox` for better scaling and to ensure the text fits within the designated area.

5. lib/components/customs_text/read_more_text.dart
   - Added the new `ReadMoreText` component for handling expandable text with 'read more' and 'show less' functionality.

6. lib/features/base/base_screen.dart
   - Updated `PageView` children to include `ShopScreen(_changeToPage)` and modified the `ShopScreen` instantiation.

7. lib/features/product/product_screen.dart
   - Converted `ProductScreen` to a `StatefulWidget` to manage animations for floating action buttons.
   - Added a floating action button for contacting the advertiser via phone or chat.
   - Introduced various product detail widgets: `PriceProduct`, `TitleProduct`, `DescriptionProduct`, `LocationProduct`, and `UserCard`.

8. lib/features/product/widgets/description_product.dart
   - Created `DescriptionProduct` widget using the `ReadMoreText` component.

9. lib/features/product/widgets/duo_segmented_button.dart
   - Created `DuoSegmentedButton` widget for segmented button functionality.

10. lib/features/product/widgets/image_carousel.dart
    - Created `ImageCarousel` widget for displaying product images using `carousel_slider`.

11. lib/features/product/widgets/location_product.dart
    - Created `LocationProduct` widget for displaying product location details.

12. lib/features/product/widgets/price_product.dart
    - Created `PriceProduct` widget for displaying product price.

13. lib/features/product/widgets/sub_title_product.dart
    - Created `SubTitleProduct` widget for displaying subtitles in product details.

14. lib/features/product/widgets/title_product.dart
    - Created `TitleProduct` widget for displaying the product title.

15. lib/features/product/widgets/user_card_product.dart
    - Created `UserCard` widget for displaying user information related to the product.

16. lib/features/shop/shop_screen.dart
    - Updated `ShopScreen` to manage animations for floating action buttons.
    - Added a floating action button to navigate to the advertisement screen.

17. lib/features/shop/widgets/ad_list_view.dart
    - Updated `AdListView` to use the shared `ScrollController` for handling list view scroll behavior.
    - Added `InkWell` to navigate to the `ProductScreen` on ad click.

18. lib/features/shop/widgets/ad_text_price.dart
    - Removed unnecessary padding and updated text style for ad price.

19. lib/features/shop/widgets/ad_text_title.dart
    - Removed unnecessary padding and updated text style for ad title.

20. lib/my_material_app.dart
    - Changed default text theme from "Nunito Sans" to "Comfortaa".
    - Updated route handling for `ShopScreen` to pass a callback for page changes.

21. pubspec.yaml and pubspec.lock
    - Added dependency for `carousel_slider` version `4.2.1`.

These changes enhance the user experience by improving the UI consistency, adding new functionalities, and optimizing existing components.


## 2024/07/24 - version: 0.4.2+14

# Commit Message

Refactored Parse Server integration for improved error handling and code maintainability. Changes made:

1. **lib/common/parse_server/errors_mensages.dart**
   - Modified `ParserServerErrors.message` to accept a `String` parameter.
   - Added logic to identify specific error messages.

2. **lib/common/singletons/current_user.dart**
   - Updated method names in `CurrentUser` to align with `AddressManager`.

3. **lib/components/custom_drawer/custom_drawer.dart**
   - Ensured drawer closes after logout.

4. **lib/features/address/address_controller.dart**
   - Updated method calls to match `AddressManager` changes.

5. **lib/features/home/home_controller.dart**
   - Changed method calls in `HomeController` to use `AdvertRepository.get`.

6. **lib/features/login/login_screen.dart**
   - Adjusted error message handling to pass `String`.

7. **lib/features/signup/signup_controller.dart**
   - Separated user signup and state change logic.

8. **lib/features/signup/signup_screen.dart**
   - Updated error handling to pass `String`.

9. **lib/manager/address_manager.dart**
   - Added comments and updated methods for address operations.

10. **lib/manager/mechanics_manager.dart**
    - Added logging and improved error handling.

11. **lib/manager/state_manager.dart**
    - Added comments for clarity.

12. **lib/repository/address_repository.dart**
    - Enhanced logging and exception messages.
    - Updated methods to ensure consistency and clarity.

13. **lib/repository/advert_repository.dart**
    - Improved logging and error handling.
    - Added method comments for better understanding.

14. **lib/repository/ibge_repository.dart**
    - Enhanced logging and exception handling.
    - Added method comments for clarity.

15. **lib/repository/mechanic_repository.dart**
    - Improved logging and error handling.
    - Removed redundant parsing method.

16. **lib/repository/parse_to_model.dart**
    - Added comments to methods for better understanding.
    - Updated parsing logic for `AdvertModel`.

17. **lib/repository/user_repository.dart**
    - Enhanced logging and error handling.
    - Added `_checksPermissions` method to handle ACL settings.

18. **lib/repository/viacep_repository.dart**
    - Enhanced logging and error handling.
    - Updated method to clean CEP and handle exceptions.

This commit refactors various parts of the code related to Parse Server integration. It improves error handling, logging, and overall code maintainability by adding comments and ensuring consistent method usage.


## 2024/07/24 - version: 0.4.1+13

Updated various project files to enhance functionality and improve maintainability.

1. **android/app/build.gradle**
   - Updated `flutterVersionCode` and `flutterVersionName` initialization to include default values.
   - Changed `namespace` and `applicationId`.
   - Added lint options for Java compilation.
   - Added dependency for `ucrop` library.

2. **android/app/src/main/AndroidManifest.xml**
   - Added `package` attribute to the manifest tag.

3. **android/app/src/main/kotlin/com/example/bgbazzar/MainActivity.kt**
   - Updated package name.

4. **android/build.gradle**
   - Added Kotlin version and dependencies.
   - Updated Gradle plugin version.

5. **android/gradle.properties**
   - Added lint option for deprecation warnings.
   - Suppressed unsupported compile SDK warning.

6. **android/gradle/wrapper/gradle-wrapper.properties**
   - Updated Gradle distribution URL.

7. **lib/common/app_info.dart**
   - Created a new file to handle application information and utilities such as URL launching and copying.

8. **lib/common/models/address.dart**
   - Removed unused imports and JSON conversion methods.

9. **lib/common/models/advert.dart**
   - Updated model structure to use `UserModel` for owner and `AddressModel` for address.
   - Reorganized fields.

10. **lib/common/models/filter.dart**
    - Added `setFilter` method to update filter model.

11. **lib/common/models/user.dart**
    - Removed unused imports and JSON conversion methods.

12. **lib/common/parse_server/errors_mensages.dart**
    - Removed logging.

13. **lib/common/singletons/app_settings.dart**
    - Removed unused fields and methods.

14. **lib/common/singletons/search_filter.dart**
    - Created a new singleton to manage search filter state.

15. **lib/common/singletons/search_history.dart**
    - Removed logging.

16. **lib/common/theme/app_text_style.dart**
    - Created a new file to manage application text styles.

17. **lib/common/theme/text_styles.dart** renamed to **lib/common/utils/extensions.dart**
    - Renamed file and converted to manage number and datetime extensions.

18. **lib/components/custom_drawer/custom_drawer.dart**
    - Added a new logout option in the drawer menu.

19. **lib/features/advertisement/advert_controller.dart**
    - Updated model usage for creating advertisements.

20. **lib/features/advertisement/widgets/horizontal_image_gallery.dart**
    - Removed logging.

21. **lib/features/base/base_controller.dart**
    - Integrated `SearchFilter` singleton.
    - Updated search handling methods.

22. **lib/features/base/base_screen.dart**
    - Integrated `SearchFilter` and added actions for search and filter management.

23. **lib/features/base/widgets/search_controller.dart**
    - Removed logging.

24. **lib/features/base/widgets/search_dialog.dart**
    - Removed commented code and logging.

25. **lib/features/base/widgets/search_dialog_bar.dart**
    - Removed logging.

26. **lib/features/filters/widgets/text_title.dart**
    - Updated import to use new text styles.

27. **lib/features/home/home_controller.dart**
    - Integrated `SearchFilter` and updated advertisement fetching logic.

28. **lib/features/home/home_screen.dart**
    - Integrated `AdListView` for displaying advertisements.

29. **lib/features/home/widgets/ad_list_view.dart**
    - Created a new widget to manage advertisement list view.

30. **lib/features/home/widgets/ad_text_info.dart**
    - Created a new widget for displaying advertisement info.

31. **lib/features/home/widgets/ad_text_price.dart**
    - Created a new widget for displaying advertisement price.

32. **lib/features/home/widgets/ad_text_subtitle.dart**
    - Created a new widget for displaying advertisement subtitle.

33. **lib/features/home/widgets/ad_text_title.dart**
    - Created a new widget for displaying advertisement title.

34. **lib/features/signup/signup_screen.dart**
    - Removed logging.

35. **lib/my_material_app.dart**
    - Added localization support.
    - Removed logging.

36. **lib/repository/address_repository.dart**
    - Refactored to use `ParseToModel` for model conversion.
    - Removed redundant logging.

37. **lib/repository/advert_repository.dart**
    - Refactored to use `ParseToModel` for model conversion.
    - Added pagination support for fetching advertisements.

38. **lib/repository/parse_to_model.dart**
    - Created a new utility class for converting Parse objects to models.

39. **lib/repository/user_repository.dart**
    - Refactored to use `ParseToModel` for model conversion.
    - Added logout method.

40. **linux/flutter/generated_plugin_registrant.cc**
    - Added URL launcher plugin registration.

41. **linux/flutter/generated_plugins.cmake**
    - Added URL launcher plugin.

42. **macos/Flutter/GeneratedPluginRegistrant.swift**
    - Added URL launcher and SQLite plugins registration.

43. **pubspec.lock**
    - Updated dependencies and added new ones for cached network image, URL launcher, SQLite, and localization support.

44. **pubspec.yaml**
    - Updated version and added new dependencies for cached network image, URL launcher, and localization support.

45. **windows/flutter/generated_plugin_registrant.cc**
    - Added URL launcher plugin registration.

46. **windows/flutter/generated_plugins.cmake**
    - Added URL launcher plugin.

47. **lib/common/models/address.dart**
    - Removed redundant methods `toMap`, `fromMap`, `toJson`, and `fromJson`.

48. **lib/common/models/advert.dart**
    - Consolidated imports and refactored field organization for better readability and maintainability.

49. **lib/common/models/user.dart**
    - Removed redundant methods `toMap`, `fromMap`, `toJson`, and `fromJson`.

50. **lib/common/parse_server/errors_mensages.dart**
    - Streamlined the error message handling by removing the unnecessary logging of errors.

51. **lib/features/home/home_screen.dart**
    - Updated the `HomeScreen` layout and integrated the `AdListView` to improve user experience and performance.

52. **lib/repository/address_repository.dart**
    - Improved exception handling and removed redundant code for better code quality.

53. **lib/repository/advert_repository.dart**
    - Added pagination and improved the handling of search and filter functionality to enhance the user experience.

54. **lib/repository/user_repository.dart**
    - Enhanced user management with a logout method and improved exception handling.

55. **pubspec.lock**
    - Added `intl_utils` and updated various dependencies to ensure compatibility and leverage new features.

56. **pubspec.yaml**
    - Added dependencies for `intl_utils` to facilitate localization and formatting utilities.

This commit finalizes the enhancements to the project by ensuring all necessary changes are included and properly documented. The updates improve the application's functionality, maintainability, and user experience by integrating new dependencies, refactoring code, and enhancing existing features.


## 2024/07/23 - version: 0.3.5+12

Introduced `ProductCondition` Enum and Refactored `Advert` Models.

1. `lib/common/models/advert.dart`
   - Renamed `AdStatus` to `AdvertStatus`.
   - Added new `ProductCondition` enum.
   - Updated `AdvertModel` to include `condition` property with default value `ProductCondition.all`.
   - Modified constructor to initialize `condition`.
   - Updated `toString` method to include `condition`.

2. `lib/common/models/filter.dart`
   - Imported `advert.dart`.
   - Removed `AdvertiserOrder` enum.
   - Updated `FilterModel` to include `condition` property with default value `ProductCondition.all`.
   - Modified constructor to initialize `condition`.
   - Updated `isEmpty`, `toString`, `==`, and `hashCode` methods to include `condition`.

3. `lib/common/models/user.dart`
   - Commented out `UserType` enum.
   - Removed `type` property from `UserModel` and related methods.

4. `lib/common/singletons/app_settings.dart`
   - Added `search` property to `AppSettings`.

5. `lib/features/advertisement/advert_controller.dart`
   - Added `_condition` property with default value `ProductCondition.used`.
   - Added getter for `condition`.
   - Updated `saveAdvert` method to include `condition`.
   - Added `setCondition` method.

6. `lib/features/advertisement/widgets/advert_form.dart`
   - Imported `advert.dart`.
   - Updated variable name `controller` to `ctrl`.
   - Added UI components to select product condition.
   - Updated form fields to use `ctrl`.

7. `lib/features/base/base_controller.dart`
   - Updated `search` property to use `app.search`.
   - Updated `setSearch` method to use `app.search`.

8. `lib/features/filters/filters_controller.dart`
   - Imported `advert.dart`.
   - Updated `advertiser` property and related methods to use `condition`.

9. `lib/features/filters/filters_screen.dart`
   - Imported `advert.dart`.
   - Updated UI components to select product condition instead of advertiser.

10. `lib/features/home/home_controller.dart`
    - Imported `filter.dart`.
    - Added `filter` property to `HomeController`.
    - Updated `search` property to use `app.search`.

11. `lib/features/home/home_screen.dart`
    - Imported `advert_repository.dart`.
    - Updated floating action button to perform search using `AdvertRepository`.

12. `lib/repository/advert_repository.dart`
    - Added `getAdvertisements` method to fetch ads based on filter and search criteria.
    - Updated `save` method to include `condition`.
    - Updated `_parserServerToAdSale` method to parse `condition`.

13. `lib/repository/constants.dart`
    - Added `keyAdvertCondition` constant.

14. `lib/repository/user_repository.dart`
    - Commented out `type` property setting and retrieval in `UserRepository`.

15. `lib/features/home/home_screen.dart`
    - Updated the floating action button to fetch advertisements using the new `filter` property in `HomeController`.
    - Updated the navigation to the `FiltersScreen` to pass and receive the updated `filter` property.

16. `lib/repository/advert_repository.dart`
    - Added filtering logic in `getAdvertisements` to consider `ProductCondition`.
    - Ensured all advertisement-related operations include the new `condition` property.
    - Updated parsing logic to correctly handle `condition` values from the server.

These changes enhance the flexibility of the advertisement system by allowing users to filter ads based on the condition of the product. This refactoring also simplifies the advertisement model by consolidating advertiser-related properties into the condition. Introduces the `ProductCondition` enum and refactors several models and controllers to support this new property, enhancing the filtering capabilities of advertisements. 


## 2024/07/22 - version: 0.3.4+10

Add enhancements and refactor filter and home functionalities

1. lib/common/models/filter.dart
   - Imported `foundation.dart` for `listEquals`.
   - Added `minPrice` and `maxPrice` to `FilterModel`.
   - Modified the constructor to initialize `state`, `city`, `sortBy`, `advertiser`, `mechanicsId`, `minPrice`, and `maxPrice` with default values.
   - Added `isEmpty` getter to check if the filter is empty.
   - Overrode `toString`, `==`, and `hashCode` to include `minPrice` and `maxPrice`.

2. lib/components/custon_field_controllers/currency_text_controller.dart
   - Added `decimalDigits` parameter to control the number of decimal places.
   - Updated `_formatter` to use `currency` instead of `simpleCurrency`.
   - Updated `_applyMask` and `currencyValue` methods to use `_getDivisionFactor`.
   - Added `_getDivisionFactor` method to calculate the division factor based on `decimalDigits`.

3. lib/features/filters/filters_controller.dart
   - Imported `filter.dart` and `currency_text_controller.dart`.
   - Added `minPriceController` and `maxPriceController` for handling price input.
   - Updated `init` method to accept an optional `FilterModel`.
   - Added `setInitialValues` method to set initial values for the filter.
   - Updated `submitState` and `submitCity` methods to handle exceptions.
   - Updated `mechUpdateNames` method to use `_joinMechNames`.
   - Removed unnecessary log statements.

4. lib/features/filters/filters_screen.dart
   - Updated constructor to accept a `FilterModel`.
   - Updated `initState` to call `ctrl.init` with the provided filter.
   - Updated `_sendFilter` method to use `ctrl.filter`.
   - Added UI components for min and max price input.
   - Added validation for price range.

5. lib/features/filters/widgets/text_form_dropdown.dart
   - Added `focusNode` parameter to `TextFormDropdown`.

6. lib/features/home/home_controller.dart
   - Removed unused methods and properties related to mechanics.

7. lib/features/home/home_screen.dart
   - Updated the filter button to pass the current filter to the `FiltersScreen`.
   - Removed mechanics-related UI components.

8. lib/features/new_address/new_address_screen.dart
   - Removed commented-out code.

9. lib/my_material_app.dart
   - Updated `onGenerateRoute` to pass the `FilterModel` to the `FiltersScreen`.

10. lib/features/filters/filters_screen.dart
    - Enhanced the `FiltersScreen` UI to include new fields for price range filtering.
    - Added input validation for the price range to ensure logical consistency between min and max prices.
    - Adjusted the `FilterModel` handling to accommodate new fields and ensure existing filter states are preserved during navigation and state changes.

11. lib/features/home/home_controller.dart
    - Simplified the `HomeController` by removing mechanics-related methods and properties, focusing it solely on managing the home screen state.

12. lib/features/home/home_screen.dart
    - Enhanced the filter button functionality to display the current filter state.
    - Simplified the UI by removing mechanics-related buttons, focusing the user interface on the primary filtering functionality.

13. lib/features/new_address/new_address_screen.dart
    - Cleaned up the code by removing commented-out lines, ensuring a cleaner and more maintainable codebase.

14. lib/my_material_app.dart
    - Updated the routing logic to correctly pass and handle `FilterModel` instances when navigating to the `FiltersScreen`.
    - Included additional logging for debugging purposes, ensuring better traceability of filter state throughout the application.

These updates collectively enhance the app's structure and overall architecture, improve user experience through better search and filter functionalities, and maintain consistency across the application codebase. The changes reflect ongoing efforts to provide robust and user-friendly features while ensuring a clean, maintainable, and high-performance application.


## 2024/07/22 - version: 0.3.3+9

Add functionalities and general refactorings

1. Added Makefile:
   - Commands to manage Docker (`docker_up` and `docker_down`).
   - Commands for Flutter clean (`flutter_clean`).
   - Commands for Git operations (`git_cached`, `git_commit`, and `git_push`).

2. Added `FilterModel` in `lib/common/models/filter.dart`:
   - Modeling filters for advertisements.

3. Refactored file and class names:
   - Renamed `lib/common/models/uf.dart` to `lib/common/models/state.dart` and updated class name from `UFModel` to `StateBrModel`.

4. Added `SearchHistory` singleton in `lib/common/singletons/search_history.dart`:
   - Manages search history with SharedPreferences.

5. Added `TextStyles` in `lib/common/theme/text_styles.dart`:
   - Defined common text styles for the application.

6. Updated `advert_screen.dart`:
   - Removed unnecessary logging.
   - Integrated new state management for advertisement creation.

7. Enhanced `BaseController` and `BaseScreen`:
   - Added search functionality and integrated `SearchDialog`.

8. Added `SearchDialogController` and `SearchDialog` widget:
   - Manages search functionality and history display.

9. Added `FiltersController` and `FiltersScreen`:
   - Allows filtering advertisements by location, sorting, and mechanics.

10. Updated `mechanics_manager.dart`:
    - Added methods to retrieve mechanics names by IDs.

11. General updates and bug fixes:
    - Improved state handling and UI updates.
    - Refactored method names for clarity and consistency.

12. Updated `pubspec.yaml` version to 0.3.2+8.

13. Updated `home_screen.dart`:
    - Integrated `HomeController` for state management.
    - Added segmented buttons for mechanics and filter selection.
    - Implemented navigation to `MecanicsScreen` and `FiltersScreen`.

14. Added `home_controller.dart` and `home_state.dart`:
    - Managed home screen state and mechanics selection.

15. Updated `main.dart`:
    - Initialized `SearchHistory` during app startup.

16. Updated `state_manager.dart`:
    - Renamed methods and classes to match updated state model.

17. Updated `my_material_app.dart`:
    - Added route for `FiltersScreen`.

18. Updated `ibge_repository.dart`:
    - Renamed methods and updated to use `StateBrModel`.

19. Added tests for `IbgeRepository` in `ibge_repository_test.dart`:
    - Ensured correct functionality for state and city retrieval.

20. Refactored `home_screen.dart`:
    - Integrated `HomeController` for managing the state.
    - Added segmented buttons for mechanics and filter selection.
    - Implemented navigation to `MecanicsScreen` and `FiltersScreen`.

21. Added `home_controller.dart` and `home_state.dart`:
    - Managed the state of the home screen.
    - Provided functionality for mechanics selection and updating the view based on the selected mechanics.

22. Updated `main.dart`:
    - Initialized `SearchHistory` during app startup to ensure search functionality is ready when the app launches.

23. Updated `state_manager.dart`:
    - Renamed methods and classes to align with the updated state model, enhancing code readability and consistency.

24. Updated `my_material_app.dart`:
    - Added a route for `FiltersScreen` to integrate the new filter functionality into the app's navigation.

25. Updated `ibge_repository.dart`:
    - Renamed methods to use `StateBrModel` instead of the previous `UFModel`, ensuring consistency with the updated data models.

26. Added tests for `IbgeRepository` in `ibge_repository_test.dart`:
    - Ensured the correct functionality for state and city retrieval, verifying that the refactored code behaves as expected.

27. Refactored `mechanics_manager.dart`:
    - Added methods `nameFromId` and `namesFromIdList` for retrieving mechanic names based on their IDs.
    - Enhanced functionality to manage and retrieve mechanic names, aiding in cleaner code and improved readability.

28. Added `text_styles.dart`:
    - Defined a centralized `TextStyles` class to manage text styles across the app.
    - Simplified text styling management and ensured consistency in text appearance.

29. Added `search_controller.dart` and `search_dialog.dart`:
    - Implemented a custom search controller and dialog for managing search history and suggestions.
    - Enhanced the search experience by providing users with a history of previous searches and suggestions based on input.

30. Refactored `advert_screen.dart`:
    - Removed redundant log statements for a cleaner codebase.
    - Ensured better readability and maintainability of the code.

31. Refactored `base_controller.dart` and `base_screen.dart`:
    - Integrated search functionality into the base screen.
    - Improved navigation and state management within the base screen.

32. Refactored `filters_controller.dart` and `filters_screen.dart`:
    - Enhanced filters management with improved state handling.
    - Provided a user-friendly interface for selecting filters and mechanics.

33. Updated `Makefile`:
    - Added common commands for Docker, Flutter, and Git operations.
    - Simplified development workflows by providing reusable Makefile commands.

34. Updated `pubspec.yaml`:
    - Bumped the version to `0.3.2+8` to reflect the new features and improvements.
    - Ensured dependencies are up to date, supporting the latest features and bug fixes.

35. Added `home_controller.dart` and `home_screen.dart`:
    - Introduced a home controller to manage the state and interactions on the home screen.
    - Implemented UI elements to allow users to filter and select mechanics easily.
    - Enhanced user experience by providing a more interactive and responsive home screen.

36. Added `filters_states.dart`:
    - Defined states for the filters feature to manage loading, success, and error states.
    - Improved state management, making the filters feature more robust and easier to maintain.

37. Added `search_dialog_bar.dart` and `search_dialog_search_bar.dart`:
    - Provided additional search dialog implementations for various UI scenarios.
    - Enhanced search functionality with better UI integration and user experience.

38. Updated `state_manager.dart`:
    - Refactored to use `StateBrModel` instead of `UFModel`.
    - Improved clarity and consistency in naming conventions.

39. Updated `ibge_repository.dart`:
    - Refactored methods to align with the new state model naming conventions.
    - Ensured consistency and clarity in data retrieval methods.

40. Refactored `my_material_app.dart`:
    - Added route for the new `FiltersScreen`.
    - Improved navigation and ensured all new screens are accessible.

41. Updated `ibge_repository_test.dart`:
    - Refactored tests to align with the new `StateBrModel`.
    - Ensured tests remain up-to-date and cover the new functionality.

42. Added `text_styles.dart`:
    - Introduced a centralized file for text styles to ensure consistency across the app.
    - Made it easier to manage and update text styles in one place.

43. Updated `Makefile`:
    - Added commands for Docker operations (`docker_up`, `docker_down`), Flutter operations (`flutter_clean`), and Git operations (`git_cached`, `git_commit`, `git_push`).
    - Simplified and automated common development tasks, improving developer productivity.

44. Updated `search_history.dart`:
    - Implemented a singleton pattern for managing search history.
    - Added methods to save and retrieve search history using `SharedPreferences`.
    - Enhanced search functionality by providing users with suggestions based on their search history.

45. Updated `advert_screen.dart`:
    - Removed unnecessary imports and log statements.
    - Improved readability and maintainability of the code.

46. Updated `base_controller.dart`:
    - Added constants for page titles and methods to manage page navigation and search functionality.
    - Improved the controller's responsibility to manage state and UI updates more effectively.

47. Updated `base_screen.dart`:
    - Introduced a method for handling search dialog interactions.
    - Enhanced the app bar to dynamically display the search bar or title based on the current page.
    - Improved user experience by integrating a search functionality directly into the app bar.

48. Updated `home_screen.dart`:
    - Added segmented buttons for mechanics and filter selection.
    - Integrated new mechanics and filter selection features into the home screen.

49. Updated `mechanics_manager.dart`:
    - Added methods to retrieve mechanic names by their IDs.
    - Improved data handling for mechanics, making it easier to work with mechanic-related data.

50. Updated `state_manager.dart`:
    - Continued to refine state management by ensuring alignment with the new state model.

51. Updated `main.dart`:
    - Added initialization for the `SearchHistory` singleton.
    - Ensured all necessary initializations are done before the app runs.

52. Incremented `pubspec.yaml` version to 0.3.2+8:
    - Reflecting all the changes and additions made in this update cycle.

This commit encompasses multiple additions and refactorings across the project to enhance functionality, improve code clarity, and manage state more effectively. These changes improve the overall structure, enhance user experience with better search and filter functionalities, and maintain consistency across the application. These updates further improve the app's maintainability, performance, and user experience, ensuring that the app remains robust and user-friendly. The comprehensive updates aim to improve the app’s overall architecture, enhance user experience, and maintain a clean and maintainable codebase. The addition of new models, controllers, and screens reflects ongoing efforts to provide robust and user-friendly features. These updates continue to improve the app’s structure, usability, and developer experience by refining existing features, introducing new functionalities, and ensuring consistency across the codebase.


## 2024/07/18 - version: 0.3.1+7

feat: Refactor and enhance advertisement and mechanic modules

- **lib/common/models/category.dart** to **lib/common/models/mechanic.dart**
  - Renamed `CategoryModel` to `MechanicModel`.

- **lib/components/custon_field_controllers/currency_text_controller.dart**
  - Added `currencyValue` getter to parse the text into a double.

- **lib/features/advertisement/advert_controller.dart**
  - Replaced `CategoryModel` with `MechanicModel`.
  - Added `AdvertState` for state management.
  - Added methods to handle state changes and error handling.

- **lib/features/advertisement/advert_screen.dart**
  - Updated to reflect new state management.
  - Added navigation to `BaseScreen` upon successful ad creation.

- **lib/features/advertisement/advert_state.dart** (new)
  - Added state classes for advertisement management.

- **lib/features/advertisement/widgets/advert_form.dart**
  - Updated to use `selectedMechIds` for mechanics selection.

- **lib/features/base/base_screen.dart**
  - Updated navigation to `AdvertScreen` reflecting new changes.

- **lib/features/mecanics/mecanics_screen.dart**
  - Replaced `categories` with `mechanics`.
  - Updated route name and method names to reflect mechanics instead of categories.

- **lib/manager/mechanics_manager.dart**
  - Replaced `CategoryModel` with `MechanicModel`.

- **lib/repository/advert_repository.dart**
  - Renamed variables to reflect advertisement context.
  - Updated methods to handle the new advert model.

- **lib/repository/constants.dart**
  - Updated constants to reflect advertisement context.

- **lib/repository/mechanic_repository.dart**
  - Renamed methods to reflect mechanics context.

- **pubspec.yaml & pubspec.lock**
  - Updated dependencies versions.
  - Bumped project version to `0.3.1+7`.

- **lib/features/new_address/** (new)
  - **new_address_controller.dart**: Added new address management logic, including form validation and fetching address data from ViaCEP.
  - **new_address_screen.dart**: Created new screen for managing new addresses, including saving and validating address information.
  - **new_address_state.dart**: Added state classes for new address management.
  - **widgets/address_form.dart**: Added new address form for input fields related to address management.

- **lib/features/address/address_controller.dart**
  - Moved logic related to address state management to `AddressManager`.
  - Simplified the controller to delegate address operations to `AddressManager`.

- **lib/features/address/address_screen.dart**
  - Updated screen to utilize `AddressManager` for fetching and managing addresses.
  - Added buttons for adding and removing addresses.

- **lib/manager/address_manager.dart** (new)
  - Added a manager for handling address operations, including saving, deleting, and fetching addresses.
  - Included methods to check for duplicate address names and manage address lists.

These changes collectively refactor the existing advertisement and address modules, introduce better state management, improve the mechanics handling, and streamline address-related operations. Additionally, it includes new features and improvements for handling advertisements and mechanics.


## 2024/07/18 - version: 0.3.0+6

feat: Implement address management with AddressManager and new address screens

- **lib/common/singletons/current_user.dart**
  - Replaced `AddressRepository` with `AddressManager` for managing addresses.
  - Removed `_loadAddresses` method, added `addressByName` and `saveAddress` methods.

- **lib/features/address/address_controller.dart**
  - Simplified `AddressController` to delegate address management to `AddressManager`.
  - Removed form state and validation logic, focusing on address selection and removal.

- **lib/features/address/address_screen.dart**
  - Updated to use new `NewAddressScreen` for adding addresses.
  - Added floating action buttons for adding and removing addresses.

- **lib/features/advertisement/advert_controller.dart**
  - Updated to use `CurrentUser.addressByName` for selecting addresses.

- **lib/features/advertisement/widgets/advert_form.dart**
  - Updated address selection to use `CurrentUser.addressByName`.

- **lib/features/new_address/new_address_controller.dart** (new)
  - Added new controller for managing new address form state and validation.

- **lib/features/new_address/new_address_screen.dart** (new)
  - Added new screen for adding and editing addresses.
  - Integrated `NewAddressController` for form management and submission.

- **lib/features/address/address_state.dart** (renamed to `new_address_state.dart`)
  - Renamed and updated states to be used by `NewAddressController`.

- **lib/features/address/widgets/address_form.dart** (renamed to `new_address/widgets/address_form.dart`)
  - Updated to use `NewAddressController` for form state management.

- **lib/manager/address_manager.dart** (new)
  - Added new manager for handling address CRUD operations and caching.
  - Implemented methods for saving, deleting, and fetching addresses.

- **lib/my_material_app.dart**
  - Added route for `NewAddressScreen`.
  - Updated `onGenerateRoute` to handle new address route.

- **lib/repository/address_repository.dart**
  - Simplified `saveAddress` method.
  - Added `delete` method for removing addresses.
  - Updated error handling and logging.

- **lib/repository/constants.dart**
  - Updated `keyAddressTable` to `'Addresses'`.

This commit message provides a detailed breakdown of changes made to each file, highlighting the specific updates and improvements in the address management system.


## 2024/07/18 - version: 0.2.3+5

feat: Implement new features for address management and validation

- **lib/common/models/address.dart**
  - Added `operator ==` and `hashCode` methods to `AddressModel` for better address comparison and management.

- **lib/common/singletons/current_user.dart**
  - Updated to load addresses and provide access to address names.
  - Improved logic for address initialization and retrieval.

- **lib/common/validators/validators.dart**
  - Added `AddressValidator` for validating various address fields.
  - Enhanced `Validator.zipCode` to clean and validate the zip code correctly.

- **lib/components/form_fields/custom_form_field.dart**
  - Added `textCapitalization` property to `CustomFormField`.

- **lib/components/form_fields/dropdown_form_field.dart**
  - Added `textCapitalization` and `onSelected` properties to `DropdownFormField`.

- **lib/features/advertisement/widgets/advert_form.dart**
  - Added `textCapitalization` property to `AdvertForm`.

- **lib/features/address/address_controller.dart**
  - Enhanced `AddressController` to manage addresses more efficiently.
  - Added methods for validation and setting the form from addresses.
  - Included `zipFocus` to manage focus on the zip code field.

- **lib/features/address/address_screen.dart**
  - Updated `AddressScreen` to validate and save addresses upon leaving the screen.
  - Integrated `PopScope` to handle back navigation and save address changes.

- **lib/features/address/widgets/address_form.dart**
  - Updated `AddressForm` to use `AddressValidator`.
  - Added logic to initialize address types from `CurrentUser`.

- **lib/features/advertisement/advertisement_controller.dart**
  - Renamed `AdvertisementController` to `AdvertController`.
  - Updated methods for address handling and validation.

- **lib/features/advertisement/advertisement_screen.dart**
  - Renamed `AdvertisementScreen` to `AdvertScreen`.

- **lib/features/advertisement/widgets/advertisement_form.dart**
  - Renamed `AdvertisementForm` to `AdvertForm`.
  - Updated address selection logic.

- **lib/features/advertisement/widgets/image_list_view.dart**
  - Updated to use `AdvertController` instead of `AdvertisementController`.

- **lib/features/base/base_screen.dart**
  - Updated route for `AdvertScreen`.

- **lib/features/mecanics/mecanics_screen.dart**
  - Updated `MecanicsScreen` to handle null descriptions gracefully.

- **lib/my_material_app.dart**
  - Updated routes to use `AdvertScreen`.

- **lib/repository/ad_repository.dart**
  - Renamed `AdRepository` to `AdvertRepository`.

- **lib/repository/address_repository.dart**
  - Enhanced `saveAddress` method to handle address name uniqueness per user.
  - Added `_getAddressByName` to fetch addresses by name.
  - Improved error handling and logging.

- **lib/repository/constants.dart**
  - Updated `keyAddressTable` to `'Addresses'`.

This commit message provides a detailed breakdown of changes made to each file, highlighting the specific updates and improvements.


## 2024/07/17 - version: 0.2.2+4

feat: Implement new features for address management, category handling, and insert functionality

- **lib/common/models/address.dart**
  - Added `operator ==` and `hashCode` methods to `AddressModel` for better address management.

- **lib/common/singletons/current_user.dart**
  - Updated to load addresses and provide access to address names.

- **lib/common/validators/validators.dart**
  - Added `AddressValidator` for validating various address fields.
  - Improved `Validator.zipCode` to clean and validate the zip code correctly.

- **lib/components/form_fields/custom_form_field.dart**
  - Added `textCapitalization` property to `CustomFormField`.

- **lib/components/form_fields/dropdown_form_field.dart**
  - Added `textCapitalization` and `onSelected` properties to `DropdownFormField`.

- **lib/features/address/address_controller.dart**
  - Enhanced `AddressController` to manage addresses more efficiently.
  - Added methods for validation and setting the form from addresses.
  - Added `zipFocus` to manage focus on the zip code field.

- **lib/features/address/address_screen.dart**
  - Updated `AddressScreen` to validate and save addresses upon leaving the screen.
  - Included `PopScope` to handle back navigation.

- **lib/features/address/widgets/address_form.dart**
  - Updated `AddressForm` to use `AddressValidator`.
  - Added logic to initialize address types from `CurrentUser`.

- **lib/features/advertisement/advertisement_controller.dart**
  - Renamed `AdvertisementController` to `AdvertController`.
  - Updated methods for address handling and validation.

- **lib/features/advertisement/advertisement_screen.dart**
  - Renamed `AdvertisementScreen` to `AdvertScreen`.

- **lib/features/advertisement/widgets/advertisement_form.dart**
  - Renamed `AdvertisementForm` to `AdvertForm`.
  - Updated address selection logic.

- **lib/features/advertisement/widgets/image_list_view.dart**
  - Updated to use `AdvertController` instead of `AdvertisementController`.

- **lib/features/base/base_screen.dart**
  - Updated route for `AdvertScreen`.

- **lib/features/mecanics/mecanics_screen.dart**
  - Updated `MecanicsScreen` to handle null descriptions gracefully.

- **lib/my_material_app.dart**
  - Updated routes to use `AdvertScreen`.

- **lib/repository/ad_repository.dart**
  - Renamed `AdRepository` to `AdvertRepository`.

- **lib/repository/address_repository.dart**
  - Enhanced `saveAddress` method to handle address name uniqueness per user.
  - Added `_getAddressByName` to fetch addresses by name.
  - Improved error handling and logging.

- **lib/repository/constants.dart**
  - Updated `keyAddressTable` to `'Addresses'`.

This commit message provides a detailed breakdown of changes made to each file, highlighting the specific updates and improvements.


## 2024/07/17 - version: 0.2.1+3:

feat: Address management updates and enhancements

This commit introduces several new features and updates to address management within the application. Key changes include:

- Added unique name verification for addresses per user.
- Implemented logic to handle address creation and updates.
- Enhanced error handling and response validation.
- Included additional model fields for address details.

Detailed Changes:
- lib/common/models/address.dart: Added new model for addresses.
- lib/common/models/category.dart: Renamed CategoryModel to MechanicModel.
- lib/common/models/city.dart: Added new model for city information.
- lib/common/models/uf.dart: Added new model for state information.
- lib/common/models/user.dart: Updated user model with address-related fields.
- lib/common/models/viacep_address.dart: Added model for ViaCEP address information.
- lib/common/singletons/app_settings.dart: Adjusted settings for address handling.
- lib/common/singletons/current_user.dart: Added singleton for current user with address information.
- lib/common/validators/validators.dart: Added validation rules for address fields.
- lib/components/buttons/big_button.dart: Added focus node for address input.
- lib/components/custom_drawer/custom_drawer.dart: Integrated current user for address display.
- lib/components/custom_drawer/widgets/custom_drawer_header.dart: Updated drawer header with address info.
- lib/components/form_fields/custom_form_field.dart: Added new fields for address input.
- lib/components/others_widgets/custom_input_formatter.dart: Added custom input formatter for address fields.
- lib/features/address/address_controller.dart: Added controller for address management.
- lib/features/address/address_screen.dart: Added screen for address input and display.
- lib/features/address/address_state.dart: Added state management for address operations.
- lib/features/insert/insert_controller.dart: Enhanced insert functionality with address handling.
- lib/features/insert/insert_screen.dart: Updated insert screen with address fields.
- lib/features/insert/widgets/image_gallery.dart: Renamed to horizontal_image_gallery.dart.
- lib/features/insert/widgets/insert_form.dart: Integrated address fields into insert form.
- lib/features/login/login_controller.dart: Integrated address handling in login process.
- lib/features/mecanics/mecanics_screen.dart: Added screen for mechanics selection.
- lib/main.dart: Integrated address management on app startup.
- lib/manager/mechanics_manager.dart: Added manager for mechanics data.
- lib/manager/uf_manager.dart: Added manager for state data.
- lib/my_material_app.dart: Updated material app with new routes and address handling.
- lib/repository/address_repository.dart: Added repository for address data handling.
- lib/repository/constants.dart: Updated constants for address fields.
- lib/repository/ibge_repository.dart: Added repository for state and city data.
- lib/repository/mechanic_repository.dart: Renamed from category_repository and updated for mechanics data.
- lib/repository/user_repository.dart: Updated user repository with address handling.
- lib/repository/viacep_repository.dart: Added repository for ViaCEP data.
- pubspec.yaml: Added dependencies for address management.
- test/repository/ibge_repository_test.dart: Added tests for IBGE repository.

This commit significantly enhances the application's ability to manage user addresses, providing a robust framework for address-related data and operations.



## 2024/07/12 - version: 0.2.0+2:

feat: Implemented new features for address management, category handling, and insert functionality

This commit introduces several new features and updates, including address management, category handling, and enhancements to the insert functionality. It also includes modifications to existing models and components to support the new functionality.


Detailed Changes:

- lib/common/models/address.dart:
  - Created a new `AddressModel` to handle address-related data.
  - Implemented methods for serialization and deserialization (`toMap`, `fromMap`, `toJson`, `fromJson`).
  - Added a `toString` method for debugging and logging purposes.

- lib/common/models/category.dart:
  - Renamed `CategoryModel` to `MechanicModel`.
  - Updated class references to reflect the new name.

- lib/common/models/city.dart:
  - Created a new `CityModel` to represent city data.
  - Included methods for serialization and deserialization (`toMap`, `fromMap`, `toJson`, `fromJson`).
  - Added a `toString` method for debugging and logging purposes.

- lib/common/models/uf.dart:
  - Created `RegionModel` and `UFModel` to represent region and state data.
  - Included methods for serialization and deserialization (`toMap`, `fromMap`, `toJson`, `fromJson`).
  - Added `toString` methods for debugging and logging purposes.

- lib/common/models/user.dart:
  - Added serialization and deserialization methods (`toMap`, `fromMap`, `toJson`, `fromJson`).
  - Implemented a `copyFromUserModel` method for cloning user instances.

- lib/common/models/viacep_address.dart:
  - Created a new `ViaCEPAddressModel` to handle address data from the ViaCEP API.
  - Included methods for serialization and deserialization (`toMap`, `fromMap`, `toJson`, `fromJson`).
  - Added a `toString` method for debugging and logging purposes.

- lib/common/singletons/app_settings.dart:
  - Removed user-related properties and methods to simplify the singleton class.

- lib/common/singletons/current_user.dart:
  - Created a new `CurrentUser` singleton to manage the current user and their address.
  - Included methods for initializing and loading user and address data (`init`, `_loadUserAndAddress`).

- lib/common/validators/validators.dart:
  - Added new validators for form fields (`title`, `description`, `mechanics`, `address`, `zipCode`, `cust`).

- lib/components/buttons/big_button.dart:
  - Added `focusNode` property to manage focus state for the button.

- lib/components/custom_drawer/custom_drawer.dart:
  - Updated to use `CurrentUser` for login status checks.

- lib/components/custom_drawer/widgets/custom_drawer_header.dart:
  - Updated to use `CurrentUser` for displaying user information.

- lib/components/form_fields/custom_form_field.dart:
  - Added `readOnly`, `suffixIcon`, and `errorText` properties to enhance form field functionality.

- lib/components/others_widgets/custom_input_formatter.dart:
  - Created a new `CustomInputFormatter` to format text input based on a provided mask.

- lib/features/address/address_controller.dart:
  - Created a new `AddressController` to manage address-related state and logic.
  - Implemented methods for handling address retrieval and saving (`getAddress`, `saveAddressFrom`, `_checkZipCodeReady`).

- lib/features/address/address_screen.dart:
  - Created a new `AddressScreen` to provide a UI for managing user addresses.
  - Integrated with `AddressController` to handle form submission and state changes.

- lib/features/address/address_state.dart:
  - Defined different states for address-related operations (`AddressStateInitial`, `AddressStateLoading`, `AddressStateSuccess`, `AddressStateError`).

- lib/common/models/address.dart:
  - Created `AddressModel` to manage address-related data.
  - Implemented methods for serialization and deserialization (`toMap`, `fromMap`, `toJson`, `fromJson`).

- lib/common/models/category.dart:
  - Renamed `CategoryModel` to `MechanicModel`.
  - Updated class references to reflect the new name.

- lib/common/models/city.dart:
  - Created `CityModel` to represent city data.
  - Included methods for serialization and deserialization (`toMap`, `fromMap`, `toJson`, `fromJson`).

- lib/common/models/uf.dart:
  - Created `RegionModel` and `UFModel` to represent region and state data.
  - Included methods for serialization and deserialization (`toMap`, `fromMap`, `toJson`, `fromJson`).

- lib/common/models/user.dart:
  - Added serialization and deserialization methods (`toMap`, `fromMap`, `toJson`, `fromJson`).
  - Implemented a `copyFromUserModel` method for cloning user instances.

- lib/common/models/viacep_address.dart:
  - Created `ViaCEPAddressModel` to handle address data from the ViaCEP API.
  - Included methods for serialization and deserialization (`toMap`, `fromMap`, `toJson`, `fromJson`).

- lib/common/singletons/app_settings.dart:
  - Removed user-related properties and methods to simplify the singleton class.

- lib/common/singletons/current_user.dart:
  - Created a new `CurrentUser` singleton to manage the current user and their address.
  - Included methods for initializing and loading user and address data (`init`, `_loadUserAndAddress`).

- lib/common/validators/validators.dart:
  - Added new validators for form fields (`title`, `description`, `mechanics`, `address`, `zipCode`, `cust`).

- lib/components/buttons/big_button.dart:
  - Added `focusNode` property to manage focus state for the button.

- lib/components/custom_drawer/custom_drawer.dart:
  - Updated to use `CurrentUser` for login status checks.

- lib/components/custom_drawer/widgets/custom_drawer_header.dart:
  - Updated to use `CurrentUser` for displaying user information.

- lib/components/form_fields/custom_form_field.dart:
  - Added `readOnly`, `suffixIcon`, and `errorText` properties to enhance form field functionality.

- lib/components/others_widgets/custom_input_formatter.dart:
  - Created a new `CustomInputFormatter` to format text input based on a provided mask.

- lib/features/address/address_controller.dart:
  - Created a new `AddressController` to manage address-related state and logic.
  - Implemented methods for handling address retrieval and saving (`getAddress`, `saveAddressFrom`, `_checkZipCodeReady`).

- lib/features/address/address_screen.dart:
  - Created a new `AddressScreen` to provide a UI for managing user addresses.
  - Integrated with `AddressController` to handle form submission and state changes.

- lib/features/address/address_state.dart:
  - Defined different states for address-related operations (`AddressStateInitial`, `AddressStateLoading`, `AddressStateSuccess`, `AddressStateError`).

- lib/features/insert/insert_controller.dart:
  - Enhanced `InsertController` with new methods and properties for managing categories and images.
  - Added methods for form validation (`formValidate`) and managing selected categories (`getCategoriesIds`).

- lib/features/insert/insert_screen.dart:
  - Updated to initialize address data from `CurrentUser`.
  - Added logic for handling form submission (`_createAnnounce`).

- lib/features/insert/widgets/horizontal_image_gallery.dart:
  - Renamed from `image_gallery.dart`.
  - Updated widget structure to handle horizontal image gallery.

- lib/features/insert/widgets/insert_form.dart:
  - Enhanced to include additional fields and validation logic.
  - Integrated navigation for adding mechanics and addresses.

- lib/features/login/login_controller.dart:
  - Updated to use `CurrentUser` for managing login state.

- lib/features/mecanics/mecanics_screen.dart:
  - Created a new `MecanicsScreen` to handle mechanic selection.

- lib/main.dart:
  - Updated main entry point to initialize `CurrentUser` and other managers.
  - Added new routes for address and mechanic screens.

- lib/manager/mechanics_manager.dart:
  - Created `MechanicsManager` to manage mechanic data.
  - Implemented methods for initialization and data retrieval.

- lib/manager/uf_manager.dart:
  - Created `UFManager` to manage state (UF) data.
  - Implemented methods for initialization and data retrieval.

- lib/my_material_app.dart:
  - Added new routes for address and mechanic screens.
  - Updated to support dynamic route generation for mechanic screen.

- lib/repository/address_repository.dart:
  - Created `AddressRepository` to manage address-related data operations.
  - Implemented methods for saving and retrieving address data from both local storage and the server.

- lib/repository/constants.dart:
  - Updated constants to support new address and mechanic data models.

- lib/repository/ibge_repository.dart:
  - Created `IbgeRepository` to manage data retrieval from the IBGE API.
  - Implemented methods for retrieving state and city data.

- lib/repository/mechanic_repository.dart:
  - Renamed from `category_repositories.dart`.
  - Updated to support new mechanic data model.


- lib/common/models/address.dart:
  - Created `AddressModel` to manage address-related data.
  - Implemented methods for serialization and deserialization (`toMap`, `fromMap`, `toJson`, `fromJson`).

- lib/common/models/category.dart:
  - Renamed `CategoryModel` to `MechanicModel`.
  - Updated class references to reflect the new name.

- lib/common/models/city.dart:
  - Created `CityModel` to represent city data.
  - Included methods for serialization and deserialization (`toMap`, `fromMap`, `toJson`, `fromJson`).

- lib/common/models/uf.dart:
  - Created `RegionModel` and `UFModel` to represent region and state data.
  - Included methods for serialization and deserialization (`toMap`, `fromMap`, `toJson`, `fromJson`).

- lib/common/models/user.dart:
  - Added serialization and deserialization methods (`toMap`, `fromMap`, `toJson`, `fromJson`).
  - Implemented a `copyFromUserModel` method for cloning user instances.

- lib/common/models/viacep_address.dart:
  - Created `ViaCEPAddressModel` to handle address data from the ViaCEP API.
  - Included methods for serialization and deserialization (`toMap`, `fromMap`, `toJson`, `fromJson`).

- lib/common/singletons/app_settings.dart:
  - Removed user-related properties and methods to simplify the singleton class.

- lib/common/singletons/current_user.dart:
  - Created a new `CurrentUser` singleton to manage the current user and their address.
  - Included methods for initializing and loading user and address data (`init`, `_loadUserAndAddress`).

- lib/common/validators/validators.dart:
  - Added new validators for form fields (`title`, `description`, `mechanics`, `address`, `zipCode`, `cust`).

- lib/components/buttons/big_button.dart:
  - Added `focusNode` property to manage focus state for the button.

- lib/components/custom_drawer/custom_drawer.dart:
  - Updated to use `CurrentUser` for login status checks.

- lib/components/custom_drawer/widgets/custom_drawer_header.dart:
  - Updated to use `CurrentUser` for displaying user information.

- lib/components/form_fields/custom_form_field.dart:
  - Added `readOnly`, `suffixIcon`, and `errorText` properties to enhance form field functionality.

- lib/components/others_widgets/custom_input_formatter.dart:
  - Created a new `CustomInputFormatter` to format text input based on a provided mask.

- lib/features/address/address_controller.dart:
  - Created a new `AddressController` to manage address-related state and logic.
  - Implemented methods for handling address retrieval and saving (`getAddress`, `saveAddressFrom`, `_checkZipCodeReady`).

- lib/features/address/address_screen.dart:
  - Created a new `AddressScreen` to provide a UI for managing user addresses.
  - Integrated with `AddressController` to handle form submission and state changes.

- lib/features/address/address_state.dart:
  - Defined different states for address-related operations (`AddressStateInitial`, `AddressStateLoading`, `AddressStateSuccess`, `AddressStateError`).

- lib/features/insert/insert_controller.dart:
  - Enhanced `InsertController` with new methods and properties for managing categories and images.
  - Added methods for form validation (`formValidate`) and managing selected categories (`getCategoriesIds`).

- lib/features/insert/insert_screen.dart:
  - Updated to initialize address data from `CurrentUser`.
  - Added logic for handling form submission (`_createAnnounce`).

- lib/features/insert/widgets/horizontal_image_gallery.dart:
  - Renamed from `image_gallery.dart`.
  - Updated widget structure to handle horizontal image gallery.

- lib/features/insert/widgets/insert_form.dart:
  - Enhanced to include additional fields and validation logic.
  - Integrated navigation for adding mechanics and addresses.

- lib/features/login/login_controller.dart:
  - Updated to use `CurrentUser` for managing login state.

- lib/features/mecanics/mecanics_screen.dart:
  - Created a new `MecanicsScreen` to handle mechanic selection.

- lib/main.dart:
  - Updated main entry point to initialize `CurrentUser` and other managers.
  - Added new routes for address and mechanic screens.

- lib/manager/mechanics_manager.dart:
  - Created `MechanicsManager` to manage mechanic data.
  - Implemented methods for initialization and data retrieval.

- lib/manager/uf_manager.dart:
  - Created `UFManager` to manage state (UF) data.
  - Implemented methods for initialization and data retrieval.

- lib/my_material_app.dart:
  - Added new routes for address and mechanic screens.
  - Updated to support dynamic route generation for mechanic screen.

- lib/repository/address_repository.dart:
  - Created `AddressRepository` to manage address-related data operations.
  - Implemented methods for saving and retrieving address data from both local storage and the server.

- lib/repository/constants.dart:
  - Updated constants to support new address and mechanic data models.

- lib/repository/ibge_repository.dart:
  - Created `IbgeRepository` to manage data retrieval from the IBGE API.
  - Implemented methods for retrieving state and city data.

- lib/repository/mechanic_repository.dart:
  - Renamed from `category_repositories.dart`.
  - Updated to support new mechanic data model.

- lib/repository/user_repository.dart:
  - Updated to use correct generic types for getting user attributes.

- lib/repository/viacep_repository.dart:
  - Created `ViacepRepository` to handle address data retrieval from ViaCEP API.
  - Implemented methods for fetching address data based on CEP (postal code).

- pubspec.yaml:
  - Added new dependencies for `http` and `shared_preferences` to support address and data handling.

- test/repository/ibge_repository_test.dart:
  - Added tests for `IbgeRepository` to ensure correct data retrieval from IBGE API.

This commit significantly enhances the application's ability to manage user addresses, categories, and insert functionalities, providing a robust framework for address-related data and operations.


## 2024/07/12 - version: 0.1.0+1:

Implemented InsertForm widget, updated dependencies, and made platform-specific changes

This commit introduces a new InsertForm widget, updates various project dependencies, and includes necessary platform-specific changes to ensure compatibility and functionality.

Detailed Changes:

- lib/ui/form/insert_form.dart:
  - Created a new stateful widget `InsertForm` to handle user inputs.
  - Added `InsertController` as a required parameter for managing form data.
  - Implemented `CustomFormField` components for title and description inputs with `labelText`, `fullBorder`, and `floatingLabelBehavior` properties.
  - Added a `DropdownButtonFormField` for category selection with predefined items.
  - Included a `ValueNotifier<bool>` named `hidePhone` to manage the visibility of the phone number input.
  - Overridden the `dispose` method to properly dispose of the `ValueNotifier`.

- pubspec.yaml:
  - Added `intl: ^0.19.0` for internationalization support.
  - Added `image_picker: ^1.1.2` to enable image selection from the device.
  - Added `image_cropper: ^4.0.1` for cropping images.

- lib/common/models/category.dart:
  - Defined a Category model to encapsulate the data structure and provide methods for handling category-related data.

- lib/components/custom_drawer/custom_drawer.dart:
  - Developed a CustomDrawer widget to standardize the navigation drawer across the application.
  - Included links to major sections such as Home, Insert, and Settings.

- lib/components/form_fields/custom_form_field.dart:
  - Created a reusable CustomFormField widget to ensure consistent styling and functionality across all form fields.

- lib/controllers/insert_controller.dart:
  - Implemented the InsertController class to manage form state and business logic, ensuring separation of concerns and easier testing.

- lib/main.dart:
  - Main entry point updated to include routing and integration for the new InsertForm functionality.

- lib/screens/home_screen.dart:
  - Added navigation logic to transition from the HomeScreen to the new InsertScreen.

- lib/screens/insert_screen.dart:
  - Created InsertScreen to host the InsertForm widget, integrating it into the application's navigation flow.

- lib/services/file_service.dart:
  - Implemented FileService to abstract file operations such as picking and cropping images, leveraging image_picker and image_cropper plugins.

- lib/utilities/constants.dart:
  - Updated constants to support new form and file handling features, ensuring consistent usage across the application.

- windows/flutter/generated_plugin_registrant.cc:
  - Registered `FileSelectorWindows` plugin to handle file selection on Windows.

This commit enhances the form handling capabilities of the application by introducing a new, robust InsertForm widget. It also extends the app's functionality by adding new dependencies for internationalization and image handling. The platform-specific changes ensure that these features are fully supported on Windows, providing a consistent and seamless user experience across different environments.
