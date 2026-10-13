class Sochain < Formula
  desc "Command-line interface for SoChain: Bitcoin, Litecoin, Dogecoin and Zcash blockchain data"
  homepage "https://sochain.com"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.2/sochain-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a0c485ec9bff376bffd10f7b34b6f7f2853ba1040be1cbbc598cc45a503bcb4c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.2/sochain-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f9d989e2bbeeaa8a9a7d21a8f5fb013fb9673956ee164e8282aea9cc5922e5f9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.2/sochain-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "31173ecdcff978c90b4ea982cdaa2e90f27354b5128acec88d10edd84b582246"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.2/sochain-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b85a4f7e16b3a540c090222badbe2dbc80138fa9c8311c4fda1a4354e5bceb7a"
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
