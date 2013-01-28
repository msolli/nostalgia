class FlickrSearch
  attr_accessor :flickr

  def initialize(flickr)
    self.flickr = flickr
  end

  def random_from_date(date)
    dates = []
    (1..20).to_a.reverse.each do |i|
      dates << (date - i.years).strftime
      dates << (date + 1.day - i.years).strftime
    end
    counts = flickr.photos.getCounts(taken_dates: dates.join(","))

    counts = counts.to_a.select do |c|
      fromdate = Date.parse c["fromdate"]
      todate = Date.parse c["todate"]
      todate - fromdate == 1 && c["count"].to_i > 0
    end
    return nil if counts.empty?

    weighted_array = []
    counts.each_with_index do |count, i|
      count["count"].to_i.times { weighted_array << i }
    end
    random_count = counts[weighted_array.sample]

    search_options = {
      user_id: "me",
      min_taken_date: random_count["fromdate"],
      max_taken_date: random_count["todate"],
      media: "photos",
      per_page: 500,
      extras: "description"
    }
    photo = flickr.photos.search(search_options).to_a.sample

    flickr.photos.getInfo(photo_id: photo.id)
  end

  class << self
    def from_user(user)
      flickr = FlickRaw::Flickr.new
      flickr.access_token = user.access_token
      flickr.access_secret = user.access_secret
      new(flickr)
    end
  end
end
