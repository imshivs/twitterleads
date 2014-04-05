require 'rubygems'
require 'twitter'
require 'pry'

@client = Twitter::REST::Client.new do |config|
  config.consumer_key = "zRfXfnnc5cP3IepEcv5dGg"
  config.consumer_secret = "eQGa8KCp3mRQmeZGQZdj2Y5SyjQPs4lQ1Y0UBNcxMU"
  config.access_token = "2157169344-co7p06J4yx8rUCGyRKXvkuUq8Fxwt2qs2XqP36L"
  config.access_token_secret = "QceXpjKfW05Cgv4MPgAXpL2Wa1Gs0NUSRs6puEHODe4Uk"
end

def twitter_scrape(query)
  counter = 0
  profile_list = []
  followers = []
  following = []
  @client.search(query, :count => 50, :lang => "en").map do |status|
    #binding.pry
    profile_list  << @client.user(status.user)
    followers << profile_list[counter].followers_count
    following << profile_list[counter].friends_count
    #puts "#{status.from_user}: #{status.text}"
    puts profile_list.length
    [profile_list.last].each do |x|
      puts x.description
      puts x.class
      id = x.screen_name
      puts id
      if ((followers.last != 0) && ((following.last / followers.last) > 0.9))
        @client.follow(id)
      end
      puts "------"
    end
    counter += 1
    sleep(62)
  end

  followers_avg = followers.inject{ |sum, el| sum + el }.to_f / followers.size
  following_avg = following.inject{ |sum, el| sum + el }.to_f / following.size
  puts followers_avg
  puts following_avg

end

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

# Twitter.configure do |config| # Spidey
#   config.consumer_key = "R2AedhZ54XDviyT41WPJeA"
#   config.consumer_secret = "dGJBtBZQ1oyGi5AZM6jKTk0InKZj7lP0rWCvWqdZp5I"
#   config.oauth_token = "594697447-6gs63Epggs7Waxp5IR1HeoIaDjV4kKRKSxN2JE0l"
#   config.oauth_token_secret = "DaqlU2JWA8eOG97gASFAa3C3zmOTuGPCLfDTBzcJJ0"
# end

# Twitter.configure do |config| # Shivs
#   config.consumer_key = "XGbM3NlvHesHKaxs9UKA"
#   config.consumer_secret = "zZRRDQwW2g38L5LxXfUmNXFzCj1OWZ1Jx3XSleY1dM"
#   config.oauth_token = "1924347606-T35jx6TscfS6dS9NEguPldzDpAZBVyMz8wVCd1O"
#   config.oauth_token_secret = "6YhNHygeizxkDO0q77hnYZTq0snC3dklvlx8f0rGmo"
# 


x = twitter_scrape("georgiatech")






