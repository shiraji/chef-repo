node[:autorun][:ons].each do |on|
  if !on.empty?
    execute "autorun on" do
      command "chkconfig #{on} on"
      action :run
    end
  end
end

node[:autorun][:offs].each do |off|
  if !off.empty?
    execute "autorun off" do
      command "chkconfig #{off} off"
      action :run
    end
  end
end
