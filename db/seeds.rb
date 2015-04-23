# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Dir.glob(Rails.root.join 'db', 'functions', '*.sql').each{|path|
  sql = File.open(path){|f| f.read }
  ActiveRecord::Base.connection.execute sql
}

if User.select("1").where(user_name: 'admin').first.blank?
  admin = User.new
  admin.user_name   = 'admin'
  admin.first_name  = 'admin'
  admin.last_name   = 'admin'
  admin.is_admin    = true
  admin.password    = 'admin*1234'
  admin.email       = 'wattaint@gmail.com'
  admin.save!
end
########################################################################################################################
# customer
[
  'Katolec (Vietnam)', 'KSN', 'KTN', 'NBS', 'NC', 
  'NIC', 'NIDEC', 'NLC', 'NMB-C', 'NMB-Thai', 'NOBLE (Eletronic)', 
  'Noble Trading Bangkok', 'RHYTHM', 'SIIX (Bangkok)'
].each{|word|

  if RefCustomer.select("1").where(cust_name: word).where(deleted_at: nil).first.blank?
    n = RefCustomer.new 
    n.cust_name = word
    n.created_by = 'rake db:seed'
    n.updated_by = 'rake db:seed'
    n.save!
  end
}