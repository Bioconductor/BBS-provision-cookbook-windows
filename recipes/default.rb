require 'find'

# FIXME set timezone

file "c:\\env.txt" do
  content node.chef_environment
  # set to _default in test kitchen
end

file 'c:\\username.txt' do
  content ENV['USERNAME']
end

user 'biocbuild' do
  password "in$secure11pasS" # migrate this to data bag
  action :create
end

# TODO give biocbuild the right to access system via remote desktop

directory 'c:\\downloads' do
  action :create
  owner 'biocbuild'
end

directory "c:\\biocbld\\bbs-#{node['bioc_version']}-bioc" do
  action :create
  owner "biocbuild"
  recursive true
end


remote_file 'c:\\downloads\UserRights.ps1' do
  source 'https://s3.amazonaws.com/bioc-windows-setup/UserRights.ps1'
  owner 'biocbuild'
end

# powershell_script 'haha' do
#   cwd "c:\\downloads"
#   code ". .\\otheruser.ps1"
# end

# powershell_script 'grant privilege' do
#   code <<-EOH
#   Import-Module c:\\Downloads\\UserRights.ps1
#   Try { Grant-UserRight vagrant SeTrustedCredManAccessPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeTrustedCredManAccessPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeNetworkLogonRight } Catch { }
#   Try { Grant-UserRight biocbuild SeNetworkLogonRight } Catch { }
#   Try { Grant-UserRight vagrant SeTcbPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeTcbPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeMachineAccountPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeMachineAccountPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeIncreaseQuotaPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeIncreaseQuotaPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeInteractiveLogonRight } Catch { }
#   Try { Grant-UserRight biocbuild SeInteractiveLogonRight } Catch { }
#   Try { Grant-UserRight vagrant SeRemoteInteractiveLogonRight } Catch { }
#   Try { Grant-UserRight biocbuild SeRemoteInteractiveLogonRight } Catch { }
#   Try { Grant-UserRight vagrant SeBackupPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeBackupPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeChangeNotifyPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeChangeNotifyPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeSystemtimePrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeSystemtimePrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeTimeZonePrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeTimeZonePrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeCreatePagefilePrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeCreatePagefilePrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeCreateTokenPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeCreateTokenPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeCreateGlobalPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeCreateGlobalPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeCreatePermanentPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeCreatePermanentPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeCreateSymbolicLinkPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeCreateSymbolicLinkPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeDebugPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeDebugPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeDenyNetworkLogonRight } Catch { }
#   Try { Grant-UserRight biocbuild SeDenyNetworkLogonRight } Catch { }
#   Try { Grant-UserRight vagrant SeDenyBatchLogonRight } Catch { }
#   Try { Grant-UserRight biocbuild SeDenyBatchLogonRight } Catch { }
#   Try { Grant-UserRight vagrant SeDenyServiceLogonRight } Catch { }
#   Try { Grant-UserRight biocbuild SeDenyServiceLogonRight } Catch { }
#   Try { Grant-UserRight vagrant SeDenyInteractiveLogonRight } Catch { }
#   Try { Grant-UserRight biocbuild SeDenyInteractiveLogonRight } Catch { }
#   Try { Grant-UserRight vagrant SeDenyRemoteInteractiveLogonRight } Catch { }
#   Try { Grant-UserRight biocbuild SeDenyRemoteInteractiveLogonRight } Catch { }
#   Try { Grant-UserRight vagrant SeEnableDelegationPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeEnableDelegationPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeRemoteShutdownPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeRemoteShutdownPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeAuditPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeAuditPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeImpersonatePrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeImpersonatePrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeIncreaseWorkingSetPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeIncreaseWorkingSetPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeIncreaseBasePriorityPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeIncreaseBasePriorityPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeLoadDriverPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeLoadDriverPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeLockMemoryPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeLockMemoryPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeBatchLogonRight } Catch { }
#   Try { Grant-UserRight biocbuild SeBatchLogonRight } Catch { }
#   Try { Grant-UserRight vagrant SeServiceLogonRight } Catch { }
#   Try { Grant-UserRight biocbuild SeServiceLogonRight } Catch { }
#   Try { Grant-UserRight vagrant SeSecurityPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeSecurityPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeRelabelPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeRelabelPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeSystemEnvironmentPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeSystemEnvironmentPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeManageVolumePrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeManageVolumePrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeProfileSingleProcessPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeProfileSingleProcessPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeSystemProfilePrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeSystemProfilePrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeUnsolicitedInputPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeUnsolicitedInputPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeUndockPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeUndockPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeAssignPrimaryTokenPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeAssignPrimaryTokenPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeRestorePrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeRestorePrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeShutdownPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeShutdownPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeSyncAgentPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeSyncAgentPrivilege } Catch { }
#   Try { Grant-UserRight vagrant SeTakeOwnershipPrivilege } Catch { }
#   Try { Grant-UserRight biocbuild SeTakeOwnershipPrivilege } Catch { }
#   EOH
  # code lambda do
  #   x = "Import-Module c:\\Downloads\\UserRights.ps1\n"
  #   privs = %W{SeTrustedCredManAccessPrivilege SeNetworkLogonRight SeTcbPrivilege SeMachineAccountPrivilege SeIncreaseQuotaPrivilege SeInteractiveLogonRight SeRemoteInteractiveLogonRight SeBackupPrivilege SeChangeNotifyPrivilege SeSystemtimePrivilege SeTimeZonePrivilege SeCreatePagefilePrivilege SeCreateTokenPrivilege SeCreateGlobalPrivilege SeCreatePermanentPrivilege SeCreateSymbolicLinkPrivilege SeDebugPrivilege SeDenyNetworkLogonRight SeDenyBatchLogonRight SeDenyServiceLogonRight SeDenyInteractiveLogonRight SeDenyRemoteInteractiveLogonRight SeEnableDelegationPrivilege SeRemoteShutdownPrivilege SeAuditPrivilege SeImpersonatePrivilege SeIncreaseWorkingSetPrivilege SeIncreaseBasePriorityPrivilege SeLoadDriverPrivilege SeLockMemoryPrivilege SeBatchLogonRight SeServiceLogonRight SeSecurityPrivilege SeRelabelPrivilege SeSystemEnvironmentPrivilege SeManageVolumePrivilege SeProfileSingleProcessPrivilege SeSystemProfilePrivilege SeUnsolicitedInputPrivilege SeUndockPrivilege SeAssignPrimaryTokenPrivilege SeRestorePrivilege SeShutdownPrivilege SeSyncAgentPrivilege SeTakeOwnershipPrivilege}
  #   for priv in privs
  #     x += "Grant-UserRight vagrant #{priv}\n"
  #     x += "Grant-UserRight biocbuild #{priv}\n"
  #   end
  #   x
  # end.call
  # <<-EOH
  # Import-Module c:\\Downloads\\UserRights.ps1
  # #Grant-UserRight #{ENV['USERNAME']} SeAssignPrimaryTokenPrivilege
  # #Grant-UserRight biocbuild SeAssignPrimaryTokenPrivilege
  #
  # EOH
  # for priv in privs
  #   code += "Grant-UserRight #{ENV['USERNAME']} #{priv}\n"
  #   code += "Grant-UserRight biocbuild #{priv}\n"
  # end
  # code
# end
# Grant-UserRight #{ENV['USERNAME']} SeCreateTokenPrivilege
# Grant-UserRight #{ENV['USERNAME']} SeImpersonatePrivilege
# Grant-UserRight biocbuild SeCreateTokenPrivilege
# Grant-UserRight biocbuild SeImpersonatePrivilege



# install rtools first so it is first in PATH

remote_file "c:\\downloads\\#{node['rtools_url'].split('/').last}" do
  source node["rtools_url"]
  owner 'biocbuild'
end


# execute "change ownership" do
#   command "takeown /U biocbuild /R /F .\\R /S #{node['hostname']} > NUL 2>&1"
#   cwd "c:\\biocbld\\bbs-#{node['bioc_version']}-bioc"
#
# end


# ruby_block 'install rtools' do
#   block do
#     Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
#     command_to_run = "c:\\downloads\\#{node['rtools_url'].split('/').last} /sp- /verysilent /norestart"
#     shell_out(command_to_run,
#       {
#         :user   => 'biocbuild',
#         :password   => 'in$secure11pasS',
#         :domain => node['hostname']
#       }
#     )
    # rtools_install = Mixlib::ShellOut.new( \
    # ".\\#{node['rtools_url'].split('/').last} /sp- /silent /norestart",
    # cwd: 'c:\\downloads',
    # user: "biocbuild",
    # domain:  node['hostname'],
    # password:  "in$secure11pasS")
    # rtools_install.run_command
#   end
#   not_if File.exists?("c:\\Rtools")
# end

execute 'install Rtools' do
  command ".\\#{node['rtools_url'].split('/').last} /sp- /silent /norestart"
  cwd 'c:\\downloads'
  not_if { File.exists?("c:\\Rtools") }
end



env 'PATH' do
  value "c:\\Rtools\\bin;C:\\Rtools\\mingw_32\\bin;C:\\Rtools\\mingw_64\\bin;#{ENV['PATH']}"
  # don't trust action :modify!
  action :create # not really needed, :create is the default action
  only_if { (ENV['PATH'] =~ /Rtools/i).nil? }
end

env 'BINPREF' do
  value "C:/Rtools/mingw_$(WIN)/bin/"
  action :create
  only_if {  ['_default', 'new_toolchain'].include? node.chef_environment and
    not ENV.has_key? 'BINPREF' }
  # only_if do
  #   if ['_default', 'new_toolchain'].include? node.chef_environment
  #     unless ENV.has_key? 'BINPREF'
  #       true
  #     end
  #   end
  #   false
  # end
end

file 'c:\\path.txt' do # for testing
  content ENV['PATH']
end


# install R

remote_file "c:\\downloads\\#{node['r_url'].split('/').last}" do
  source node['r_url']
  owner "biocbuild"
end


execute "install R" do
  command ".\\#{node['r_url'].split('/').last} /verysilent /dir=c:\\biocbld\\bbs-3.3-bioc\\R /sp- /norestart /NOICONS /TASKS=''"
  cwd "c:\\downloads"
  # what if we really do want to reinstall/update R? separate recipe?
  not_if {File.exists? "c:\\biocbuild\\bbs-#{node['bioc_version']}-bioc\\R\\bin\\R.exe"}
end


ruby_block 'change permissions' do
  block do
    Find.find("c://biocbld/bbs-#{node['bioc_version']}-bioc/R/library") do |path|
      FileUtils.chmod 0777, path
    end
  end
  not_if {}
end


# ruby_block 'install BiocInstaller' do
#   block do
#     Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
#     command_to_run = "c:\\biocbld\\bbs-#{node['bioc_version']}-bioc\\R\\bin\\R -e source('https://bioconductor.org/biocLite.R')"
#     shell_out(command_to_run,
#       {
#         :user   => 'biocbuild',
#         :password   => 'in$secure11pasS',
#         :domain => node['hostname']
#       }
#     )
#   end
#   not_if { File.exists? "c:\\biocbld\\bbs-#{node['bioc_version']}-bioc\\R\\library\\BiocInstaller"}
# end

__END__

require 'yaml'

# FIXME - run apt-get update before doing other stuff, but read
# https://stackoverflow.com/questions/9246786/how-can-i-get-chef-to-run-apt-get-update-before-running-other-recipes
# and
# https://wiki.opscode.com/display/chef/Evaluate+and+Run+Resources+at+Compile+Time;jsessionid=BBE750D0DC249823649B3F4F70F24C82

yamlconfig = YAML.load_file "/vagrant/config.yml"

rmajor = yamlconfig["r_version"].sub(/^R-/, "").split("").first

execute "set hostname on aws" do
    command "echo '127.0.0.1 #{yamlconfig['hostname']}' >> /etc/hosts"
    #FIXME, guard doesn't work, line keeps getting appended.
    # does it also happen when not using AWS?
    only_if "curl -I http://169.254.169.254/latest/meta-data/ && grep -vq #{yamlconfig['hostname']} /etc/hosts"
end


execute "change time zone" do
    user "root"
    command "echo '#{yamlconfig['timezone']}' > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"
    only_if "egrep -q 'UTC|GMT' /etc/timezone"
end

user "biocbuild" do
    supports :manage_home => true
    home "/home/biocbuild"
    shell "/bin/bash"
    action :create
end

bbsdir = "/home/biocbuild/bbs-#{yamlconfig['bioc_version']}-bioc"

directory bbsdir do
    owner "biocbuild"
    group "biocbuild"
    mode "0755"
    action :create
end

directory "/home/biocbuild/.ssh" do
    owner "biocbuild"
    group "biocbuild"
    mode "0755"
    action :create
end

directory "/home/biocbuild/.BBS" do
    owner "biocbuild"
    group "biocbuild"
    mode "0755"
    action :create
end

%w(log NodeInfo svninfo meat R).each do |dir|
    directory "#{bbsdir}/#{dir}" do
        owner "biocbuild"
        group "biocbuild"
        mode "0755"
        action :create
    end
end

%W(src public_html public_html/BBS public_html/BBS/#{yamlconfig['bioc_version']} public_html/BBS/#{yamlconfig['bioc_version']}/bioc).each do |dir|
    directory "/home/biocbuild/#{dir}" do
        owner "biocbuild"
        group "biocbuild"
        mode "0755"
        action :create
    end

end



base_url = "https://hedgehog.fhcrc.org/bioconductor"
if yamlconfig['use_devel']
    branch = 'trunk'
else
    branch = "branches/RELEASE_#{yamlconfig['bioc_version'].sub(".", "_")}"
end

svn_meat_url = "#{base_url}/#{branch}/madman/Rpacks"

package "subversion" do
    action :install
end

directory "/root/.subversion/servers" do
    action :create
    recursive true
    owner "root"
    group "root"
    mode "0777"
end

execute "setup svn auth" do
    cwd "/home/biocbuild"
    user "biocbuild"
    command "tar zxf /vagrant/svnauth.tar.gz"
end

execute "setup svn auth2" do
    cwd "/root"
    user "root"
    command "tar zxf /vagrant/svnauth.tar.gz"
end


# execute "atest" do
#     user "biocbuild"
#     environment({"SVN_PASS" => yamlconfig['svn_password']})
#     #command "svn co --non-interactive --no-auth-cache --username biocbuild --password $SVN_PASS #{svn_meat_url} MEAT0"
#     cwd "#{bbsdir}"
#     command "whoami > whoami.txt"
# ####uncomment_this    not_if {File.exists? "#{bbsdir}/MEAT0"}
#     # rely on STAGE1 to 'svn up' MEAT0
# end

# subversion "check out meat" do
#     repository svn_meat_url
#     #revision "HEAD__"
#     destination "#{bbsdir}/MEAT0"
#     action :checkout
#     user "biocbuild"
#     svn_username "biocbuild"
#     svn_password yamlconfig['svn_password']
# end


execute "this is a bad idea" do
    # ... but it makes svn happy below. don't know
    # why biocbuild needs to see root's svn credentials
    user "root"
    command "chmod -R a+rx /root"
end

execute "checkout meat" do
    user "biocbuild"
    environment({"SVN_PASS" => yamlconfig['svn_password']})
    command "svn checkout --non-interactive --username biocbuild --password $SVN_PASS #{svn_meat_url} MEAT0"
    cwd "#{bbsdir}"
    not_if {File.exists? "#{bbsdir}/MEAT0"}
    timeout 21600
    # rely on STAGE1 to 'svn up' MEAT0
end

%w(    libnetcdf-dev libhdf5-serial-dev sqlite libfftw3-dev libfftw3-doc
    libopenbabel-dev fftw3 fftw3-dev pkg-config xfonts-100dpi xfonts-75dpi
    libopenmpi-dev openmpi-bin mpi-default-bin openmpi-common
    libexempi3 openmpi-checkpoint python-mpi4py texlive-science
    texlive-bibtex-extra texlive-fonts-extra fortran77-compiler gfortran
    libreadline-dev libx11-dev libxt-dev texinfo apache2 libxml2-dev
    libcurl4-openssl-dev libcurl4-nss-dev Xvfb  libpng12-dev
    libjpeg62-dev libcairo2-dev libcurl4-gnutls-dev libtiff4-dev
    tcl8.5-dev tk8.5-dev libicu-dev libgsl0ldbl libgsl0-dev
    libgtk2.0-dev gcj-4.8 openjdk-7-jdk texlive-latex-extra
    texlive-fonts-recommended pandoc libgl1-mesa-dev libglu1-mesa-dev
    htop libgmp3-dev imagemagick unzip libhdf5-dev libncurses-dev
).each do |pkg|
    package pkg do
        # this might timeout, but adding a 'timeout' here
        # causes an error. hmmm.
        # texlive-science seems to be the culprit
        # also texlive-fonts-extra
        action :install
    end
end


link "/var/www/html/BBS" do
    to "/home/biocbuild/public_html/BBS"
end


package "git" do
    action :install
end

remote_file "copy ssh key" do
    path "/home/biocbuild/.ssh/id_rsa"
    source "file:///vagrant/id_rsa"
    owner "biocbuild"
    group "biocbuild"
    mode 0400
    not_if {File.exists? "/home/biocbuild/.ssh/id_rsa"}
end

remote_file "copy ssh key2" do
    path "/home/biocbuild/.BBS/id_rsa"
    source "file:///vagrant/id_rsa"
    owner "biocbuild"
    group "biocbuild"
    mode 0400
    not_if {File.exists? "/home/biocbuild/.BBS/id_rsa"}
end

remote_file "copy ssh config" do
    path "/home/biocbuild/.ssh/config"
    source "file:///vagrant/config"
    owner "biocbuild"
    group "biocbuild"
    mode 0755
end

execute "add public key" do
    user "biocbuild"
    command "cat /vagrant/id_rsa.pub >> /home/biocbuild/.ssh/authorized_keys"
    not_if "grep 'biocbuild@#{yamlconfig['hostname']}' /home/biocbuild/.ssh/authorized_keys"
end

# note, this wipes out crontab (but should only be run once)
execute "add USER to crontab" do
    user "biocbuild"
    command "echo 'USER=biocbuild' | crontab -"
    not_if "crontab -l|grep 'USER=biocbuild'"
end

execute "check out forked BBS" do
    user "biocbuild"
    cwd "/home/biocbuild"
    action :run
    environment({"GIT_TRACE" => "1", "GIT_SSH" => "/vagrant/ssh"})
    command "git clone git@cloud.bioconductor.org:/home/git/BBS-fork.git BBS"
    #command "git clone git@cloud.bioconductor.org:/home/git/BBS-fork.git BBS"
    not_if {File.exists? "/home/biocbuild/BBS"}
end

execute "update forked BBS" do
    user "biocbuild"
    cwd "/home/biocbuild/BBS"
    action :run
    environment ({"GIT_TRACE"=>"1", "GIT_SSH"=>"/vagrant/ssh"})
    command "git pull"
    only_if {File.exists? "/home/biocbuild/BBS"}
end



# check out (forked) BBS
# from git@cloud.bioconductor.org:/home/git/BBS-fork.git
# set machine name in config.yml, make sure BBS knows about it
# and sees it as the main builder

# download and install R...
# http://cran.r-project.org/src/base/R-3/R-3.1.1.tar.gz

r_url = "http://cran.r-project.org/src/base/R-#{rmajor}/#{yamlconfig['r_version']}.tar.gz"
srcfile = "/home/biocbuild/src/#{yamlconfig['r_version']}.tar.gz"

remote_file srcfile do
    source r_url
end

execute "untar R" do
    action :run
    user "biocbuild"
    cwd "/home/biocbuild/src"
    command "tar zxf #{srcfile}"
    not_if {File.exists? "/home/biocbuild/src/#{yamlconfig['r_version']}"}
end

execute "build R" do
    action :run
    user "biocbuild"
    cwd "#{bbsdir}/R"
    command "/home/biocbuild/src/#{yamlconfig['r_version']}/configure --enable-R-shlib && make"
    not_if {File.exists? "#{bbsdir}/R/bin/R"}
end

# download biocinstaller? set devel?

execute "set R flags" do
    action :run
    user "biocbuild"
    cwd "#{bbsdir}/R/etc"
    # this script still exits with code 1.
    command "/home/biocbuild/BBS/utils/R-fix-flags.sh"
    not_if {File.exists? "#{bbsdir}/R/etc/Makeconf.original"}
end

execute "javareconf" do
    action :run
    user "biocbuild"
    command "#{bbsdir}/R/bin/R CMD javareconf"
end

# install apache and set it up...

# install stuff that needs to be built 'manually'

# test build by putting the following in crontab
# (setting the time to be coming up soon)

# the following comments have hostname hardcoded as 'bbsvm'
# but it may be something different

## bbs-3.0-bioc
# 20 16 * * * cd /home/biocbuild/BBS/3.0/bioc/bbsvm && ./prerun.sh >>/home/biocbuild/bbs-3.0-bioc/log/bbsvm.log 2>&1
# 00 17 * * * /bin/bash --login -c 'cd /home/biocbuild/BBS/3.0/bioc/bbsvm && ./run.sh >>/home/biocbuild/bbs-3.0-bioc/log/bbsvm.log 2>&1'
## IMPORTANT: Make sure this is started AFTER 'biocbuild' has finished its "run.sh" job on ALL other nodes!
# 45 08 * * * cd /home/biocbuild/BBS/3.0/bioc/bbsvm && ./postrun.sh >>/home/biocbuild/bbs-3.0-bioc/log/bbsvm.log 2>&1

# put R in user path?

# allow biocbuild to sudo?

execute "put R in user path" do
    user "biocbuild"
    cwd "/home/biocbuild"
    command "echo 'export PATH=\$PATH:#{bbsdir}/R/bin' >> .bashrc"
    not_if "grep -q #{bbsdir} /home/biocbuild/.bashrc"
end

remote_file "copy texmf config" do
    path "/etc/texmf/texmf.d/01bioc.cnf"
    source "file:///vagrant/01bioc.cnf"
    owner "root"
    group "root"
    mode "0644"
end

execute "update-texmf" do
    action :run
    user "root"
    command "update-texmf"
end

# install: jags/cogaps (both versions?)
# ROOT
# ensemblVEP rggobi GeneGA  rsbml prereqs
# gtkmm gtk2
