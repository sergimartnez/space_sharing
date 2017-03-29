module ApplicationHelper
  def resource_name
    :user
  end

  def gravatar_for(user, opts = {})
    opts[:alt] = user.name
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 40 }}",
              opts
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


  # def bootstrap_class_for flash_type
  #   case flash_type
  #     when "success"
  #       "alert-success"
  #     when "error"
  #       "alert-danger"
  #     when "alert"
  #       "alert-warning"
  #     when "notice"
  #       "alert-info"
  #     else
  #       flash_type.to_s
  #     end
  # end
end
