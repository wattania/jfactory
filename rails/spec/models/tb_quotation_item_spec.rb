require 'rails_helper'

RSpec.describe TbQuotationItem, :type => :model do
  describe "#validate_xml" do 

    before :each do
      @file_data_path = Rails.root.join 'spec', 'fixtures', 'Import file.xlsx'
      @file_data = File.open(@file_data_path, 'rb'){ |f| f.read }
    end

    it "x" do
      TbQuotationItem.validate_xml @file_data_path.to_s
    end
  end
end