namespace :coyote do
  namespace :admin do
    desc "Create an admin user"
    task :create, [:email,:password] => :environment do |_,args|
      password = args[:password]

      if password.blank?
        puts "Please enter a password for this user (minimum 8 characters):"
        password = STDIN.gets.chomp.upcase
      end

      user = User.create!(email: args[:email],password: password,admin: true)
      puts "Created #{user} (#{user.email}) with password '#{password}'"
    end
  end

  namespace :db do
    desc "Create initial Context, Metum, and Status"
    task :start => :environment do
      Context.create!([
        { title: "collection" },
        { title: "website" },
        { title: "exhibitions" },
        { title: "events" },
      ])

      long_metum = <<~METUM
        A lengthier text than a traditional alt-text that attempts to provide a comprehensive representation of an image. 
        Long descriptions can range from one sentence to several paragraphs."
      METUM

      Metum.create!([
        { title: "Short", instructions: "A brief description enabling a user to interact with the image when it is not rendered or when the user has low vision" },
        { title: "Long",  instructions: long_metum }
      ])

      Status.create!([
        { title: "Ready to review" },
        { title: "Approved" },
        { title: "Not approved" }
      ])

      puts "Created Contexts, Metums, and Statuses"
    end
  end
end
