class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_format_of :username, without: /\A\d/
  validates_uniqueness_of :username

  has_many :books

  def self.find(input)
    input.to_i == 0 ? find_by_username(input) : super
  end

  def to_param
    username
  end

end
