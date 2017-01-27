# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( bootstrap.css )
Rails.application.config.assets.precompile += %w( glyphicons.css )
Rails.application.config.assets.precompile += %w( default.scss )
Rails.application.config.assets.precompile += %w( animate.css )
Rails.application.config.assets.precompile += %w( et-icons.scss )
Rails.application.config.assets.precompile += %w( font-awesome.min.css )
Rails.application.config.assets.precompile += %w( normalize.css )
Rails.application.config.assets.precompile += %w( owl.css )
Rails.application.config.assets.precompile += %w( welcome.scss )

Rails.application.config.assets.precompile += %w( index.css )
Rails.application.config.assets.precompile += %w( show.css )
Rails.application.config.assets.precompile += %w( venues.css )
Rails.application.config.assets.precompile += %w( events.css )

Rails.application.config.assets.precompile += %w( owl.carousel.min.js )
Rails.application.config.assets.precompile += %w( typed.js )
Rails.application.config.assets.precompile += %w( typewriter.js )
Rails.application.config.assets.precompile += %w( wow.min.js )
Rails.application.config.assets.precompile += %w( jquery.onepagenav.js )
Rails.application.config.assets.precompile += %w( welcome.js )
Rails.application.config.assets.precompile += %w( venues.js )
Rails.application.config.assets.precompile += %w( events.js )
Rails.application.config.assets.precompile += %w( ratings.js )

# Rails.application.config.assets.precompile += %w( ratings.js )
