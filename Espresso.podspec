Pod::Spec.new do |s|

    s.name             = 'Espresso'
    s.version          = '3.1.0'
    s.summary          = 'Swift convenience library for iOS.'

    s.description      = <<-DESC
      Espresso is a Swift convenience library for iOS.
      Everything is better with a little coffee.
      DESC

    s.homepage                  = 'https://github.com/mitchtreece/Espresso'
    s.license                   = { :type => 'MIT', :file => 'LICENSE' }
    s.author                    = { 'Mitch Treece' => 'mitchtreece@me.com' }
    s.source                    = { :git => 'https://github.com/mitchtreece/Espresso.git', :tag => s.version.to_s }
    s.social_media_url          = 'https://twitter.com/mitchtreece'

    s.swift_version             = '5'
    s.ios.deployment_target     = '13.0'

    # Subspecs

    s.default_subspec = 'UI'

    s.subspec 'Core' do |ss|

        ss.source_files = 'Sources/Core/**/*'

        ss.dependency     'CombineExt', '~> 1.0'

    end

    s.subspec 'UI' do |ss|

        ss.source_files = 'Sources/UI/**/*'

        ss.dependency     'Espresso/Core'
        ss.dependency     'SnapKit', '~> 5.0'

    end

    s.subspec 'Promise' do |ss|

        ss.source_files = 'Sources/Promise/**/*'

        ss.dependency     'Espresso/Core'
        ss.dependency     'PromiseKit', '~> 6.0'

    end

    ## Aggregates

    s.subspec 'All' do |ss|

        ss.dependency     'Espresso/Core'
        ss.dependency     'Espresso/UI'
        ss.dependency     'Espresso/Promise'

    end

    ## Recipes

    s.subspec 'Recipe-Modern' do |ss|

        ss.dependency     'Espresso/UI'
        ss.dependency     'Espresso/Promise'
        ss.dependency     'Spider-Web/All', '~> 2.0'
        ss.dependency     'Director/All',   '~> 1.0'
        ss.dependency     'Swinject',       '~> 2.0'

    end

    ## Library Support

    ### Spider

    s.subspec 'LibSupport-Spider' do |ss|

        ss.source_files = 'Sources/Core/Types/JSON/**/*',
                          'Sources/Core/Types/URLRepresentable.swift',
                          'Sources/Core/Extensions/NSObject+Espresso.swift'

    end

end
