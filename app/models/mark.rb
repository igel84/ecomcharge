class Mark < ActiveRecord::Base
  belongs_to :post, required: true
  validates :value, numericality: { greater_than:0, less_than: 6 }
  
  after_create do |mark|
    average_mark = Mark.where(post_id: mark.post.id).average(:value)
    mark.post.update(average_mark: average_mark)
  end
end