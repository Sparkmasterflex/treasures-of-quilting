# initial Admin user
puts "Creating User: keith"
puts "-------------------"
if User.find_by_login("keith").blank?
  user = User.create(
    :first_name            => "Keith",
    :last_name             => "Raymond",
    :email                 => "raymondke99@gmail.com",
    :login                 => "keith",
    :password              => "Sp@@d455",
    :password_confirmation => "Sp@@d455")
  puts "- User created. username: keith, password: Sp@@d455\n"
else
  puts "- User already exists.\n\n"
end

puts "Creating User: ellen"
puts "-------------------"
if User.find_by_login("ellen").blank?
  user = User.create(
    :first_name            => "Ellen",
    :last_name             => "Raymond",
    :email                 => "treasuresofquilting@yahoo.com",
    :login                 => "ellen",
    :password              => "password",
    :password_confirmation => "password")
  puts "- User created. username: ellen, password: password\n"
else
  puts "- User already exists.\n\n"
end

# default homepage text
puts "Creating Homepage Text"
puts "----------------------"
if Webpage.find_by_template(AppSystem::Templates::HOME).blank?
  homepage = Webpage.create(
    :page_alias           => "treasures",
    :template             => AppSystem::Templates::HOME,
    :page_title           => "Treasures of Quilting",
    :preview_text         => "Welcome to Treasures of Quilting. I chose the name so I could have different options to use my long arm along with finishing quilt tops, but also create Quilted items and other crafts and use my imagination.",
    :text                 => "I hope you enjoy browsing Our website.\r\n\r\nMy Mother and two Aunts have helped to contribute to making and designing different parts of the Quilts.\r\n\r\nSo let us know if there is something we can do for you, or if you have any questions, you can contact me.",
    :updated_by           => 1,
    :is_root              => true
  )
  puts " - Homepage has been created!\n\n"
else
  puts " - Homepage already exists.\n\n"
end