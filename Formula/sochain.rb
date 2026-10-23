class Sochain < Formula
  desc "Command-line interface for SoChain: Bitcoin, Litecoin, Dogecoin and Zcash blockchain data"
  homepage "https://sochain.com"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.4/sochain-cli-aarch64-apple-darwin.tar.xz"
      sha256 "771b33a0bf9ceac96f7c8f2ed21f5402d303d6704e6a2b56d51fe24da4a523f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.4/sochain-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f52cac3b695a3d37a11a70b02da4e6e84bdc82f9938b91a4dc98e5cab57e1fd4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.4/sochain-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f89263976c522c26959134916409cb9f29fd5ffc73667b795a736d5bf99ddb68"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/sochain-cli/releases/download/v0.1.4/sochain-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "beb816f6541bf6794ce78a69d7a9094740a88e95eda4f87f92ea66de2954330a"
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
