require 'spec_helper'

describe Reminder do
  let(:reminder) { Reminder.new :quarterly => 1.month, :yearly => 2.months }
  let(:estate_1) { Estate.new :code => '0066S',
                             :charge_period => :quarterly,
                             :due_dates => [{:day => 1, :month => 2},
                                            {:day => 3, :month => 5},
                                            {:day => 1, :month => 8},
                                            {:day => 5, :month => 11}]
                 }
  let(:estate_2) { Estate.new :code => '0123S',
                             :charge_period => :quarterly,
                             :due_dates => [{:day => 28, :month => 2},
                                            {:day => 31, :month => 5},
                                            {:day => 31, :month => 8},
                                            {:day => 30, :month => 11}]
                 }
  let(:estate_3) { Estate.new :code => '0250S',
                             :charge_period => :yearly,
                             :due_dates => [{:day => 23, :month => 1},
                                            {:day => 22, :month => 6}]
                 }

  it "should return reminders correctly" do

    estates = [estate_1, estate_2, estate_3]

    reminder.on(Date.new(2009,1,1), estates).should == { '0066S' => [Date.new(2009,2,1)],
                                                         '0250S' => [Date.new(2009,1,23)] }

    reminder.on(Date.new(2009,2,1), estates).should == { '0066S' => [Date.new(2009,2,1)],
                                                         '0123S' => [Date.new(2009,2,28)] }

    reminder.on(Date.new(1979,2,2), estates).should == { '0123S' => [Date.new(1979,2,28)] }

    reminder.on(Date.new(1999,3,15), estates).should == {}

    reminder.on(Date.new(2013,4,21), estates).should == { '0066S' => [Date.new(2013,5,3)] }

    reminder.on(Date.new(2017,4,22), estates).should == { '0066S' => [Date.new(2017,5,3)],
                                                          '0250S' => [Date.new(2017,6,22)]}

    reminder.on(Date.new(2000,4,29), estates).should == { '0066S' => [Date.new(2000,5,3)],
                                                          '0250S' => [Date.new(2000,6,22)]}

    reminder.on(Date.new(2002,4,30), estates).should == { '0066S' => [Date.new(2002,5,3)],
                                                          '0123S' => [Date.new(2002,5,31)],
                                                          '0250S' => [Date.new(2002,6,22)]}

    reminder.on(Date.new(2011,10,29), estates).should == { '0066S' => [Date.new(2011,11,5)] }

    reminder.on(Date.new(2011,10,30), estates).should == { '0066S' => [Date.new(2011,11,5)],
                                                           '0123S' => [Date.new(2011,11,30)] }

    reminder.on(Date.new(2006,12,24), estates).should == { '0250S' => [Date.new(2007,1,23)] }
  end
 end
