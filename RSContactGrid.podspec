Pod::Spec.new do |s|

  s.name          = "RSClipperWrapper"
  s.version       = "1.0"
  s.summary       = "A small and simple wrapper for the Clipper library to perform polygon clipping"

  s.description   = <<-DESC
					RSClipperWrapper is a small and simple wrapper for Clipper - an open source freeware library for clipping polygons - by Angus Johnson implemented in Swift 2.0. The original Clipper sources of version 6.1.2 are distributed. Clipper is fast, has no errors even on complex polygons (inclusive holes) and comes with the Boost Software License and thus is free for both open source and commerical applications.
					
					RSClipperWrapper contains two classes Polygon and Clipper for building polygons and to perform polygon clipping - union, difference, intersection & exclusive-or.
                    DESC

  s.homepage      = "https://github.com/rusty1s/RSClipperWrapper"
  s.screenshots   = "https://raw.githubusercontent.com/rusty1s/RSClipperWrapper/master/union.png", "https://raw.githubusercontent.com/rusty1s/RSClipperWrapper/master/difference.png", "https://raw.githubusercontent.com/rusty1s/RSClipperWrapper/master/intersection.png", "https://raw.githubusercontent.com/rusty1s/RSClipperWrapper/master/xor.png"

  s.license       = { :type => "MIT", :file => "LICENSE" }

  s.author        = { "Rusty1s" => "matthias.fey@tu-dortmund.de" }

  s.platform      = :ios, "8.0"

  s.source        = { :git => "https://github.com/rusty1s/RSClipperWrapper.git" }
  s.source_files  = "RSClipperWrapper/RSClipperWrapper/*.{swift,h,mm}", "RSClipperWrapper/RSClipperWrapper/*/*.{hpp,cpp}"

end
