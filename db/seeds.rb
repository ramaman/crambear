RUBY_CARDS = [
    ["What's an easier way to write \#{@me}?", "\#@me"],
    ["What's the difference between Proc and lambdas","1. lambdas check arg count, procs set extras to nil 2. Proc returns from method w return val, lambdas return val and let method continue"],
    ["what is $* a synonym for?","ARGV"]
]
EMBER_CARDS = [
    ["What are the Ember MVC building blocks?","routes, controllers, templates and views"],
    ["What is Ember's test data store adapter?","adapter: 'DS.FixtureAdapter'"],
    ["What controller property allows it to access another controller?", "needs\n\nApp.NeedyController = Em.Controller.extend\n  needs: ['neededController']"],
    ["What setting allows you to output route transitions", "LOG_TRANSITIONS\n\nApp = Ember.Application.create({LOG_TRANSITIONS: true});"],
    ["How do you make a controller attribute depend on other things", "With the property method e.g. attribute: (someFunction).property('iDependOnThisProp', 'andThisProp')"]
]
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_set(name, cards)
  set = CardSet.create!(name: name)
  cards.each do |card|
    set.cards << Card.new(front: card[0], back: card[1])
  end
  set
end

user = User.create! :name => "TestUser", :email => "test@test.com", :password => "tester", :password_confirmation => "tester"



user.card_sets << create_set("Ember", EMBER_CARDS)
user.card_sets << create_set("Ruby", RUBY_CARDS)
user.save!
