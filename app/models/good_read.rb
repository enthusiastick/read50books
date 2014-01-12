class GoodRead

  def initialize(hash)
    @hash = hash['best_book']
  end

  def id
    @hash['id']
  end

  def title
    @hash['title']
  end

  def author
    @hash['author']
  end

end
