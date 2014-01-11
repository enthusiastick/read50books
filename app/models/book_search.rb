class BookSearch

  def initialize(search_string)
    @search_string = search_string
  end

  def perform
    @results = Array.new
    raw = client.search_books(@search_string).results.work
    raw.each do |result|
      @results << result['best_book']['title']
    end
    @results
  end

  protected

  def client
    @client = Goodreads::Client.new(:api_key => ENV['GOODREADS_KEY'], :api_secret => ENV['GOODREADS_SECRET'])
  end

end

