require 'spec_helper'

describe "transmission" do
  let :facts do
    {
      :lsbdistrelease  => '14.04',
      :lsbdistcodename => 'trusty',
      :operatingsystem => 'Ubuntu',
      :osfamily        => 'Debian',
      :lsbdistid       => 'Ubuntu',
    }
  end
  let :params do
    {
      :url           => 'ppa:test/test',
      :user          => 'test-user',
      :group         => 'test-user',
      :port          => '9091',
      :rpc_whitelist => '127.0.0.1,10.0.*.*,192.168.*.*',
      :config_dir    => '/test/transmission-daemon-test',
      :settings      => {}
    }
  end

  it { should contain_class('apt') }
  it { should contain_class('transmission::install_deps').that_comes_before('Class[transmission::install]') }
  it { should contain_class('transmission::install').that_comes_before('Class[transmission::config]') }
  it { should contain_class('transmission::config').that_notifies('Class[transmission::service]') }
  it { should contain_class('transmission::exports') }
  
  describe "transmission::install_deps" do
    it { should contain_apt__ppa('ppa:test/test') }
  end
  
  describe "transmission::install" do
    it { should contain_user('test-user') }
    it { should contain_user('test-user').with_ensure('present') }
    it { should contain_user('test-user').with_allowdupe('false') }
    it { should contain_user('test-user').with_shell('/bin/bash') }
    it { should contain_user('test-user').with_system('true') }
    it { should contain_package('transmission-daemon').with_ensure('installed') }
  end
  
  describe "transmission::config" do
#    let(:settings_default) { IO.read(File.expand_path(File.join(__FILE__, '..', '..', 'fixtures', 'modules', 'transmission', 'files', 'settings_default.json'))) }
    it { should contain_file('/test/transmission-daemon-test/settings.json') }
#    it { should contain_file('/test/transmission-daemon-test/settings.json').with_content(settings_default) }
    it { should contain_file('/test/transmission-daemon-test/settings.json').with_owner('test-user') }
    it { should contain_file('/test/transmission-daemon-test/settings.json').with_group('test-user') }
    it { should contain_file('/test/transmission-daemon-test/settings.json').with_mode('0600') }
    it { should contain_file('/test/transmission-daemon-test/settings.json').that_notifies('Exec[tr_stop]') }    
  end
  
  describe "transmission::service" do
    it { should contain_service('transmission-daemon') }
    it { should contain_service('transmission-daemon').with_ensure('running') }
    it { should contain_service('transmission-daemon').with_name('transmission-daemon') }
    it { should contain_service('transmission-daemon').with_enable('true') }
    it { should contain_service('transmission-daemon').with_hasrestart('true') }
	it { should contain_service('transmission-daemon').with_hasstatus('true') }
  end
  
end