require 'chef-vault'

# Vault attributes format in environment:
# __vaultattribute_name#databag_Item_name#databag_name
#
# Array params[x]
# 0 - Vault attribute name. MUST BE SET!
# 1 - Vault databag_Item_name MUST BE SET!
# 2 - databag_name (default "credentials") 
# 3 - form now unused.

def vault(params)

  puts '__vault params:'
  
  index = 0
  params.each do |param|
      puts 'param ' + index.to_s + ' : ' + params[index]
      index += 1
  end

  databag_name = 'credentials'
  if params.length >= 3
#    puts 'params.length: ' + params.length.to_s

#    puts 'databag_name: ' + databag_name
    databag_name = params[2]
#    puts 'databag_name: ' + databag_name
  end

#  puts 'databag_name: ' + databag_name
#  puts 'item: ' + params[1]
  
  item = ChefVault::Item.load(databag_name,params[1])
  value = item[params[0]]
  return value
end
