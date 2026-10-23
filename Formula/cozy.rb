class Cozy < Formula
  desc "One binary: the cozy CLI, Calcifer, TensorD and TensorFS"
  homepage "https://github.com/cozy-creator/cozy-creator"
  version "0.11.14"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.11.14/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "150e3606a9793aa2d8aa5f3c3946109aa637527ebeb36f4e5b5ae8f0d8a675b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.11.14/cozy-x86_64-apple-darwin.tar.gz"
      sha256 "b5b7be12b9cf661ffee8ab816441a98aa5e04f407f6cf56ccfb32efc6115c363"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.11.14/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "90d0156162b2f4bfd4f89d26190899d897a2fc959d67ef5b3a9d6c30de79c0b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.11.14/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "430141af71cf6850c9898c00251142b41afe2ae869d4d2316b3a52884496ac98"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
