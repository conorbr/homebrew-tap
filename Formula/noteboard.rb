class Noteboard < Formula
  desc "Kanban board for a folder of Markdown tickets, in the terminal"
  homepage "https://github.com/conorbr/noteboard"
  license "MIT"

  # Prebuilt binaries from the GitHub Release. Nothing to compile.
  on_macos do
    on_arm do
      url "https://github.com/conorbr/noteboard/releases/download/v0.5.1/noteboard-v0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "c7d5c65c2a28670176ead7350a4307fd876b2bb4dfff8c16b41583862abc77ba"
    end
    on_intel do
      url "https://github.com/conorbr/noteboard/releases/download/v0.5.1/noteboard-v0.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "8586d68d7aab3676bfcba5c5d4c791d8e1ef0aaba25387a36eba22cd0a79e9f6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conorbr/noteboard/releases/download/v0.5.1/noteboard-v0.5.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "874619303b7c266f7d00b9ba62bd1de8294f41f1c623313e00fda996840c49e7"
    end
    on_intel do
      url "https://github.com/conorbr/noteboard/releases/download/v0.5.1/noteboard-v0.5.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9afab9eebf1d4d933cdfbfddc74ec88f31e93c0abbfd94ecd286b0d28bfe2be0"
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
