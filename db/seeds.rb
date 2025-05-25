Photo.find_or_create_by(title: "Logo 1310") do |photo|
  photo.url = "1310.png"
end

Photo.find_or_create_by(title: "CC Logo") do |photo|
  photo.url = "blue_cclogo.png"
end

Photo.find_or_create_by(title: "My Image") do |photo|
  photo.url = "myImage.png"
end
