class Post < ActiveRecord::Base
  belongs_to :user, required: true
  validates :title, :body, presence: true

  def show_view
    {
      title:  title,
      body:   body,
      author: user.login,
      ip:     ip
    }
  end

  def self.by_raiting(raiting)
    where(average_mark: raiting)
    .map{|p| { title: p.title, body: p.body }}
  end

  def self.ips
    select([:id, :ip, :user_id])
    .includes(:user)
    .group_by(&:ip)
    .map{ |ip, posts| { ip => posts.map{ |p| p.user.login }}}
  end
end