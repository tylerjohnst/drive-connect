# Drive Connect Ruby Gem

This gem contains all of the shared business logic between the web and the mobile applications.

#### Caveats of sharing with RubyMotion and MRI

The only Ruby features that do not work with RubyMotion are string `eval`'s and `require`. Things like class_eval and instance_eval all work. The RubyMotion projects use motion-require which allows the use of `require_relative`. All specific fixes for this exist in `lib/drive_connect.rb`


#### Running Specs

`bundle exec rspec`


#### Structure

`connectors/` - Code for handling the process of connecting directly to the devices.

`deserializers/` - Code responsible for taking data returned from the embedded devices.

`helpers/` - Generic and unclassified helper logic for random things. *These need to be moved to more specific functionality at some point!*

`locales/` - Shared translation data with I18n.

`models/` - This a light ActiveRecord like implementation. Handles data types and data interactions on the mobile devices.

`modules/` - Shared module logic across multiple classes.

`presenters/` - Any presentation and view related logic for the model classes.

`serializers/` - Logic for converting the model objects in to JSON which the embedded devices can consume.

`store/` - The logic for the persistance layer of the mobile devices. Handles SQL building and storing.
