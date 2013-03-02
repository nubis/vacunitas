#encoding: utf-8
require 'spec_helper'

describe HomeController do
  it 'shows the index page' do
    get :index
    should respond_with :success
  end
  
  it 'shows the calendar page' do
    get :show, name: 'Bauti', year: '2010', month: '10', day: '9'
    should assign_to(:schedule).with_kind_of(Array)
    should respond_with :success
  end
  
  it 'redirects to the index if an invalid date was given' do
    get :show, name: 'Bauti', year: '2010', month: '2', day: '31'
    response.should redirect_to root_path
    flash[:alert].should =~ /no es una fecha válida/
  end
  
  it 'servers a calendar for the specified get request' do
    get :ical, name: 'Bauti', year: '2010', month: '10', day: '9'
    should respond_with :success
    response.content_type.should == 'text/ics'
  end
  
  it 'does not generate a calendar if an invalid date was given' do
    get :ical, name: 'Bauti', year: '2010', month: '2', day: '31'
    response.should redirect_to root_path
    flash[:alert].should =~ /no es una fecha válida/
  end
end
