Backup::Model.new(:miga, 'OMG MIGA') do
  # ROOT = File.absolute_path(File.join(File.dirname(Config.config_file), "..", ".."))
  ROOT = '~/miga'

  archive :all do |archive|
    # Run the `tar` command using `sudo`
    # archive.use_sudo
    archive.root ROOT
    archive.add "."
    archive.exclude "shared/tmp"
  end

  compress_with Bzip2

  store_with Local do |local|
    local.path = "~/backups-miga"
    local.keep = 20
  end

end
