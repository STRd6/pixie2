namespace :db do
  FILE_NAME = 'dump.sql.gz'
  S3_ENV = "production"
  # TODO: Get latest backup somehow
  BACKUP_FILE = 'pixie_production_2015-08-01T00:00:11-04:00.sql.gz'

  task :download_from_s3 do
    require 'aws/s3'
    require 'yaml'

    config = YAML.load_file("#{Rails.root}/config/s3.yml")[S3_ENV]
    s3 = AWS::S3.new config

    bucket = s3.buckets['pixie.strd6.com']
    most_recent_backup = bucket.objects[BACKUP_FILE]

    File.open FILE_NAME, "wb" do |file|
      file.write most_recent_backup.read
    end
  end

  task :import_from_dump => [:drop, :create, "schema:load"] do
    require 'erb'
    require 'yaml'

    config = YAML.load(ERB.new(File.read("#{Rails.root}/config/database.yml")).result)[Rails.env]
    database = config['database']
    user = config['username']

    cmd = "gunzip -c #{FILE_NAME} | psql -U #{user} -d #{database}"

    puts cmd
    `#{cmd}`
  end

  task :slurp => [:download_from_s3, :import_from_dump]
end
