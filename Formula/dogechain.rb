class Dogechain < Formula
  desc "Command-line interface for Dogechain.com"
  homepage "https://dogechain.com"
  version "0.7.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.7.3/dogechain-cli-aarch64-apple-darwin.tar.xz"
      sha256 "8ba7f79e95723db027ee8ed23f8c70c53841146a404e5f15df67b11ea31dc7f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.7.3/dogechain-cli-x86_64-apple-darwin.tar.xz"
      sha256 "1c1e0c7ef9d3a4eb86c7721650c4fbdc516b6c773c6bd5b3de6254c9a6e9885d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.7.3/dogechain-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3c5dfefce33920e5d19af5153dfaff81f79ae2cb07f73ef6ea576ace27ca35ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.7.3/dogechain-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b733738b288b2c7c16ef0e8d70bfc092d5bdbd622e9ec49cb5a559f490f89411"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
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
      bin.install "dogechain"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dogechain"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dogechain"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dogechain"
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
