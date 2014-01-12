class Book < ActiveRecord::Base
  validates_presence_of :title, :author, :date_completed, :user_id
  belongs_to :user

  def year
    self.date_completed.year
  end
end
