require 'spec_helper'

describe 'phpfpm' do
  context 'supported operating systems' do
    ['RedHat'].each do |osfamily|
      describe "phpfpm class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }
        it { should contain_class('phpfpm::params') }
      end
    end
  end

end
