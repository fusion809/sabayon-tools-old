# Get the dependencies
sudo equo i dev-libs/efl evas_generic_loaders wget subversion base-gcc gcc libstdc++
sudo equo i -o x11-wm/enlightenment:0.17
sudo emerge =dev-libs/e_dbus-1.7.10
# Get the source code
MOK=https://github.com/JeffHoogland/moksha/archive
wget -cqO- $MARCH/0.1.0.tar.gz | tar xz --transform=s/moksha-0.1.0/moksha/
# Change into the source code directory
pushd moksha
  # Build
  ./autogen.sh --prefix=/usr && make && sudo make install
  # Get the config files
  JEF=https://github.com/JeffHoogland/bodhi3packages/raw/master/bodhi-profile-moksha/usr/share/enlightenment/data/config/bodhi
  L=('e.cfg e_randr.cfg exehist.cfg module.battery.cfg module.clock.cfg module.conf.cfg module.everything-apps.cfg
  module.everything-files.cfg module.everything.cfg module.gadman.cfg module.ibar.cfg module.notification.cfg
  module.pager.cfg module.syscon.cfg module.tasks.cfg')
  pushd /usr/share/enlightenment/data/config/default
    for i in "${L[@]}"
    do
      sudo wget -c $JEF/$i
    done
  popd
popd
