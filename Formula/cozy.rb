class Cozy < Formula
  desc "One binary: the cozy CLI, Calcifer, TensorD and TensorFS"
  homepage "https://github.com/cozy-creator/cozy-creator"
  version "0.16.11"
  if OS.mac?
    odie "Intel Macs aren't supported; cozy needs Apple Silicon" if Hardware::CPU.intel?
    if Hardware::CPU.arm?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.16.11/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "8d18325aba5573b1197a77aa9c044a24015a5bb74ca93a99dea76697747dda0c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.16.11/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0db4050e7436da13b5834739802a9a105bef6a090b2bb9e98a9ac87cdaa142e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.16.11/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3be4763639caa515e85b7b74e04fc46672193f5a59963100fe7e35ab56bdf4a9"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-pc-windows-gnu": {},
    "aarch64-unknown-linux-gnu": {},
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
