require 'spec_helper'

describe 'laravel' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "laravel class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('laravel::params') }
        it { should contain_class('laravel::install').that_comes_before('laravel::config') }
        it { should contain_class('laravel::config') }
        it { should contain_class('laravel::service').that_subscribes_to('laravel::config') }

        it { should contain_service('laravel') }
        it { should contain_package('laravel').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'laravel class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('laravel') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
