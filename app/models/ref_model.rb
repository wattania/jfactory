class RefModel < ActiveRecord::Base
  include FuncValidateHelper
  include FuncUpdateRecord

  validates :model_name, presence: true

  before_validation :func_set_uuid, on: :create

  validate :v_duplicate_model_name

  def v_duplicate_model_name
    return unless self.deleted_at
    if RefModel.select(1).where(deleted_at: nil).where(model_name: self.model_name).size > 0
      error[:model_name] << "Model Duplicate!"
    end
  end
end
