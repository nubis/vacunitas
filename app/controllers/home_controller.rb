#encoding: utf-8
class HomeController < ApplicationController
  before_filter :validate_date, only: [:show, :ical]

  def index
  end
  
  def show
    @schedule = Calendar.schedule(@date)
  end
  
  def ical
    render content_type: 'text/calendar',
      text: Calendar.generate_ics(params[:name], @date).export
  end
  
private
  def validate_date
    @date = DateTime.civil( *params.values_at( :year, :month, :day ).collect(&:to_i) )
  rescue Exception => e
    redirect_to root_path, alert: "La fecha ingresada no es una fecha válida."
  end
end
