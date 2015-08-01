namespace :db do
  FILE_NAME = 'dump.sql.gz'
  S3_ENV = "production"
  # TODO: Get latest backup somehow
  BACKUP_FILE = 'pixie_production_2015-04-25T12:00:09-04:00.sql.gz'

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
    require 'yaml'

    database = YAML.load_file("#{Rails.root}/config/database.yml")[Rails.env]['database']

    `gunzip -c #{FILE_NAME} | psql -d #{database}`
  end

  task :slurp => [:download_from_s3, :import_from_dump]
end
