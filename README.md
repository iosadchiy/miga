# MIGA rails app

## Installation

Requirements: ruby 2.4.0, execjs runtime

* clone the repo: `git clone ssh://git@bitbucket.org/iosadchii/miga-be.git`
* install gems: `bundle install`
* setup the DB: `rails db:setup`
* run tests: `rails test`
* start dev server: `rails server`

To add some fake data: `rails db:seed FAKEDATA=1`

## Deployment

### Setting up a new Arch linux server

```
pacman -Sy archlinux-keyring && pacman -Syyu
pacman -S rsync vim zsh wget git nodejs monit nginx certbot certbot-nginx ufw

# from local machine:
vim ~/.ssh/config # add the new_server
vim ~/bin/copy-terminfo
scp ~/.zshrc new_server

chsh /bin/zsh root
vim /etc/ssh/sshd_config #disable password auth
useradd -m -g users -G wheel -s /bin/zsh deploy
passwd deploy
sudo -u deploy mkdir ~deploy/.ssh
cp .ssh/authorized_keys ~deploy/.ssh/
vim /etc/sudoers #allow passwordless sudo for %wheel

# from local machine:
scp .zshrc deploy@new_server:
copy-terminfo deploy@new_server

pacman -S --needed base-devel
vim /etc/makepkg.conf # edit MAKEFLAGS to j8

sudo -u deploy -i
wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
tar zxvf package-query.tar.gz
cd package-query
makepkg -si
wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
tar zxvf yaourt.tar.gz
cd yaourt
makepkg -si

fallocate -l 512M /swapfile\n
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
vim /etc/fstab # /swapfile none swap defaults 0 0

^D
reboot

ssh deploy@new_server
vim /etc/yaourtrc # set EDITFILES=0
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
# make sure rbenv is in .zshrc and relogin
CONFIGURE_OPTS="--disable-install-rdoc" rbenv install 2.4.0
echo "gem: --no-ri --no-rdoc" >> ~/.gemrc
gem i bundler

sudo systemctl start monit
sudo systemctl enable monit

# Setup firewall
ufw default deny
ufw allow SSH
ufw allow WWW\ Full
ufw enable
systemctl enable ufw

systemctl enable nginx

RAILS_ENV=production bundle exec rake db:seed

```

* generate/get ssl certificate
* edit nginx config to include /etc/nginx/sites-enabled and to redirect to https always
* copy nginx config with `cap production puma:nginx_config`
* add monit to nginx config
* edit /etc/monitrc to include /etc/monit.d
* copy monit config with `cap production puma:monit:config`
* create `shared/.env.production` and set vars there (check .env for reference)


## Flows

### Member pays for electricity

    As an admin I open payments#new(plot_number=123)
    Then I fill in current display
    And the sum field gets updated
    Then I press 'сформировать ордера'
    And the payment confirmation page opens
    And a Transaction is created
    With old/new display values, price, sum, name, plot


## TODO

* Transaction#number should go in sequence, with only confirmed counted
* split KPO rendering: separate method for each place (row, td)
* add JS to autofill payment#new fields
* add backups and recover plan
* add import of members
* add import of registers
* create index/edit/destroy for transactions
* add check that Transaction#id goes in series
* dues should not automatically apply to all members (show members for due and dues for member)
* bug: not possible to print pending KPOs
* open KPOs in a new window on payment create
* show fully paid dues separately at the bottom
* show transaction history for members
* add new/edit/delete for dues (delete only those with no transactions)
* setup certs via certbot (blocker: dns)
* migrate from dotenv to rbenv-vars
* don't store payment#total (but use for validation)
* bug: when no registers present payment#new errors 500
* rescue from RoutingError, show 404
* bug: `display` doesn't exist for registers when creating
* add integration tests for common flows
* configure server with chef

## Interested in feedback for

* transaction printed, but cancelled. What to do with KPO number
