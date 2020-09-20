logins = []
100.times do
  logins << Faker::Name.first_name
end

50.times do
  ip = Faker::Internet.public_ip_v4_address

  Thread.new do
    4000.times do
      title = Faker::Lorem.sentence
      body  = Faker::Lorem.paragraph
    
      cmd = %W(curl -i --header 'Content-Type: application/json' --request POST --data
        '{"title":"#{title}","body":"#{body}","login":"#{logins[rand(99)]}","ip":"#{ip}"}' 
        http://localhost:9393
      ).join(" ")
      system(cmd)
    end
  end.join
end

100000.times do
  Thread.new do
    cmd = %W(curl -i --header 'Content-Type: application/json' --request POST --data
      '{"id":"#{rand(1..11)}","value":"#{rand(1..5)}"}' 
      http://localhost:9393/mark
    ).join(" ")
    system(cmd)
  end.join
end

# curl --header "Content-Type: application/json" --request POST --data '{"title":"Post title","body":"Post body.","login":"bloger","ip":"122.122.122.122"}' http://localhost:9393
# curl --header "Content-Type: application/json" --request POST --data '{"id":"1","value":"4"}' http://localhost:9393/mark
# curl --header "Content-Type: application/json" --request GET http://localhost:9393/top/2.5
# curl --header "Content-Type: application/json" --request GET http://localhost:9393/