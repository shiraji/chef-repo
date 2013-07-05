default['adduser']['user1']['group']['name'] = "shiraji"
default['adduser']['user1']['group']['gid'] = 10000
default['adduser']['user1']['name'] = "shiraji"
default['adduser']['user1']['comment'] = "comment"
default['adduser']['user1']['uid'] = 10000
default['adduser']['user1']['shell'] = "/bin/bash"
#ここが微妙。ssh鍵ごとに設定したいなー
default['adduser']['user1']['ssh_rsa']['A'] = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAgGB/bZrITA6T1+fwFZApsQnK6CyGJZQsyNBoJVrcbunz7he6zHViOeqAwlLWuSf9bObScvdWD+mqzf18HmXsCMI/9kpyHLs6vPylSOeCeJY/Bn/gK8NRCxsCeniA8ZSkJ57j+hmq9j/Ci6sa+a1ytGpjAj+TwijWsy9KE1vuaQk="
default['adduser']['user1']['ssh_rsa']['B'] = "TEST"
default['adduser']['user1']['addToWheel'] = true

