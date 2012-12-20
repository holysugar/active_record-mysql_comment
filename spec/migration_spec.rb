require 'spec_helper'
require 'migrations/1_create_create_examples'

class Example < ActiveRecord::Base
end

describe CreateExamples do

  before(:all) do
    ActiveRecord::Migration.verbose = false
  end

  before do
    ActiveRecord::Base.connection.drop_table(:examples) rescue nil
  end

  after do
  end

  describe '(migration) when areate_table and columns' do
    before do
      CreateExamples.migrate(:up)
    end
    context "with :comment option" do
      it { Example.columns.find{|c| c.name == 'name'          }.comment.should == 'example name' }
      it { Example.columns.find{|c| c.name == 'number_column' }.comment.should == 'example number' }
    end

    context "without :comment option" do
      it { Example.columns.find{|c| c.name == 'uncommented'   }.comment.should == '' }
    end
  end
end

