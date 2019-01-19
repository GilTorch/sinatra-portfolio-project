require_relative '../../config/environment.rb'

describe 'Role' do 
    before do 
        @role=Role.create(:role_label=>'A Course Label',:permission=>'rwx')
    end

    it 'can be initialized' do 
        expect(@role.class).to eq(Role)
    end

    it 'has a role_label' do 
        expect(@role.role_label).to eq('A Course Label')
    end

    it 'has a role permission' do 
        expect(@role.permission).to eq("rwx")
    end


end