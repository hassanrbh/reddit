# README
## This is complete version of reddit, Build with ruby on rails and esbuild and turbo streams in the backend and html and tailwind and javascript in the front end and postgresql in the database and also redis for cashing and storing ( exm: latest searches of the user , etc...) ..

* Ruby version
  > 3.0.2p107 
  
* Configuration
  > bundle install ( intstall all the dependicies) 
  
  > bundle exec rails db:migrate ( migrating all the tables in the database ) or just bundle exec rails db:setup ( setuping all the database creating migrating )
  
  > rails s ( shortcut for server ) ( running the web server in port 3000 )
  
    ### enjoy if you want to make some changes just contribute and I will take a look at it :)

* Database creation
  > bundle exec rails db:create
  
* Database initialization
  #### the main database is postgresql 
  
  #### the cashing in-memory databse is redis , it needs some setup before starting with it 
  
    > install redis in your system
    
      > mac ( brew install redis )
      
      > windows ( go to your bundler in redis.com and install it )
      
      > linux ( sudo apt install redis )
      
   
    > for installing redis in your gem files
    
      > gem install redis
      
    > if you want to play with it and to learn more just go to your irb , and require redis and start by typing 
    
      > require 'redis'
      > redis = Redis.new(host: localhost)
      > redis.set("your","mome") # this is for storing variables, take 2 parameters key, and value
      > redis.get("your") # this is for getting the storing variable, take just the key that you want to get his value

    > This is good documentation for working with redis in railx :> https://www.rubyguides.com/2019/04/ruby-redis/
    
* How to run the test suite
  > I think I do the right thing without testing like all programmers :)
  
 Website Url => https://redd-it.herokuapp.com/users/sign_in
