#require 'spec_helper'
require_relative '../../config/environment.rb'

describe 'Course' do 
    before do 
        @course=Course.create(:title=>'HTML & CSS',:content=>'A lot of text.')
    end

    it 'can be initialized' do 
        expect(@course.class).to eq(Course)
    end

    it 'has a title' do 
        expect(@course.title).to eq('HTML & CSS')
    end

    it 'has a content' do 
        expect(@course.content).to eq('A lot of text.')
    end

    it 'has a \'passed\' attribute that defaults to \'false\' ' do 
        expect(@course.passed).to eq(false)
    end



end