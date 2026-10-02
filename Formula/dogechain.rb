class Dogechain < Formula
  desc "Command-line interface for Dogechain.com"
  homepage "https://dogechain.com"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.7.1/dogechain-cli-aarch64-apple-darwin.tar.xz"
      sha256 "03a179e9f021076d9280c298b8da37fd78266b7c5ba5406b6da7fdc20ae0dc44"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.7.1/dogechain-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f09c3a4bc8794b2541f2cb11d13eda26a75faaed33738fbb17a550cafaa04868"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.7.1/dogechain-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3dd06676fdbb3dc2f51b4cd8570a5b32a7f873804a7de5333d4798fe8df517bd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlockIo/dogechain-cli/releases/download/v0.7.1/dogechain-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7b09f8415b8c50d0226423d3dac9680509cc8508067c3d79646780b16aadca3b"
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
