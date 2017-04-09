# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( home.js )
Rails.application.config.assets.precompile += %w( new-search.js )
Rails.application.config.assets.precompile += %w( new-space.js )
Rails.application.config.assets.precompile += %w( show-map.js )
Rails.application.config.assets.precompile += %w( slider.js )
Rails.application.config.assets.precompile += %w( searching-index.js )
Rails.application.config.assets.precompile += %w( show-google-map.js )

Rails.application.config.assets.precompile += %w( _home-footer.css )
Rails.application.config.assets.precompile += %w( _home-header.css )
Rails.application.config.assets.precompile += %w( _home-main-container.css )
Rails.application.config.assets.precompile += %w( _user-login-form.css )
Rails.application.config.assets.precompile += %w( _user-register-form.css )
Rails.application.config.assets.precompile += %w( _home-main-container.css )
Rails.application.config.assets.precompile += %w( _shared-rental-view.css )
Rails.application.config.assets.precompile += %w( _search-show.css )
Rails.application.config.assets.precompile += %w( _searching-main-container.css )
Rails.application.config.assets.precompile += %w( _searches-index.css )
Rails.application.config.assets.precompile += %w( _spot-search-main-container.css )
Rails.application.config.assets.precompile += %w( chatrooms.css )
Rails.application.config.assets.precompile += %w( _header.css )
Rails.application.config.assets.precompile += %w( _space-show.css )

# Rails.application.config.assets.precompile += %w( users.css )
