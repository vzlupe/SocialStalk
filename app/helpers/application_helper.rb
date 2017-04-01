module ApplicationHelper
  def belongs_to_user?(resource)
    resource.user == current_user
  end

  def activity_resources_exist?(activity)
    activity && activity.trackable && activity.owner
  end
  
  def resource_name
    :user
  end
  
  def resource_class
    User
  end
  
  def resource
    @resource ||= User.new                          # Set resource to resource if resource is not nil. Otherwise, set resource to User.new
  end
  
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]      # Set devise_mapping to devise_mapping if devise_mapping is not nil. Otherwise, set devise_mapping to devise_mappings[:user]
  end
  
end
