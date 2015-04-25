class Programs::QuotationController < ResourceHelperController
  def create_form_create result
    result[:data] = {}
    result[:data][:customers]     = RefCustomer.dropdown
    result[:data][:freight_terms] = RefFreightTerm.dropdown
    result[:data][:unit_prices]   = RefUnitPrice.dropdown
    result[:data][:models]        = RefModel.dropdown
  end
end
