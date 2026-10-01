class Dogechain < Formula
  desc "Command-line interface for Dogechain.com"
  homepage "https://dogechain.com"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.6.1/dogechain-cli-aarch64-apple-darwin.tar.xz"
      sha256 "21acd384e237c6022b63bf040737c3ac41c64f9667ff4536abd1f7404539dea8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.6.1/dogechain-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a535b83a1a1f3483e6420f3deba0d35374c8984d9c2b12a308c31e4b2a24ba7c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.6.1/dogechain-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "761cd8d55eee26aa4190aa66b6aeff429ec2b1966e6b317221ae88ddb465db25"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.6.1/dogechain-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "573ebbf35d88b2a6259bc7825bc45d03401ed9f0374dce7ad593dd890f8e02c2"
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
