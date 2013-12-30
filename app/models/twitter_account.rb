class TwitterAccount < ActiveRecord::Base
  belongs_to :user
  has_many :keywords
  has_many :favorited_tweets

  def favorite_tweets!(amount=5)
    return if search_terms.empty?

    client.search(search_terms).first(amount).each do |tweet|
      begin
        client.favorite tweet.id
        favorited_tweets.create(
          status_id: tweet.id,
          name:      tweet.user.name,
          username:  tweet.user.username,
          image_url: tweet.user.profile_image_url_https.to_s,
          text:      tweet.text,
          posted_at: tweet.created_at
        )
      rescue
      end
    end
  end

  def search_terms
    @search_terms ||= keywords.map(&:text).join(" OR ")
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = token
      config.access_token_secret = secret
    end
  end
end
