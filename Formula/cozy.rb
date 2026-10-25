class Cozy < Formula
  desc "One binary: the cozy CLI, Calcifer, TensorD and TensorFS"
  homepage "https://github.com/cozy-creator/cozy-creator"
  version "0.12.0"
  if OS.mac?
    odie "Intel Macs aren't supported; cozy needs Apple Silicon" if Hardware::CPU.intel?
    if Hardware::CPU.arm?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.12.0/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "e620a62c70ca027b65ba46331f43dc9242611601f80e10aea1e49aec2fee9560"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.12.0/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c01210ca8927fc945d90b098966677bf53462d5abc36e11c8edf566e46734072"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.12.0/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e8a82803f01054d8d1f53feadcc395ab7e77598101bc3f7724766f2b44a103bc"
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
