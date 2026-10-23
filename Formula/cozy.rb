class Cozy < Formula
  desc "One binary: the cozy CLI, Calcifer, TensorD and TensorFS"
  homepage "https://github.com/cozy-creator/cozy-creator"
  version "0.11.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.11.13/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "0b40c578d154fc89edf75864c27f86c0190e188bb4db39e0604b609b992533f4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.11.13/cozy-x86_64-apple-darwin.tar.gz"
      sha256 "17f224e21edd949823ce243da1d7c5d46999c020efe79a873ae48841223bfba2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.11.13/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0196212f34e385b7bb668bf0c226c26006f072c8945d8dff107af98a0e9e6e3e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.11.13/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8bff1bf8ba2c212ce0aa5f75e4e0eef713d5fabaedf464c1c568bd6e86920182"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-pc-windows-gnu": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cozy"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cozy"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cozy"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cozy"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
