class Noteboard < Formula
  desc "Kanban board for a folder of Markdown tickets, in the terminal"
  homepage "https://github.com/conorbr/noteboard"
  license "MIT"

  # Prebuilt binaries from the GitHub Release. Nothing to compile.
  on_macos do
    on_arm do
      url "https://github.com/conorbr/noteboard/releases/download/v0.5.0/noteboard-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "166cd12407efb159c4beeb8f2d6161e560cf6cafb9bd0b3f6aad7de280faa057"
    end
    on_intel do
      url "https://github.com/conorbr/noteboard/releases/download/v0.5.0/noteboard-v0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "40035b2625a57f24e5e66f6197e6eeb23057b2705f75044f5b9f4d96665d0132"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conorbr/noteboard/releases/download/v0.5.0/noteboard-v0.5.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c2d0da827508e0d25503534f238156f62575dd1eb05190953a40725a26dce427"
    end
    on_intel do
      url "https://github.com/conorbr/noteboard/releases/download/v0.5.0/noteboard-v0.5.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "152f796d19e6b98a9ccaf2951b9f4ac563b125971d94daa195591723a014ba9b"
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
