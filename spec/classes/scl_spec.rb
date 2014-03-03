require 'spec_helper'

describe 'phpfpm' do
  context 'Test with SCL' do
    let(:params) {{
      :package => 'php54-php-fpm',
      :service => 'php54-php-fpm',
      :config  => '/opt/rh/php54/root/etc/php-fpm.d/www.conf'
    }}
    let (:facts) {{
      :osfamily => 'RedHat',
    }}

    it { should contain_package('php54-php-fpm') }
    it { should contain_service('php54-php-fpm') }
    it { should contain_file('/opt/rh/php54/root/etc/php-fpm.d/www.conf') }
  end

end
