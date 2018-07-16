Pod::Spec.new do |s|

    s.name             = 'Espresso'
    s.version          = '1.0.1'
    s.summary          = 'Swift convenience library for iOS.'

    s.description      = <<-DESC
      Espresso is a Swift convenience library for iOS.
      Everything is better with a little coffee.
      DESC

    s.homepage              = 'https://github.com/mitchtreece/Espresso'
    s.license               = { :type => 'MIT', :file => 'LICENSE' }
    s.author                = { 'Mitch Treece' => 'mitchtreece@me.com' }
    s.source                = { :git => 'https://github.com/mitchtreece/Espresso.git', :tag => s.version.to_s }
    s.social_media_url      = 'https://twitter.com/mitchtreece'

    s.ios.deployment_target = '10.0'
    # s.ios.public_header_files = 'Espresso/Classes/**/*.h' # No public header files in project currently
    s.source_files = 'Espresso/Classes/**/*'

    s.dependency 'SnapKit', '~> 4.0.0'

end
