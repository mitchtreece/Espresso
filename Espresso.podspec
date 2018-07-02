Pod::Spec.new do |s|

    s.name             = 'Espresso'
    s.version          = '1.0.0'
    s.summary          = 'Convenience library for Swift.'

    s.description      = <<-DESC
      Espresso is a Swift convenience library that
      makes common tasks a lot easier. Everything is better
      with coffee.
      DESC

    s.homepage         = 'https://github.com/mitchtreece/Espresso'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Mitch Treece' => 'mitchtreece@me.com' }
    s.source           = { :git => 'https://github.com/mitchtreece/Espresso.git', :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/MitchTreece'

    s.ios.deployment_target = '10.0'
    s.ios.public_header_files = 'Espresso/Classes/**/*.h'
    s.source_files = 'Espresso/Classes/**/*'

    s.dependency 'SnapKit', '~> 4.0.0'

end
