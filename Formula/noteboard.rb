class Noteboard < Formula
  desc "Kanban board for a folder of Markdown tickets, in the terminal"
  homepage "https://github.com/conorbr/noteboard"
  license "BUSL-1.1"

  # Prebuilt binaries from the GitHub Release. Nothing to compile.
  on_macos do
    on_arm do
      url "https://github.com/conorbr/noteboard/releases/download/v0.4.0/noteboard-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "470a0e852f97f6f0fb2bf5d52086d1b73b7e8f5269cf4bd454b6b6d7e69ad6c5"
    end
    on_intel do
      url "https://github.com/conorbr/noteboard/releases/download/v0.4.0/noteboard-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "5c6b41ebe51bb19841addd90c2cd3308dc8e8014f0e9929623791378c91a146b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conorbr/noteboard/releases/download/v0.4.0/noteboard-v0.4.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "27e78d37015a25e2c3082f28d391a51f086e2a5ef10feddb4a2c5a278051786c"
    end
    on_intel do
      url "https://github.com/conorbr/noteboard/releases/download/v0.4.0/noteboard-v0.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ad296281a3fed486a226d33bca13a89dd640c152f5f6d62db2d3b2cb5d20e09b"
    end
  end

  def install
    bin.install "noteboard"
    generate_completions_from_executable(bin/"noteboard", "completions")
  end

  test do
    assert_match "noteboard #{version}", shell_output("#{bin}/noteboard --version")

    system bin/"noteboard", "-C", testpath, "add", "Brew test", "--tag", "ci"
    assert_match "brew-test", shell_output("#{bin}/noteboard -C #{testpath} ls")
    assert_path_exists testpath/"brew-test.md"
  end
end
