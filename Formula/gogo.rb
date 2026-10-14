class Gogo < Formula
  desc "Open a configured terminal workspace with one command"
  homepage "https://github.com/conorbr/gogo"
  license any_of: ["MIT", "Apache-2.0"]

  # Prebuilt binaries from the GitHub Release. Nothing to compile.
  on_macos do
    on_arm do
      url "https://github.com/conorbr/gogo/releases/download/v0.1.2/gogo-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "f3fcc649b591a5b82810f31b6c1691ba58c9eda9496f7dbdfaf946f2362bdd6d"
    end
    on_intel do
      url "https://github.com/conorbr/gogo/releases/download/v0.1.2/gogo-v0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "cb4a0eaa7706f193f443524aab00788b0d1440fd70be7ecba9aec0ed87f0f455"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conorbr/gogo/releases/download/v0.1.2/gogo-v0.1.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a96ce9b71f437ec2ca093ae4f8b886f6df280695dbe9cdca9e54ccca5c46d761"
    end
    on_intel do
      url "https://github.com/conorbr/gogo/releases/download/v0.1.2/gogo-v0.1.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cfb0cdf689f41a82083ffbf4cff82b453c832d08f5f9102f571a3bebc1a793d7"
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
