class Ecomcharge < Sinatra::Base
  before do
    content_type :json
    next unless request.post?
    @data = JSON.parse request.body.read    
  end

  get '/' do
    status 200
    {message: 'Hello World'}.to_json
  end

  post '/' do
    post = Post.new(
      title:    @data["title"],
      body:     @data["body"],
      user:     User.find_or_create_by(login: @data["login"]),
      ip:       @data["ip"] #request.ip
    )

    if post.valid?
      post.save
      status 200
      body post.show_view.to_json
    else
      status 422
      post.errors.to_json
    end
  end

  post '/mark' do
    mark = Mark.new(
      post_id: @data["id"], 
      value: @data["value"]
    )

    if mark.valid?
      mark.save
      status 200
      mark.post.average_mark.to_json
    else
      status 422
      mark.errors.to_json
    end
  end

  get '/top/:raiting' do
    status 200
    Post.by_raiting(params[:raiting]).to_json
  end

  get '/ips' do
    status 200
    Post.ips.to_json
  end
end