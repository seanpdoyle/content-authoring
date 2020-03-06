# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Page.create(
  [
    {
      headline: "
        From idea to 1,000 monthly paying users in just 6 months
      ".strip,
      name: "
        Splitfit
      ".strip,
    },

    {
      headline: "
        Integrating a content management system to help marketing move faster
      ".strip,
      name: "
        DigitalOcean
      ".strip,
    },

    {
      headline: "
        Online auto seller goes from concept to Superbowl Sunday launch
      ".strip,
      name: "
        Joydrive
      ".strip,
    },
  ],
)
