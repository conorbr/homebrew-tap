class Gogo < Formula
  desc "Open a configured terminal workspace with one command"
  homepage "https://github.com/conorbr/gogo"
  license any_of: ["MIT", "Apache-2.0"]

  # Prebuilt binaries from the GitHub Release. Nothing to compile.
  on_macos do
    on_arm do
      url "https://github.com/conorbr/gogo/releases/download/v0.1.0/gogo-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "3ee1e4c96fd66061013fa948a45f0dbb81f98a05aa382b14ee6474e4fad46c0b"
    end
    on_intel do
      url "https://github.com/conorbr/gogo/releases/download/v0.1.0/gogo-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "7f963f8f16eb396ff0d08b504586c20d287653552f8c3094c6fc262af6b789c1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conorbr/gogo/releases/download/v0.1.0/gogo-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "56ab1ab67cd298fdb3cea4e69f9d601f459b1b87683c9d6882140c00857b2624"
    end
    on_intel do
      url "https://github.com/conorbr/gogo/releases/download/v0.1.0/gogo-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "01ffc83a3b80c5c97b03e2c1956d75b147f54203124155d26542d8e51bf64dc0"
    end
  end

  def install
    bin.install "gogo"
  end

  test do
    assert_match "gogo #{version}", shell_output("#{bin}/gogo version")

    (testpath/".config/gogo/spaces/demo.toml").write <<~TOML
      dir = "#{testpath}"

      [[tab]]
      name = "Shell"
      run = "echo hi"
    TOML
    ENV["XDG_CONFIG_HOME"] = testpath/".config"
    assert_match "run in Shell: echo hi", shell_output("#{bin}/gogo herdr demo --dry-run")
  end
end
