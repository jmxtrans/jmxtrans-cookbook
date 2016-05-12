# Define custom matchers
# Refer: https://github.com/sethvargo/chefspec#packaging-custom-matchers

if defined?(ChefSpec)
    ChefSpec.define_matcher :ark

    # def install_ark(resource_name)
    #     ChefSpec::Matchers::ResourceMatcher.new(:ark, :install, resource_name)
    # end
end
