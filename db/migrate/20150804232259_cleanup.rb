class Cleanup < ActiveRecord::Migration
  def up
    drop_table :memberships
    drop_table :sounds
    drop_table :projects
    drop_table :script_members
    drop_table :plugins
    drop_table :oauth_tokens
    drop_table :library_scripts
    drop_table :links
    drop_table :leads
    drop_table :experiments
    drop_table :events
    drop_table :delayed_jobs
    drop_table :chats
    drop_table :visits
    drop_table :versions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
