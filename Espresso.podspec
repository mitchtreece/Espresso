Pod::Spec.new do |s|

    s.name             = 'Espresso'
    s.version          = '2.0.0'
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

    s.swift_version             = '4.2'
    s.ios.deployment_target     = '10.0'

    # Subspecs

    s.default_subspec = 'Core'

    s.subspec 'Core' do |core|

        core.source_files       = 'Espresso/Classes/Core/**/*'
        core.dependency         'SnapKit', '~> 4.0.0'

    end

    s.subspec 'DI' do |di|

        di.source_files         = 'Espresso/Classes/DI/**/*'
        di.dependency           'Espresso/Core'
        di.dependency           'Swinject', '~> 2.6.0'

    end

    s.subspec 'Mvvm' do |mvvm|

        mvvm.source_files       = 'Espresso/Classes/Mvvm/**/*'
        mvvm.dependency         'Espresso/Core'

    end

    s.subspec 'RxMvvm' do |rx|

        rx.source_files         = 'Espresso/Classes/RxMvvm/**/*'
        rx.dependency           'Espresso/Mvvm'
        rx.dependency           'RxSwift', '~> 4.0'
        rx.dependency           'RxCocoa', '~> 4.0'

    end

    s.subspec 'All' do |all|

        all.dependency          'Espresso/Core'
        all.dependency          'Espresso/DI'
        all.dependency          'Espresso/Mvvm'
        all.dependency          'Espresso/RxMvvm'

    end

end
