class Settings::CustomerController < ResourceHelperController
  def projects
    rf = RefCustomer.arel_table
    {
      "record_id"     => rf[:id],
      "lock_version"  => rf[:lock_version],
      "cust_name"     => rf[:cust_name],
      "remark"        => rf[:remark]
    }
  end

  def index_list result
    rf = RefCustomer.arel_table

    stmt = rf.project(project_stmt projects).where(rf[:deleted_at].eq nil).order(rf[:cust_name])

    stmt.where(rf[:cust_name].matches "%#{params[:cust_name]}%") unless params[:cust_name].blank?
    stmt.where(rf[:remark].matches "%#{params[:remark]}%") unless params[:remark].blank?

    result[:rows] = result_rows stmt, projects
    result[:total] = result_total stmt
  end

  def create_form_new result
  end

  def update_edit result
    n = RefCustomer.find params[:id]
    n.fn_update_record_data params[:data]
    n.updated_by = current_user.uuid
    save_record result, n
  end

  def show_form_edit result
    result[:rows] = RefCustomer.find params[:id]
  end

  def create_new result
    n = RefCustomer.new 
    n.fn_update_record_data params[:data]
    n.created_by = current_user.uuid
    n.updated_by = n.created_by

    save_record result, n
  end
end
