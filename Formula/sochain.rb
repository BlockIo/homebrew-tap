class Sochain < Formula
  desc "Command-line interface for SoChain: Bitcoin, Litecoin, Dogecoin and Zcash blockchain data"
  homepage "https://sochain.com"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.0/sochain-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c4a480e1b566333683fb712760b65a296cbc32c6bd5a79a8a1c040d4d059c937"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.0/sochain-cli-x86_64-apple-darwin.tar.xz"
      sha256 "eab9928fe7dca8b3c20c54a2f70942f464c1e25b3d33384194207bb93bf250df"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.0/sochain-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "62945bbb0b58bb19a32923eb2142778559112755a5d20e8342e67e6af50a3c41"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.0/sochain-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5ec4e205f873138b462baec37d454dd041e38eefd631836d70f1186546003ff7"
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
