Backup::Model.new(:miga_db, 'OMG MIGA DB only') do
  # ROOT = File.absolute_path(File.join(File.dirname(Config.config_file), "..", ".."))
  ROOT = '~/miga'

  archive :db do |archive|
    # Run the `tar` command using `sudo`
    # archive.use_sudo
    archive.root ROOT
    archive.add "shared/db/production.sqlite3"
  end

  compress_with Bzip2

  store_with Local do |local|
    local.path = "~/backups-miga"
    local.keep = 30
  end

end
