require 'spec_helper'
require 'migrations/2_change_examples'

class ChangeExample < ActiveRecord::Base
end

describe ChangeExamples do

  before(:all) do
    ActiveRecord::Migration.verbose = false
  end

  before do
    ActiveRecord::Base.connection.drop_table(:change_examples) rescue nil
  end

  after do
  end

  describe '(migration) when change_table and columns' do
    before do
      ChangeExamplesBefore.migrate(:up)
      ChangeExamples.migrate(:up)
    end
    context "t.string with :comment option" do
      it { ChangeExample.columns.find{|c| c.name == 'new_commented' }.comment.should == 'new comment' }
    end

    context "t.change with :comment option" do
      it { ChangeExample.columns.find{|c| c.name == 'commented'     }.comment.should == 'changed comment' }
      it { ChangeExample.columns.find{|c| c.name == 'uncommented'   }.comment.should == 'appended' }
    end

    context "without :comment option" do
      it { ChangeExample.columns.find{|c| c.name == 'commented_to_delete' }.comment.should == '' }
      it { ChangeExample.columns.find{|c| c.name == 'new_no_comment'      }.comment.should == '' }
    end
  end
end

