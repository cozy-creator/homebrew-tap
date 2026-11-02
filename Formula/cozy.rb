class Cozy < Formula
  desc "One binary: the cozy CLI, Calcifer, TensorD and TensorFS"
  homepage "https://github.com/cozy-creator/cozy-creator"
  version "0.16.5"
  if OS.mac?
    odie "Intel Macs aren't supported; cozy needs Apple Silicon" if Hardware::CPU.intel?
    if Hardware::CPU.arm?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.16.5/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "df5a9645530fd940850d9905c980602c31517f3b7cdc91f3ee0b803719758937"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.16.5/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e1fa2754e9a954b5da48a0b8b54489d7b951b2a4e5dfcb735777644084e0a691"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cozy-creator/cozy-creator/releases/download/v0.16.5/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "725bda4e8c6cc04de194a421807b09cd52ce2a20b46c3eca85e8fb75a77335d7"
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
