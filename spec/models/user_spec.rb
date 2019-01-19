#require 'spec_helper'
require_relative '../../config/environment.rb'

describe 'User' do 
    before do 
        @user=User.create(:username=>'tbob2018',:email=>'tbob@gmail.com')
    end

    it 'can be initialized' do 
        expect(@user.class).to eq(User)
    end

    it 'has a username' do 
        expect(@user.username).to eq('tbob2018')
    end

    it 'has an email' do 
        expect(@user.email).to eq('tbob@gmail.com')
    end



end