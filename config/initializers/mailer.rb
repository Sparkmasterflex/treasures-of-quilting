#ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'toq.ifkeithraymond.com',
  :authentication => :plain,
  :user_name => 'raymondke99@gmail.com',
  :password => 'Mate255Coffee'
}