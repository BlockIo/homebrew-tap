class Sochain < Formula
  desc "Command-line interface for SoChain: Bitcoin, Litecoin, Dogecoin and Zcash blockchain data"
  homepage "https://sochain.com"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.3/sochain-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b643167eee6f98de232503f8247e62351cdaa676ad77c210f013875ed1f243b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.3/sochain-cli-x86_64-apple-darwin.tar.xz"
      sha256 "faec00bb2c5d2f1f140a1193ca6cfb731ff24db187acdba8a3f1a21b2c09913c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.3/sochain-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ebedadd09f08d6f56f410000be69c9d674a94146a93a224c2c0b98041d01f22e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.3/sochain-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8f167e479ff438583ca84e9ab5fa367778814ba702f6d1fd7cc05bd1d3063155"
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
      bin.install "sochain"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sochain"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sochain"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sochain"
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
