class RefCustomer < ActiveRecord::Base
  include FuncValidateHelper
  include FuncUpdateRecord

  validates :cust_name, presence: true

  before_validation :func_set_uuid, on: :create
  
end
