class Metacall < Formula
  desc "MetaCall: The ultimate polyglot programming experience"
  homepage "https://metacall.io/"
  version "0.5.24"
  url "https://github.com/metacall/core/archive/refs/tags/v#{version}.zip"
  head "https://github.com/metacall/core", branch: "master"
  license "Apache-2.0"
  sha256 "04d9f1758dab409e1b1aeb279f78dca2b3b02fb1f59d8574d2457eee04b16f3e"

  depends_on "cmake" => :build
  depends_on "python@3.9"
  depends_on "node@14"
  depends_on "ruby@3.1" 

  
  def install
    system "mkdir build"
    Dir.chdir("build")
    args = std_cmake_args + %W[ 
      -Wno-dev
      -DCMAKE_BUILD_TYPE=Release
      -DOPTION_BUILD_SECURITY=OFF
      -DOPTION_FORK_SAFE=OFF
      -DOPTION_BUILD_SCRIPTS=OFF
      -DOPTION_BUILD_TESTS=OFF
      -DOPTION_BUILD_EXAMPLES=OFF
      -DOPTION_BUILD_LOADERS_PY=ON
      -DOPTION_BUILD_LOADERS_NODE=ON
      -DNodeJS_INSTALL_PREFIX=/usr/local/Cellar/metacall/#{version}
      -DOPTION_BUILD_LOADERS_JAVA=OFF
      -DOPTION_BUILD_LOADERS_JS=OFF
      -DOPTION_BUILD_LOADERS_C=OFF
      -DOPTION_BUILD_LOADERS_COB=OFF
      -DOPTION_BUILD_LOADERS_CS=OFF
      -DOPTION_BUILD_LOADERS_RB=ON
      -DOPTION_BUILD_LOADERS_TS=OFF
      -DOPTION_BUILD_PORTS=ON
      -DOPTION_BUILD_PORTS_PY=ON
      -DOPTION_BUILD_PORTS_NODE=ON
    ]
    system  "cmake", *args, ".."
    system "cmake", "--build", "." , "--target", "install"
    bin.install "metacallcli.app/Contents/MacOS/metacallcli" => "metacallcli"
  end

  test do
    system "false"
  end
end
