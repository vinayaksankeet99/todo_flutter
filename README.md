# todo_app

A Todo application with basic functionalities

## ARCHITECTURE

> This project follows the bloc architecture
> Find out more here: https://github.com/felangel/bloc/blob/master/packages/bloc
> This design pattern helps to separate presentation from business logic. 

Following the BLoC pattern facilitates testability and reusability.  It helps make the code easy to test and reusable by separating presentation from business logic. When it comes to state management, flutter_bloc is the fastest and safest path

## Folder Structure
> Project is divided into 3 layers - data, presentation, bloc

lib/bloc -- will contain all bloc files that connects the business logic to UI
lib/presentation - will contain all UI screens
lib/data -- contains models & repositories

## Plugins used
> flutter_bloc - for bloc architecture
> google_fonts - for theming purposes
> dio - for making API requests. Dio is more advanced than http in terms of features and performance
> integration_test - for running integration tests 

## Testing

Widget testing - basic taps and touches are tested test/widget_test.dart
to run --> flutter test test/widget_test.dart

Integration testing - a series of automated tests are arranged for fetching tasks, adding multiple tasks, editing and deleting them

to run --> flutter test integration_test

## Future scope

Local cache - We can create CRUD operations and save them locally using shared_preferences and perform API requests lazily. 