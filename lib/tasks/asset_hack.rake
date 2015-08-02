require 'pathname'


# Every time assets:precompile is called, trigger umlaut:create_non_digest_assets afterwards.
Rake::Task["assets:precompile"].enhance do
  Rake::Task["create_non_digest_assets"].invoke
end


# Based on suggestion at https://github.com/rails/sprockets-rails/issues/49#issuecomment-20535134
# but limited to files in umlaut's namespaced asset directories.
task :create_non_digest_assets => :"assets:environment"  do
  logger = Logger.new($stderr)
  manifest_path = Dir.glob(File.join(Rails.root, 'public/assets/.sprockets-manifest-*.json')).first
  manifest_data = JSON.load(File.new(manifest_path))

  manifest_data["assets"].each do |logical_path, digested_path|
    logical_pathname = Pathname.new logical_path

    full_digested_path    = File.join(Rails.root, 'public/assets', digested_path)
    full_nondigested_path = File.join(Rails.root, 'public/assets', logical_path)

    logger.info "Copying\n#{digested_path}\n-> #{full_nondigested_path}"

    # Use FileUtils.copy_file with true third argument to copy
    # file attributes (eg mtime) too, as opposed to FileUtils.cp
    # Making symlnks with FileUtils.ln_s would be another option, not
    # sure if it would have unexpected issues.
    FileUtils.copy_file full_digested_path, full_nondigested_path, true
  end

end
