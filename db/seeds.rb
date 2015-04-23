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
def init_ref model, field, words
  words.each{|word|
    cond = {}
    cond[field] = word
    
    if model.select("1").where(cond).where(deleted_at: nil).first.blank?
      n = model.new 
      n[field] = word
      n.created_by = 'rake db:seed'
      n.updated_by = 'rake db:seed'
      n.save!
    end
  }
end
########################################################################################################################
# customer
init_ref RefCustomer, :cust_name, [
  'Katolec (Vietnam)', 'KSN', 'KTN', 'NBS', 'NC', 
  'NIC', 'NIDEC', 'NLC', 'NMB-C', 'NMB-Thai', 'NOBLE (Eletronic)', 
  'Noble Trading Bangkok', 'RHYTHM', 'SIIX (Bangkok)'
] 
########################################################################################################################
# customer
init_ref RefFreightTerm, :freight_term, [
  'C.I.F.HONGKONG', 'C.I.F.YANGON', 'C.I.F.DALIAN', 'C.I.F.SAVANNAKHET', 'C.I.F.TOKYO', 
  'F.O.B.BANGKOK', 'F.O.B.AYUTTHAYA', 'D.A.T.WUXI', 'C.I.F.HA-NOI', 'C.I.F.AYUTTHAYA', 'C.I.F.SHANGHAI', 
  'C.I.F.SENDAI', 'C.I.P.TOKYO', 'F.C.A.BANGKOK'
]