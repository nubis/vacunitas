require 'spec_helper'

describe Calendar do
  describe 'when fetching the barebones schedule' do
    subject { Calendar.schedule(Date.today) }
    it{ should be_an Array }
    its(:size){ should == 10 }
  end
  
  describe 'when creating an ics calendar' do
    subject{ Calendar.generate_ics('Bauti', Date.today) }
    it{ should be_a RiCal::Component::Calendar }
  end
end
