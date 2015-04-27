namespace :db do
  FILE_NAME = 'dump.sql.gz'
  S3_ENV = "production"
  # TODO: Get latest backup somehow
  BACKUP_FILE = 'pixie_production_2015-04-25T12:00:09-04:00.sql.gz'

  task :download_from_s3 do
    require 'aws-sdk'
    require 'yaml'

    config = YAML.load_file("#{Rails.root}/config/s3.yml")[S3_ENV]

    Aws.config[:region] = "us-east-1"
    Aws.config[:credentials] = Aws::Credentials.new(
      config['access_key_id'],
      config['secret_access_key']
    )
    s3 = Aws::S3::Client.new

    File.open(FILE_NAME, 'wb') do |file|
      s3.get_object(
        { bucket: 'pixie.strd6.com', key: BACKUP_FILE },
        target: file
      )
    end
  end

  task :import_from_dump => [:drop, :create, "schema:load"] do
    require 'yaml'

    database = YAML.load_file("#{Rails.root}/config/database.yml")[Rails.env]['database']

    `gunzip -c #{FILE_NAME} | psql -d #{database}`
  end

  task :slurp => [:download_from_s3, :import_from_dump]
end
