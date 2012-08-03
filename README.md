# Kindable
Repo for Kindable gem: Manage 'kind columns' for ActiveRecord Models easily
## Installation
### Rails 3
In your Gemfile
```ruby
gem "kindable"
```
Then run bundle:install
## Usage
First add the column with a migration, it must be integer type
```ruby
    add_column :table_name, :column_name, :integer
``` 
Then declare kind column and kinds in your model
```ruby
class ModelName < ActiveRecord::Base
    kindable :column_name, {:key1 => value1, :key2 => value2...}
end     
```
Thats all! 
## Example
Use it to manage kinds on models
```ruby
class User < ActiveRecord::Base
  attr_accessible :name, :role
  kindable :role, {:admin => 1, :guest => 0, :publisher => 2}
end
``` 
That code generates following constants:
```ruby
User::ROLE_ADMIN #=> 1
User::ROLE_GUEST #=> 0
User::ROLE_PUBLISHER #=> 2
User::ROLES #=> {1 => :admin, 0 => :guest, 2 => :publisher}
```
And this methods:
```ruby
User.roles_for_select # Array with I18n tag and value for each role to use it on select_tag or similar
User.roles_for_select(:include_blank => true) # Same but with blank option
user = User.new
user.admin? # true if user.role == ROLE_ADMIN
user.guest? # true if user.role == ROLE_GUEST
user.publisher? # true if.. Ok, you get it no?
```    
## I18n
By default it needs the tag kindable.select to use it on the blank case of xxxxx_for_select
Also needs a translation for each declarated kind, following the example it needs:
* users.roles.admin
* users.roles.guest
* users.roles.publisher