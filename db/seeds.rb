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
    ["How do you make a controller attribute depend on other things", "With the property method e.g. attribute: (someFunction).property('iDependOnThisProp', 'andThisProp')"],
    ["What is Ember.K?", "An empty function: Ember.K = function() { return this; }; "],
    ["What is Ember.$?", "An alias for jQuery: Ember.$ = jQuery;"],
    ["How do you pass content to a view?", "Generally in a template. For example\n\nApp.MyView contentBinding='items'\n\nwhere items is defined on your controller"],
    ["How do you get the HTMLElement that a view encapsulates?", "view.get('element')"],
#["",""],
]
CSS = [
    ["How set a CSS width combining % and px?","calc() e.g. \n\nwidth: calc(100% - 60px)\n\nsee https://developer.mozilla.org/en-US/docs/Web/CSS/calc" ],

]


RUBY_LABELS = ["archived","important"]
EMBER_LABELS = ["archived","important"]

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_set(name, cards, labels)
  set = CardSet.new(name: name)
  cards.each do |card|
    set.cards << Card.new(front: card[0], back: card[1])
  end
  labels.each do |label|
    set.labels << Label.new(name: label)
  end
  set.save!
  label = set.labels.where(name: "important").first
  p "set: #{set.name}"
  set.cards.each do |card|
    p "card: #{card.id} card_set_id: #{card.card_set_id} label: #{label.id}"
    card.label_ids = [label.id]
    card.save!
  end
  set
end

CardSet.destroy_all
user = User.first_or_create(:name => "TestUser", :email => "test@test.com", :password => "tester", :password_confirmation => "tester")



user.card_sets << create_set("Ember", EMBER_CARDS, EMBER_LABELS)
user.card_sets << create_set("Ruby", RUBY_CARDS, RUBY_LABELS)
user.save!
