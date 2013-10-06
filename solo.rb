le_cache_path           "#{ENV['HOME']}/chef-repo"
data_bag_path             "#{ENV['HOME']}/chef-repo/data_bags"
encrypted_data_bag_secret "#{ENV['HOME']}/chef-repo/data_bag_key"
cookbook_path             [ "#{ENV['HOME']}/chef-repo/site-cookbooks",
                            "#{ENV['HOME']}/chef-repo/cookbooks" ]
role_path                 "#{ENV['HOME']}/chef-repo/roles"
