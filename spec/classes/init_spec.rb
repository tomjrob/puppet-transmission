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
  it { should contain_anchor('::transmission::begin').that_comes_before('Class[transmission::install_deps]') }
  it { should contain_class('transmission::install_deps').that_comes_before('Class[transmission::install]') }
  it { should contain_class('transmission::install').that_comes_before('Class[transmission::config]') }
  it { should contain_class('transmission::config').that_notifies('Class[transmission::service]') }
  it { should contain_class('transmission::service').that_comes_before('Anchor[::transmission::end]') }
  it { should contain_anchor('::transmission::end') }
end