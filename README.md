= Kindable
Repo for Kindable gem: Manage 'kind columns' for ActiveRecord Models easily
== Example
Use it to manage kinds on models
 class User
   attr_accessible :name, :role
   kindable :role, {:admin => 1, :guest => 0, :publisher => 2}
 end
 
That code generates following constants:
    User::ROLE_ADMIN #=> 1
    User::ROLE_GUEST #=> 0
    User::ROLE_PUBLISHER #=> 2
    User::ROLES #=> {1 => :admin, 0 => :guest, 2 => :publisher}

And this methods:
    User.roles_for_select # Array with I18n tag and value for each role to use it on select_tag or similar
    User.roles_for_select(:include_blank => true) # Same but with blank option
    user = User.new
    user.admin? # true if user.role == ROLE_ADMIN
    user.guest? # true if user.role == ROLE_GUEST
    user.publisher? # true if.. Ok, you get it no?
    
== I18n
By default it needs the tag kindable.select to use it on the blank case of xxxxx_for_select
Also needs a translation for each declarated kind, following the example it needs:
*users.roles.admin
*users.roles.guest
*users.roles.publisher