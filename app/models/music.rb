class Music < ActiveRecord::Base
  searchable do
    text :title, :description, :release_year, :artist
    text :reviews do
      reviews.map{ |review| review.comment }
    end
  end
  
  belongs_to :user
  has_many :reviews

  has_attached_file :image, styles: { medium: "400x400#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
