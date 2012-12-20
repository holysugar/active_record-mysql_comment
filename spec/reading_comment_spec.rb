require 'spec_helper'
require 'models/test_model'

describe TestModel do
  describe 'column object' do
    subject { TestModel.columns.find{|c| c.name == 'comment_string' } }

    it "" do
      subject.comment.should == 'column comment'
    end

  end
end

