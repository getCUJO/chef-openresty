# Array params[x]
# 0 - search role (e.g. fingerprint-service)
# 1 - static prefix
# 2 - iterative part (e.g. ip address with port)
# 3 - delimiter

def expand(params)
  property = params[1]
  nodes = search(:node, "chef_environment:#{node.chef_environment} AND role:#{params[0]}")
  nodes.sort_by!{ |n| n[:ipaddress] }
  nodes.each do |n|
    property += params[2].gsub("{ip}", n[:ipaddress])
    property += params[3] unless n.equal? nodes.last
  end
  return property
end
