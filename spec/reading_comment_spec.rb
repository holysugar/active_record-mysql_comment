# coding: utf-8

require 'spec_helper'
require 'models/test_model'

describe TestModel do
  describe 'column object of comment_string' do
    subject { TestModel.columns.find{|c| c.name == 'comment_string' } }
    it { subject.comment.should == 'column comment' }
  end

  describe 'column object of ja_comment_string' do
    subject { TestModel.columns.find{|c| c.name == 'ja_comment_string' } }
    it { subject.comment.should == 'コメント' }
    it "encoding is utf-8" do
      subject.comment.encoding.should == Encoding::UTF_8
    end
  end

end

