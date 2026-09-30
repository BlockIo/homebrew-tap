class Dogechain < Formula
  desc "Command-line interface for Dogechain.com"
  homepage "https://dogechain.com"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.6.0/dogechain-cli-aarch64-apple-darwin.tar.xz"
      sha256 "820576011e12bb090bd89fe049d61b096ff8145cfed118154c7854a367727978"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.6.0/dogechain-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7ab0e2b67a8552cbebde1d985ed1b034b52457470d6658b5e9a7c4dd4f294397"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.6.0/dogechain-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e4e30228460d0ac53b8db012e5f02fa375e684e81e2f9f10da06edfff6996958"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.6.0/dogechain-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "966822d593a8a8dcd5cbc110f10963c5fd74fc20fa1b6eae6cff0c5bc2f773d1"
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
