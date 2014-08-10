require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup do
    @company = companies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:companies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company" do
    assert_difference('Company.count') do
      post :create, company: { currency: @company.currency, description: @company.description, duedil_co_url: @company.duedil_co_url, duedil_locale: @company.duedil_locale, email: @company.email, employee_count: @company.employee_count, incorporation_date: @company.incorporation_date, name: @company.name, phone: @company.phone, reg_address1: @company.reg_address1, reg_address2: @company.reg_address2, reg_address3: @company.reg_address3, reg_address4: @company.reg_address4, reg_address_postcode: @company.reg_address_postcode, reg_co_num: @company.reg_co_num, shareholders_funds: @company.shareholders_funds, turnover: @company.turnover, website: @company.website }
    end

    assert_redirected_to company_path(assigns(:company))
  end

  test "should show company" do
    get :show, id: @company
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @company
    assert_response :success
  end

  test "should update company" do
    put :update, id: @company, company: { currency: @company.currency, description: @company.description, duedil_co_url: @company.duedil_co_url, duedil_locale: @company.duedil_locale, email: @company.email, employee_count: @company.employee_count, incorporation_date: @company.incorporation_date, name: @company.name, phone: @company.phone, reg_address1: @company.reg_address1, reg_address2: @company.reg_address2, reg_address3: @company.reg_address3, reg_address4: @company.reg_address4, reg_address_postcode: @company.reg_address_postcode, reg_co_num: @company.reg_co_num, shareholders_funds: @company.shareholders_funds, turnover: @company.turnover, website: @company.website }
    assert_redirected_to company_path(assigns(:company))
  end

  test "should destroy company" do
    assert_difference('Company.count', -1) do
      delete :destroy, id: @company
    end

    assert_redirected_to companies_path
  end
end
