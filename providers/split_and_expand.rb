require_relative 'expand'
require_relative 'expand_by_recipe'
require_relative 'vault'

def split_and_expand(v)

  if ( !v.nil? && (v.kind_of? String) )  
    prop = ''
    if v.start_with?("___")
      prop = expand(v.sub("___", "").split("#"))
    elsif v.start_with?("__recipe_")
      prop = expand_by_recipe(v.sub("__recipe_", "").split("#"))
    elsif v.start_with?("__vault_")
      prop = vault(v.sub("__vault_", "").split("#"))
    else
      prop = v
    end
    return prop
  else
    return v
  end
end
