class Dogechain < Formula
  desc "Command-line interface for Dogechain.com"
  homepage "https://dogechain.com"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.2.0/dogechain-cli-aarch64-apple-darwin.tar.xz"
      sha256 "5f05919a5d40b6973c55d4bfbcf3fa54ec2eca157a416c6f428980793f57cc87"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.2.0/dogechain-cli-x86_64-apple-darwin.tar.xz"
      sha256 "d74ea1f764809e414e78104c238bddcaa47f409f31a14967a6725a8fc0ac815c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.2.0/dogechain-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b182bbe741f47e2bcc4c4aff19c899f664dc627b68a59edfa08c2d81e6a179ab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.2.0/dogechain-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f2d281cae0854313ef3811fd5bda08d8aafda51cbf4e8a3fab058c96e6944233"
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
