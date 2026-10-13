class Sochain < Formula
  desc "Command-line interface for SoChain: Bitcoin, Litecoin, Dogecoin and Zcash blockchain data"
  homepage "https://sochain.com"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.1/sochain-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4cb5934a7f17c266373004f1f8be98e3d95e2197a68083f3b25c024d42ddbadd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.1/sochain-cli-x86_64-apple-darwin.tar.xz"
      sha256 "d4e144284a33f8f25ba60e2f87907a6b463de304e0596084e321fbd2ceb1e22d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.1/sochain-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "495220d881b2d94450b1ad199414687eba7304611d0a82c0f8c0c28fa4e934fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.1/sochain-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ee9872f12ce2d458e2ca8799ca938fd9edce7691aeca67bd387d5444cbe98785"
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
