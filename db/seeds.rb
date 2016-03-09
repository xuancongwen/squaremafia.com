# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?
  user = User.create!(
      name: 'Admin Admin',
      email: 'admin@example.com',
      phone: '+14155555555',
      password: 'admin',
      password_confirmation: 'admin',
      role: :admin,
      sq_start_date: Time.at(0),
      sq_end_date: Time.parse('2016-02-29'),
      discipline: 'Rockstar engineer.')
  discuss = MailingList.create!(name: 'discuss', description: 'For general discussion.')
  MailingList.create!(name: 'eng', description: 'Engineering-focused discussion')
  MailingList.create!(name: 'design', description: 'Design-focused discussion')
  MailingList.create!(name: 'fatties', description: 'All the fatties at the ice cream truck.')

  user.mailing_lists << discuss

  User.create!(name: 'Regular Regular',
               email: 'regular@example.com',
               phone: '+14155555555',
               password: 'regular',
               password_confirmation: 'regular',
               role: :regular,
               sq_start_date: Time.at(0),
               sq_end_date: Time.parse('2014-01-01'),
               discipline: 'People Team')
  User.create!(name: 'Newbie Newbie',
               email: 'newbie@example.com',
               phone: '+14155555555',
               password: 'newbie',
               password_confirmation: 'newbie',
               sq_start_date: Time.at(0),
               sq_end_date: Time.parse('2016-02-29'),
               discipline: 'HIT Squad')
  User.create!(name: 'Disabled Disabled',
               email: 'disabled@example.com',
               phone: '+14155555555',
               password: 'disabled',
               password_confirmation: 'disabled',
               role: :disabled,
               sq_start_date: Time.at(0),
               sq_end_date: Time.parse('2016-02-29'),
               discipline: 'Bad person extraordinaire')
end