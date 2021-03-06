require "factory_girl_rails"

begin
  FactoryGirl.find_definitions 
rescue FactoryGirl::DuplicateDefinitionError 
  # necessary to be able to use the rake db:seed task where we want, argh
  Rails.logger.debug "Factory Girl definitions previously loaded"
end

Context.create!([
  { title: "collection" },
  { title: "website" },
  { title: "exhibitions" },
  { title: "events" },
])

short_metum, long_metum = Metum.create!([
  { title: "Short", instructions: "A brief description enabling a user to interact with the image when it is not rendered or when the user has low vision" },
  { title: "Long",  instructions: "A lengthier text than a traditional alt-text that attempts to provide a comprehensive representation of an image. Long descriptions can range from one sentence to several paragraphs." }
])

Status.create!([
  { title: "Ready to review" },
  { title: "Approved" },
  { title: "Not approved" }
])

image = FactoryGirl.create(:image,{
  path: "https://coyote.pics/wp-content/uploads/2016/02/Screen-Shot-2016-02-29-at-10.05.14-AM-1024x683.png",
  title: "T.Y.F.F.S.H., 2011"
})

alt_text = "A red, white, and blue fabric canopy presses against walls of room; portable fans blow air into the room through a doorway."

long_text = <<-TEXT
This is an installation that viewers are invited to walk inside of. From this viewpoint you are looking through a doorway at a slight distance, 
as if standing inside of a large cave and looking out of its narrow entrance at the world outside. The walls of this cave are alternating stripes of 
red, white, and blue material that seems to be made of some kind of thin fabric. These colored stripes spiral around toward the entrance, as if 
being sucked out of the opening. The inside of the cave is more shadowed and the area outside is brightly lit. Gradually you notice that there 
are in fact two openings lined up in front of each other, straight ahead of you: the first one is a tall rectangle—the red, white and blue fabric 
is wrapped through the edges of a standard doorway; beyond that it continues to spiral around toward another circular opening.  The center of 
this circle is much brighter, as if one had finally escape from the cave. At the center of that circular opening you see two large white fans 
facing your direction, blowing air into the cave-like opening. Beyond the fans you see a brown, square form, which is the bottom of a 
huge wicker basket. This basket, lying on its side, helps to reveal the truth about what you are seeing: You are standing inside of a huge 
hot air balloon, which is lying on its side. Blown by the fans, the fabric billows out to press out against the existing walls of a large room, 
the malleable shape of the balloon conforming to the rectangular surfaces of an existing building–the gallery that contains it.
TEXT

FactoryGirl.create(:description,image: image,metum: short_metum,text: alt_text)
FactoryGirl.create(:description,image: image,metum: long_metum,text: long_text)

# to create an admin user, run bin/rake coyote:admin:create[user@example.com]
