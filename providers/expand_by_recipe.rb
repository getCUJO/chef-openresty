# Array params[x]
# 0 - search recipe (e.g. cujo-service::agent)
# 1 - static prefix
# 2 - iterative part (e.g. ip address with port)
# 3 - delimiter
# 4 - static suffix

def expand_by_recipe(params)
  property = params[1]
# recipes:cujo-service\\:\\:es-old
  recipe = params[0].gsub(':','\:')
  nodes = search(:node, "chef_environment:#{node.chef_environment} AND recipe:#{recipe}")
  nodes.sort_by!{ |n| n[:ipaddress] }
  nodes.each do |n|
    property += params[2].gsub("{ip}", n[:ipaddress])
    property += params[3] unless n.equal? nodes.last
  end
  if params.length >= 5
    property += params[4]
  end
  return property
end
