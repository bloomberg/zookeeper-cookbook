if defined?(ChefSpec)
  %i{enable disable start stop restart}.each do |action|
    define_method(:"#{action}_zookeeper_service") do |resource_name|
      ChefSpec::Matchers::ResourceMatcher.new(:zookeeper_service, action, resource_name)
    end
  end

  def create_zookeeper_config(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:zookeeper_config, :create, resource_name)
  end

  def delete_zookeeper_config(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:zookeeper_config, :delete, resource_name)
  end
end
