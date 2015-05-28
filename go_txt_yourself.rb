require 'sinatra'
require 'twilio-ruby' 
require 'slim'
 
get '/' do
  slim :index
end

post '/' do 

#  numberb = numbera.to_i
  number = params[:number]
  message = params[:message]

# put your own credentials here 
account_sid = 'ACb38058910fdf6faf11e08613474f0c88' 
auth_token = '38dcddaf25f3967de339651a14e39399' 

# set up a client to talk to the Twilio REST API 
@client = Twilio::REST::Client.new account_sid, auth_token 
 
@client.account.messages.create({
  :from => '+16178700148', 
  :to => "#{number}", 
  :body => "#{message}",  
})

end

get ("/") do
  slim = :exit
  "Hello #{number}, your text is on it's way!"
end


__END__
 
@@layout
doctype html 
html
  head 
    meta charset="utf-8"
    title Text Form
    link rel="stylesheet" media="screen, projection" href="/styles.css"
    /[if lt IE 9] 
      script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"
  body 
    h1 Reach Out and Text Yourself 
    == yield
 
@@index
ul.tasks

<div id='contact-box' class="group">
  <div class="span6 clear">
    <form action="/" method="post" class="well">
      <label for="number">Your Phone Number:</label><br>
      <input type="text" name="number" class="span4" placeholder="___-___-____"><br><br>
      <label for="message">Your Text Message:</label><br>
      <textarea name="message" cols='30' rows="10"></textarea><br>
      <button type="submit" class="btn" action="/exit" value="Send">Submit</button>
    </form>
  </div>
</div>


@@exit
ul.tasks

<div id='contact-box' class="group">
  <div class="span6 clear">
    <form action="/" method="post" class="well">
      <label for="number">Your Phone Number:</label><br>
      <input type="text" name="number" class="span4" placeholder="+1 ___-___-____"><br><br>
      <label for="message">Your Text Message:</label><br>
      <textarea name="message" cols='30' rows="10"></textarea><br>
      <button type="submit" class="btn" value="Send">Submit</button>
    </form>
  </div>
</div>
