require 'yaml'

yamlconfig = YAML.load_file "/vagrant/config.yml"

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

directory "/home/biocbuild/.BBS" do
    owner "biocbuild"
    group "biocbuild"
    mode "0755"
    action :create
end

%w(log MEAT0 NodeInfo svninfo meat R).each do |dir|
    directory "#{bbsdir}/#{dir}" do
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


execute "checkout meat" do
    environment({"SVN_PASS" => yamlconfig['svn_password']})
    command "svn co --non-interactive --username biocbuild --password $SVN_PASS #{svn_meat_url} MEAT0"
    cwd "#{bbsdir}"
    user "biocbuild"
####uncomment_this    not_if {File.exists? "#{bbsdir}/MEAT0"}
    # rely on STAGE1 to 'svn up' MEAT0
end

# %w(    libnetcdf-dev libhdf5-serial-dev sqlite ibfftw3-dev libfftw3-doc
#     libopenbabel-dev fftw3 fftw3-dev pkg-config xfonts-100dpi xfonts-75dpi
#     libopenmpi-dev openmpi-bin mpi-default-bin openmpi-common
#     libexempi3 openmpi-checkpoint python-mpi4py texlive-science biblatex
# ).each do |pkg|
#     package pkg do
#         action :install
#     end
# end

# check out (forked) BBS
# set machine name in config.yml, make sure BBS knows about it 
# and sees it as the main builder