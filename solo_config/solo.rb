add_formatter :nyan
add_formatter :foo
add_formatter :bar
checksum_path '/var/chef/checksums'
cookbook_path [
               '/var/chef/cookbooks'
              ]
data_bag_path '/var/chef/data_bags'
environment 'staging'
environment_path '/var/chef/environments'
file_backup_path '/var/chef/backup'
file_cache_path '/var/chef/cache'
json_attribs nil
lockfile nil
log_level :info
log_location STDOUT
node_name 'local_node'
solo false
syntax_check_cache_path
umask 0022
verbose_logging nil
