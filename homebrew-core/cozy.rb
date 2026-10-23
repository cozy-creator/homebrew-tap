class Cozy < Formula
  desc "Run generative media models locally or on rented GPUs"
  homepage "https://github.com/cozy-creator/cozy-creator"
  url "https://github.com/cozy-creator/cozy-creator/archive/refs/tags/v0.11.13.tar.gz"
  sha256 "c0579a773850f9c408595849e9baae3334b13b481b582d13cfb8f03b85caf805"
  license "MIT"
  head "https://github.com/cozy-creator/cozy-creator.git", branch: "master"

  # The repository also tags TensorFS releases (tensorfs-v0.13.12).
  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/cozy")
    generate_completions_from_executable(bin/"cozy", "completion")
  end

  test do
    assert_match "cozy #{version}", shell_output("#{bin}/cozy --version")
    status = JSON.parse(shell_output("#{bin}/cozy status --json"))
    assert_equal false, status["calcifer"]["running"]
    assert_match "cozy", shell_output("#{bin}/cozy completion bash")
  end
end
