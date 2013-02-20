class FlickrSearch
  include ActiveSupport::Benchmarkable
  include Retriable
  attr_accessor :flickr

  def initialize(flickr)
    self.flickr = flickr
  end

  def random_from_date(date)
    counts = get_flickr_counts(date)

    benchmark("  Checking for photos in result") do
      counts = counts.to_a.select do |c|
        fromdate = Date.parse c["fromdate"]
        todate = Date.parse c["todate"]
        todate - fromdate == 1 && c["count"].to_i > 0
      end
    end
    return nil if counts.empty?

    random_year = select_random_year(counts)

    photo = get_random_photo(random_year)

    get_photo_info(photo)
  end

  class << self
    def from_user(user)
      flickr = FlickRaw::Flickr.new
      flickr.access_token = user.access_token
      flickr.access_secret = user.access_secret
      new(flickr)
    end
  end

  private

  def get_flickr_counts(date)
    benchmark("  Fetching Flickr counts") do
      dates = []
      (1..20).to_a.reverse.each do |i|
        dates << (date - i.years).strftime
        dates << (date + 1.day - i.years).strftime
      end

      with_retries("fetch Flickr counts") do
        flickr.photos.getCounts(taken_dates: dates.join(","))
      end
    end
  end

  def select_random_year(counts)
    benchmark("  Select random year from result") do
      weighted_array = []
      counts.each_with_index do |count, i|
        count["count"].to_i.times { weighted_array << i }
      end
      counts[weighted_array.sample]
    end
  end

  def get_random_photo(year)
    benchmark("  Fetching photos between #{year['fromdate']} and #{year['todate']}") do
      search_options = {
        user_id: "me",
        min_taken_date: year["fromdate"],
        max_taken_date: year["todate"],
        media: "photos",
        per_page: 500,
        extras: "description"
      }
      with_retries("fetch photos from selected date") do
        flickr.photos.search(search_options).to_a.sample
      end
    end
  end

  def get_photo_info(photo)
    benchmark("  Fetching photo info from Flickr") do
      with_retries("fetch photo info from Flickr") do
        flickr.photos.getInfo(photo_id: photo.id)
      end
    end
  end

  def logger
    Rails.logger
  end
end
