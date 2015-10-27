class BookSearch

  def initialize(search_string)
    @search_string = search_string
  end

  def perform
    @results = Array.new
    raw = client.search_books(@search_string).results
      unless raw == nil || raw.start_with?("\n")
        if raw.work.first.length > 2
          raw.work.each do |result|
            @results << GoodRead.new(result)
          end
        else
          @results << GoodRead.new(raw.work)
        end
      end
    @results
  end

  def id(id)
    @id = client.book(id)
  end

  protected

  def client
    @client = Goodreads::Client.new(:api_key => ENV['GOODREADS_KEY'], :api_secret => ENV['GOODREADS_SECRET'])
  end

end

